module Admin::InvoicesService

  def self.create_invoice(params)
    invoice = Invoice.new(params.except(:invoice_items))
    invoice.save
    Admin::InvoiceItemsService.create_multiple(params[:invoice_items], invoice.id)
    if params[:invoice_status] == "sent"
      Admin::InvoicesService.send_invoice(invoice.id)
    end
    return { message: 'Invoice has been created', status: 200 }

    rescue Stripe::StripeError => e
      return { message: e.error.message, status: 400 }
  end

  def self.update_invoice(params, invoice_id)
    Admin::InvoiceItemsService.create_multiple(params[:items_to_create], invoice_id)
    Admin::InvoiceItemsService.update_multiple(params[:items_to_update], invoice_id)
    Admin::InvoiceItemsService.delete_multiple(params[:items_to_delete])

    invoice = Invoice.find(invoice_id)
    invoice.update(invoice_status: params[:invoice_status])

    if params[:invoice_status] == "sent"
      Admin::InvoicesService.send_invoice(invoice.id)
    end

    return { message: 'Invoice has been updated', status: 200 }

    rescue Stripe::StripeError => e
      return { message: e.error.message, status: 400 }
  end

  def self.send_invoice(id)
    invoice = Invoice.find(id)
    user = invoice.project.client_detail.user

    stripe_customer_id = user.client_detail.stripe_customer_id
    customer = Stripe::Customer.retrieve(stripe_customer_id)
    invoice.invoice_items.each do |invoice_item|
      Stripe::InvoiceItem.create({
        customer: customer.id,
        amount: (invoice_item.price * invoice_item.qty * 100).round,
        currency: "usd",
        description: invoice_item.item,
      })
    end
    stripe_invoice = Admin::StripeService.create_invoice(customer.id)
    Admin::NotificationsService.notify_about_new_invoice(invoice, user)
    invoice.update(invoice_ID: stripe_invoice.id, invoice_status: "sent")
  end

  def self.charge_client(invoice_id)
    invoice = Invoice.find(invoice_id)

    invoice_paid = Stripe::Invoice.pay(invoice.invoice_ID, expand: ["charge.balance_transaction"])
    if invoice_paid.paid
      invoice.update(invoice_status: "paid")
    end

    invoice.invoice_items.each do |invoice_item|
      if !invoice_item.time_entry.nil?
        invoice_item.time_entry.update(invoiced: true)
      end
    end

    user = invoice.project.client_detail.user

    Admin::PaymentsService.create_charge(invoice_paid, user)
    return { message: "Client has been charged", status: 200 }

    rescue Stripe::StripeError => e
      error_message = e.error.message
      if e.error.decline_code == 'insufficient_funds'
        error_message = 'Client card has insufficient funds.'
      elsif e.error.decline_code == 'generic_decline'
        error_message = 'Client card was declined.'
      end

      invoice.update(error_message: error_message, invoice_status: "error")
      return { message: error_message, status: 400 }
  end

end
