class UpdateContracts < ActiveRecord::Migration[6.0]
  def change
    remove_column :contracts, :contract_type, :integer
    remove_column :contracts, :start_at, :datetime
    remove_column :contracts, :freelancer_id, :bigint
    remove_column :contracts, :subtitle, :string
    remove_column :contracts, :cost, :integer
    
    rename_column :contracts, :hours, :amount
  end
end
