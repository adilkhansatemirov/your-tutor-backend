class AddColumnAllowedNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :allowed_notifications, :new_freelancer_signed_up, :boolean, default: true
  end
end
