class AddSubmitedToTimesheets < ActiveRecord::Migration[6.0]
  def change
    add_column :timesheets, :submited, :boolean, :default => false
  end
end
