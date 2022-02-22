class RemoveInvoicedFromTimesheet < ActiveRecord::Migration[6.0]
  def change
    remove_column :timesheets, :invoiced, :boolean, :default => false
  end
end
