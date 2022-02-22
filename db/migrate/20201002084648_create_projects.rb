class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string "title"
      t.string "description"
      t.string "project_duration"
      t.integer "project_status"
      t.integer "invoicing_schedule"
      t.integer "client_type_of_billing"
      t.integer "freelancer_type_of_billing"
      t.decimal "client_payment_amount", null: false, precision: 7, scale: 2
      t.decimal "freelancer_payment_amount", null: false, precision: 7, scale: 2
      t.references "freelancer_detail", foreign_key: true
      t.references "client_detail", foreign_key: true
      t.timestamps
    end

    add_reference :invoices, :project, index: true
    add_reference :timesheets, :project, index: true
    add_reference :project_bids, :project, index: true
  end
end
