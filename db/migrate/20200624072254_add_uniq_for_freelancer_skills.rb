class AddUniqForFreelancerSkills < ActiveRecord::Migration[6.0]
  def change
    add_index :freelacer_skills, [:user_id, :skill_id], unique: true, :name => 'add_unique_columns_freelancer_skills'
  end
end
