class AddClientsToContract < ActiveRecord::Migration[6.0]
  def change
    add_reference :contracts, :client, foreign_key: { to_table: 'users' }
    add_column :contracts, :project_status, :boolean, :default => true
    add_column :contracts, :invoicing_schedule, :integer 
  end
end
