class ChangeQtyColumnToDecimal < ActiveRecord::Migration[6.0]
  def change
    change_column :invoice_items, :qty, :decimal, :precision => 6, :scale => 2, null: false
  end
end
