class CreateInvoiceDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_details do |t|
      t.references :user, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.string :item
      t.integer :qty
      t.integer :price

      t.timestamps
    end
  end
end
