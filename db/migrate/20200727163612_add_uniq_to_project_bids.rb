class AddUniqToProjectBids < ActiveRecord::Migration[6.0]
  def change
    add_index :project_bids, [:user_id, :contract_id], unique: true, :name => 'add_unique_columns_user_contract'
  end
end 