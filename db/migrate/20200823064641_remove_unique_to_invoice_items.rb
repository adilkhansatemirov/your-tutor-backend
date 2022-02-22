class RemoveUniqueToInvoiceItems < ActiveRecord::Migration[6.0]
  def change
    remove_index :invoice_items, [:invoice_id, :item, :qty, :price, :time_entry_id ]
  end
end
