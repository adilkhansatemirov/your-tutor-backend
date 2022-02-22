class Client::InvoiceBlueprint < Blueprinter::Base
  identifier :id
  
  fields :invoice_date,
         :invoice_status,
         :project_id

  field :amount do |invoice|
    invoice.invoice_items.sum {|invoice_item| invoice_item.qty * invoice_item.price}
  end

  field :project do |invoice|
    {
      title: invoice.project.title,
      invoicing_schedule: invoice.project.invoicing_schedule,
      client_type_of_billing: invoice.project.client_type_of_billing,
      client_payment_amount: invoice.project.client_payment_amount,
      freelancer_detail: {
        user: {
          first_name: invoice.project.freelancer_detail.user.first_name,
          last_name: invoice.project.freelancer_detail.user.last_name,
          email: invoice.project.freelancer_detail.user.email
        }
      }
    }
  end

  view :extended do
    association :invoice_items, blueprint: InvoiceItemBlueprint
  end
end
