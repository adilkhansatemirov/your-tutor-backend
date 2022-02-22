class ChangeTimeEntryUserIdToNullable < ActiveRecord::Migration[6.0]
  def change
    change_column :time_entries, :user_id, :bigint, null: true
  end
end
