class Admin::StudentDetailBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id,
         :company_name

  field :user do |student_detail|
    {
      id: student_detail.user.id,
      email: student_detail.user.email,
      first_name: student_detail.user.first_name,
      last_name: student_detail.user.last_name,
      is_blocked: student_detail.user.is_blocked,
    }
  end

  # custom
  field :has_payment_info do |student_detail|
    !student_detail.stripe_customer_id.nil?
  end

  field :profile_status do |student_detail|
    if student_detail.user.is_blocked?
      "blocked"
    elsif student_detail.stripe_customer_id.nil?
      "incomplete"
    else
      "complete"
    end
  end
end
