class AddUniqToTimeEtiesUpload < ActiveRecord::Migration[6.0]
  def change
    add_index :time_entries, [:user_id, :timesheet_id, :notes, :hours], unique: true, :name => 'add_unique_columns_time_entriesg'
  end
end
