class AddNameContractToContracts < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :title, :string
    add_column :contracts, :subtitle, :string
  end
end
