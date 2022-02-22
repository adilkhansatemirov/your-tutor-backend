module Admin
  class GenerateInvoiceJob < ApplicationJob
    queue_as :default

    def perform(project_id, invoicing_interval)
      project = Project.find(project_id)

      if !project.automated_invoicing or project.project_status == 'inactive'
        return
      end

      time_entries = TimeEntry
                         .joins(:timesheet)
                         .where(timesheets: { project_id: project.id, timesheet_status: [:approved, :paid] })
                         .where(invoiced: false)

      time_entries_for_invoice = []
      time_entries.each do |time_entry|
        unless InvoiceItem.where(time_entry_id: time_entry.id).exists?
          time_entries_for_invoice.push(time_entry)
        end
      end

      if time_entries_for_invoice.count > 0
        invoice = Invoice.create(project_id: project.id, invoice_date: DateTime.now, invoice_status: :sent)

        user = project.client_detail.user
        stripe_customer_id = user.client_detail.stripe_customer_id
        customer = Stripe::Customer.retrieve(stripe_customer_id)

        invoice_items = []
        time_entries_for_invoice.each do |time_entry|
          Stripe::InvoiceItem.create({
              customer: customer.id,
              amount: (project.client_payment_amount * time_entry.hours * 100).round,
              currency: 'usd',
              description: time_entry.task
          })
          invoice_items << InvoiceItem.new(
              invoice_id: invoice.id,
              item: time_entry.task,
              qty: time_entry.hours,
              price: project.client_payment_amount,
              time_entry_id: time_entry.id
          )
        end

        stripe_invoice = Admin::StripeService.create_invoice(customer.id)
        Admin::NotificationsService.notify_about_new_invoice(invoice, user)
        invoice.update(invoice_ID: stripe_invoice.id)

        InvoiceItem.import invoice_items,
                           on_duplicate_key_update: { conflict_target: [],
                                                      columns: [:invoice_id, :item, :qty, :price, :time_entry_id] }
      end

      Admin::GenerateInvoiceJob.set(wait: invoicing_interval).perform_later(project_id, invoicing_interval)
    end

  end

end
