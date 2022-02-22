class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date_created
      t.string :description
      t.integer :contract_type
      t.integer :hours
      t.integer :cost
      t.integer :contract_status
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
