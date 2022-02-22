class ChangedProjectBids < ActiveRecord::Migration[6.0]
  def change
    remove_column :project_bids, :contract_id, :bigint
    add_reference :project_bids, :freelancers_project, null: false, index: true
  end
end
