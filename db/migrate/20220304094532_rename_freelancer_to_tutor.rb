class RenameFreelancerToTutor < ActiveRecord::Migration[6.0]
  def change
    rename_index :freelancer_details, 'index_freelancer_details_on_user_id', 'index_tutor_details_on_user_id'
    rename_table :freelancer_details, :tutor_details
  end
end
