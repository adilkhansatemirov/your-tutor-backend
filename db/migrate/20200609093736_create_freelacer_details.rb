class CreateFreelacerDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :freelacer_details do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :contract_signed_date
      t.datetime :form_1099_signed_date
      t.datetime :background_check_passed

      # background check
      t.string :candidate_id
      t.string :report_id
      t.string :status
      t.string :ip_address
      
      t.timestamps
    end
  end
end
