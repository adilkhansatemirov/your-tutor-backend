class AddColumnsLegacyUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_legacy_user, :boolean, default: false
    add_column :users, :is_password_set, :boolean, default: true
  end
end
