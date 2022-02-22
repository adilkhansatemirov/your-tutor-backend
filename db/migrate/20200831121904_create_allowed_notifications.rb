class CreateAllowedNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :allowed_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :new_opportunity_available, default: false
      t.boolean :project_bid_accepted, default: false
      t.boolean :timesheet_rejected, default: false
      t.boolean :new_timesheet_submitted, default: false
      t.boolean :new_invoice_submitted, default: false

      t.timestamps
    end
  end
end
