class CreateFreelancersProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :freelancers_projects do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.string :description
      t.string :project_duration
      t.integer :amount
      t.datetime :start_date
      t.integer :type_of_billing
      t.integer :payment_schedule
      t.integer :project_status

      t.timestamps
    end
  end
end
