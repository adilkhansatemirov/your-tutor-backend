class AddUniqInvoiceItem < ActiveRecord::Migration[6.0]
  def change
    add_index :invoice_items, [:invoice_id, :item, :qty, :price, :time_entry_id ], unique: true, :name => 'add_uniq_invoice_items_time_entry'
  end
end
