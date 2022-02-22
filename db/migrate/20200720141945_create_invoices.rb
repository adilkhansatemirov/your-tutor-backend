class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.references :contract, null: false, foreign_key: true
      t.date :invoice_date
      t.integer :invoice_amount
      t.timestamps
    end
  end
end
