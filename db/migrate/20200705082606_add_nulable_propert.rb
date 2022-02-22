class AddNulablePropert < ActiveRecord::Migration[6.0]
  def up
    change_column :contracts, :user_id, :bigint, :null => true
    change_column :timesheets, :user_id, :bigint, :null => true
  end

  def down
    change_column :contracts, :user_id, :bigint, :null => false
    change_column :timesheets, :user_id, :bigint, :null => false
  end
end
