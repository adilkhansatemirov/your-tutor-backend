class AddConnectedAccountId < ActiveRecord::Migration[6.0]
  def change
    add_column :freelancer_details, :connected_account_id, :string
  end
end
