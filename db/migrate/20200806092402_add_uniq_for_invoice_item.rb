class AddUniqForInvoiceItem < ActiveRecord::Migration[6.0]
  def change
    add_index :invoice_items, [:user_id, :invoice_id, :item, :qty, :price], unique: true, :name => 'add_unique_columns_invoice_items'
  end
end
