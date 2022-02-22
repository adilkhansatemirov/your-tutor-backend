class ChangeConstraintsProjects < ActiveRecord::Migration[6.0]
  def up
    change_column :project_bids, :freelancer_project_id, :bigint, :null => true
    change_column :timesheets, :freelancer_project_id, :bigint, :null => true
    change_column :invoices, :client_project_id, :bigint, :null => true

    remove_index :project_bids, column: [:user_id, :freelancer_project_id]
    add_index :project_bids, [:user_id, :project_id], unique: true, :name => "add_unique_columns_project"
  end

  def down
    change_column :project_bids, :freelancer_project_id, :bigint, :null => false
    change_column :timesheets, :freelancer_project_id, :bigint, :null => false
    change_column :invoices, :client_project_id, :bigint, :null => false

    add_index :project_bids, [:user_id, :freelancer_project_id], unique: true, :name => "add_unique_columns_freelancer_project"
    remove_index :project_bids, column: [:user_id, :project_id]
  end
end
