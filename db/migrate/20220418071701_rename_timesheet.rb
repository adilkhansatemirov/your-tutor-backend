class RenameTimesheet < ActiveRecord::Migration[6.0]
  def change
    rename_column :timesheets, :freelancer_id, :tutor_id
  end
end
