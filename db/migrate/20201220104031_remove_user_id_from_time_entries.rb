class RemoveUserIdFromTimeEntries < ActiveRecord::Migration[6.0]
  def up
    remove_column :time_entries, :user_id, :bigint, index: true
  end

  def down
    add_reference :time_entries, :user, index: true
    add_foreign_key :time_entries, :users
  end
end
