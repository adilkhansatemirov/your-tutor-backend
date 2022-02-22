class RenameTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :freelacer_details, :freelancer_details
    rename_table :freelacer_skills, :freelancer_skills
  end
end
