class ChangeContract < ActiveRecord::Migration[6.0]
  def change
    remove_column :contracts, :user_id, :bigint
    remove_column :contracts, :end_at, :datetime
    remove_column :contracts, :project_status, :boolean, :default => true
    rename_column :contracts, :contract_status, :project_status
    add_column :contracts, :type_of_billing, :integer
    add_reference :contracts, :freelancer, foreign_key: { to_table: 'users' }
  end
end
