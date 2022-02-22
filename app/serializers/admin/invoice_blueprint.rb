class Admin::InvoiceBlueprint < Blueprinter::Base
  identifier :id
  
  fields :invoice_date,
         :invoice_status,
         :error_message

  field :amount do |invoice|
    invoice.invoice_items.sum {|invoice_item| invoice_item.qty * invoice_item.price}
  end

  association :project, blueprint: Admin::ProjectBlueprint

  view :extended do
    association :invoice_items, blueprint: InvoiceItemBlueprint
  end

end
