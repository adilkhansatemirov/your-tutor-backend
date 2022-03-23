class RenameProjectColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :client_detail_id, :student_detail_id
    rename_column :projects, :client_type_of_billing, :student_type_of_billing
    rename_column :projects, :client_payment_amount, :student_payment_amount
    rename_column :projects, :freelancer_detail_id, :tutor_detail_id
    rename_column :projects, :freelancer_payment_amount, :tutor_payment_amount
  end
end
