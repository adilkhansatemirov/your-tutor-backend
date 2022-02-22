class AddErrorMessageToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, "error_message", :string
  end
end
