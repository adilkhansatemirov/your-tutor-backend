class Client::ProjectBlueprint < Blueprinter::Base
  identifier :id

  fields :title,
         :project_status,
         :client_payment_amount

  view :extended do
    association :client_detail, blueprint: Admin::ClientDetailBlueprint

    fields :description,
           :project_duration,
           :invoicing_schedule,
           :client_type_of_billing,
           :error_message,
           :is_created_by_client

    field :invoices do |project|
      invoices = []
      project.invoices.where.not(invoice_status: 'draft').order(updated_at: :desc).each do |invoice|
        amount = 0
        invoice.invoice_items.each do |item|
          amount += item.qty * item.price
        end
        invoices.push({
          id: invoice.id,
          invoice_date: invoice.invoice_date,
          invoice_status: invoice.invoice_status,
          invoice_amount: amount,
        })
      end
      invoices
    end
  end

end
