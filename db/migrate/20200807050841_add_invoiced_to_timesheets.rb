class AddInvoicedToTimesheets < ActiveRecord::Migration[6.0]
  def change
    add_column :timesheets, :invoiced, :boolean, :default => false
  end
end
