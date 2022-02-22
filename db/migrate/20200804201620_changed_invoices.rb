class ChangedInvoices < ActiveRecord::Migration[6.0]
  def change
    rename_column :invoices, :invoice_amount, :invoice_status
  end
end
