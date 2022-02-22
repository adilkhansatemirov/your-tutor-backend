class ChangeTimesheetsRemove < ActiveRecord::Migration[6.0]
  def change
    remove_column :timesheets, :user_id, :bigint
    remove_column :timesheets, :description, :string
    remove_column :timesheets, :hours, :integer
    remove_column :timesheets, :submited, :boolean, default: false
    add_column :timesheets, :notes, :text
  end
end
