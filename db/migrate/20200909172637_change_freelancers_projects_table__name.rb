class ChangeFreelancersProjectsTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :freelancers_projects, :freelancer_projects
    rename_column :project_bids, :freelancers_project_id, :freelancer_project_id
    rename_column :timesheets, :freelancers_project_id, :freelancer_project_id
    rename_index :project_bids, 'add_unique_columns_freelancers_project', 'add_unique_columns_freelancer_project'
  end
end
