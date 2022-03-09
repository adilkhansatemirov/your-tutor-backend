class RenameNotifications < ActiveRecord::Migration[6.0]
  def change
    rename_column :allowed_notifications, :new_freelancer_signed_up, :new_tutor_signed_up
  end
end
