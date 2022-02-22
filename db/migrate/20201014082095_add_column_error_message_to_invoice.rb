class AddColumnErrorMessageToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :error_message, :string, null: true
  end
end
