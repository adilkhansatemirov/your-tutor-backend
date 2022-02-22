class AddInvoiceIdToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :invoice_ID, :string
  end
end
