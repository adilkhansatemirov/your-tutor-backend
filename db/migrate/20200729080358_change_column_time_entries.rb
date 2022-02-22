class ChangeColumnTimeEntries < ActiveRecord::Migration[6.0]
  def change
    remove_column :time_entries, :contract_id, null: false
    add_reference :time_entries, :timesheet, index: true
  end
end
