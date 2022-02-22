class InvoiceBlueprint < Blueprinter::Base
  identifier :id

  fields :invoice_date,
         :invoice_status

  field :project do |invoice|
    {
      id: invoice.project.id,
      client_detail: {
        company_name: invoice.project.client_detail.company_name,
        user: {
          id: invoice.project.client_detail.user.id,
          email: invoice.project.client_detail.user.email,
          first_name: invoice.project.client_detail.user.first_name,
          last_name: invoice.project.client_detail.user.last_name,
        },
      },
    }
  end
  association :invoice_items, blueprint: InvoiceItemBlueprint
end
