class AddColumnAvailableOnToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :available_on, :datetime
  end
end
