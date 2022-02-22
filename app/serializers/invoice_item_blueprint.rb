class InvoiceItemBlueprint < Blueprinter::Base
  identifier :id

  fields :item,
         :qty,
         :price,
         :time_entry_id,
         :invoice_id,
         :created_at,
         :updated_at
end
