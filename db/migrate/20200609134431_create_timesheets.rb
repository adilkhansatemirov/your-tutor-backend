class CreateTimesheets < ActiveRecord::Migration[6.0]
  def change
    create_table :timesheets do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.integer :hours
      t.integer :timesheet_status

      t.timestamps
    end
  end
end
