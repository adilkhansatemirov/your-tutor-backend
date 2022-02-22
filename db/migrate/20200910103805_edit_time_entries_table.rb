class EditTimeEntriesTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :time_entries, :notes, :task
    add_column :time_entries, :customer, :string, null:true
    rename_index :time_entries, 'add_unique_columns_time_entriesg', 'add_unique_columns_time_entries'
  end
end
