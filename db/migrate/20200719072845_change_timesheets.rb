class ChangeTimesheets < ActiveRecord::Migration[6.0]
  def change
    add_column :timesheets, :timesheet_date, :date
  end
end
