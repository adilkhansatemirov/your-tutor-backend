class ChangeHoursColumnToDecimal < ActiveRecord::Migration[6.0]
  def up
    change_column :time_entries, :hours, :decimal, :precision => 6, :scale => 2, null: false
  end

  def down
    change_column :time_entries, :hours, :integer
  end
end
