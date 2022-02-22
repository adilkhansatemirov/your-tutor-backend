class CreateProjectBids < ActiveRecord::Migration[6.0]
  def change
    create_table :project_bids do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contract, null: false, foreign_key: true
      t.integer :compensation
      t.integer :bids_status

      t.timestamps
    end
  end
end
