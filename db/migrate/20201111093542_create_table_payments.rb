class CreateTablePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer "payment_type"
      t.decimal "net_amount", null: false, precision: 7, scale: 2
      t.decimal "full_amount", null: false, precision: 7, scale: 2
      t.decimal "stripe_fee", null: false, precision: 7, scale: 2
      t.string "description"

      t.timestamps
    end
  end
end
