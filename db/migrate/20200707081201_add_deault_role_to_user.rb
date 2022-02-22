class AddDeaultRoleToUser < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :role, :integer, :default => 1
  end
  
  def down
    change_column :users, :role, :integer
  end
end
