class RenameFreelancerSkillsToTutorSkills < ActiveRecord::Migration[6.0]
  def change
    rename_index :freelancer_skills, 'index_freelancer_skills_on_skill_id', 'index_tutor_skills_on_skill_id'
    rename_index :freelancer_skills, 'add_unique_columns_freelancer_skills', 'add_unique_columns_tutor_skills'
    rename_index :freelancer_skills, 'index_freelancer_skills_on_user_id', 'index_tutor_skills_on_user_id'
    rename_table :freelancer_skills, :tutor_skills
  end
end
