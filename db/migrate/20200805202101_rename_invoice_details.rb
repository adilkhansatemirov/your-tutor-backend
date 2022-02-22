class RenameInvoiceDetails < ActiveRecord::Migration[6.0]
  def change
    rename_table :invoice_details, :invoice_items
  end
end
