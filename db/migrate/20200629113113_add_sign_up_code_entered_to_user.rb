class AddSignUpCodeEnteredToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sign_up_code_entered, :boolean, :default => false
  end
end
