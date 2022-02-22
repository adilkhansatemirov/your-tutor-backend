class DropClientFreelancerProjects < ActiveRecord::Migration[6.0]
  def up
    remove_reference :client_projects, :user, index: true, foreign_key: true
    remove_reference :freelancer_projects, :user, index: true, foreign_key: true
    remove_reference :freelancer_projects, :client_project, index: true, foreign_key: true
  end

  def down
    add_reference :client_projects, :user, index: true, foreign_key: true
    add_reference :freelancer_projects, :user, index: true, foreign_key: true
    add_reference :freelancer_projects, :client_project, index: true, foreign_key: true, null: false
  end
end
