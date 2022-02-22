class DropClientFreelancerTables < ActiveRecord::Migration[6.0]
  def up
    drop_table :client_projects
    drop_table :freelancer_projects
  end

  def down
    create_table "client_projects" do |t|
      t.datetime "date_created"
      t.string "description"
      t.integer "amount"
      t.integer "project_status"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "title"
      t.integer "invoicing_schedule"
      t.integer "type_of_billing"
    end

    create_table "freelancer_projects" do |t|
      t.string "title"
      t.string "description"
      t.string "project_duration"
      t.integer "amount"
      t.datetime "start_date"
      t.integer "type_of_billing"
      t.integer "payment_schedule"
      t.integer "project_status"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
