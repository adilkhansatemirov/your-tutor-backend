class RemoveUniqueConstraintOnTimeEntries < ActiveRecord::Migration[6.0]
  def up
    remove_index :time_entries, name: "add_unique_columns_time_entries"
  end

  def down
    add_index :time_entries, [:user_id, :timesheet_id, :task, :hours], unique: true, name: "add_unique_columns_time_entries"
  end
end
