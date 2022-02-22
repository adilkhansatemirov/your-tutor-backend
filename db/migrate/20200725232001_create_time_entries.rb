class CreateTimeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contract, null: false, foreign_key: true
      t.string :notes
      t.integer :hours
      
      t.timestamps
    end
  end
end
