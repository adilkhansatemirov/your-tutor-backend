class AddUniqToProjectBidsForFreelancerProject < ActiveRecord::Migration[6.0]
  def change
    add_index :project_bids, [:user_id, :freelancers_project_id], unique: true, :name => 'add_unique_columns_freelancers_project'
  end
end
