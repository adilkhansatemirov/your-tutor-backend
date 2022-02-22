class AddNewProperty < ActiveRecord::Migration[6.0]
  def change 
    remove_column :users, :activate, :boolean
    remove_column :users, :sign_up_code, :string
    remove_column :users, :sign_up_code_entered, :boolean, default: false
    remove_column :users, :finished_all_steps, :boolean, default: false
    add_column :freelacer_details, :sign_up_code, :string
    add_column :freelacer_details, :sign_up_code_entered, :boolean, default: false
    add_column :freelacer_details, :interview_scheduled, :boolean, default: false
    add_column :freelacer_details, :quilified, :boolean,  default: false
  end
end
