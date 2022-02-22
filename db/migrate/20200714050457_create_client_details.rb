class CreateClientDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :client_details do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.boolean :all_checked, default: false
      
      t.timestamps
    end
  end
end
