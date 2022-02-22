class ChangeTimesheet < ActiveRecord::Migration[6.0]
  def change
    remove_column :timesheets, :contract_id, :bigint
    add_reference :timesheets, :freelancers_project, null: false, index: true
  end
end
