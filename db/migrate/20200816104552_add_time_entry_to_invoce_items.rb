class AddTimeEntryToInvoceItems < ActiveRecord::Migration[6.0]
  def change
    add_column :time_entries, :invoiced, :boolean, :default => false
    add_reference :invoice_items, :time_entry, foreign_key: true
    remove_column :invoice_items, :user_id, :bigint
  end
end
