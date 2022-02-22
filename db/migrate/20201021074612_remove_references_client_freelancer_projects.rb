class RemoveReferencesClientFreelancerProjects < ActiveRecord::Migration[6.0]
  def up
    remove_reference :invoices, :client_project, index: true, foreign_key: true
    remove_reference :timesheets, :freelancer_project, index: true
    remove_reference :project_bids, :freelancer_project, index: true
  end

  def down
    add_reference :invoices, :client_project, index: true, foreign_key: true
    add_reference :timesheets, :freelancer_project, index: true
    add_reference :project_bids, :freelancer_project, index: true
  end
end
