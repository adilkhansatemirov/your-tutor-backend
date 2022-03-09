class RenameClientToStudent < ActiveRecord::Migration[6.0]
  def change
    rename_index :client_details, 'index_client_details_on_user_id', 'index_student_details_on_user_id'
    rename_table :client_details, :student_details
  end
end
