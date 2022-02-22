class AddFinishToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :finished_all_steps, :boolean, :default => false
  end
end
