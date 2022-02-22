class Admin::ClientDetailBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id,
         :company_name

  field :user do |client_detail|
    {
      id: client_detail.user.id,
      email: client_detail.user.email,
      first_name: client_detail.user.first_name,
      last_name: client_detail.user.last_name,
      is_blocked: client_detail.user.is_blocked,
    }
  end

  # custom
  field :has_payment_info do |client_detail|
    !client_detail.stripe_customer_id.nil?
  end

  field :profile_status do |client_detail|
    if client_detail.user.is_blocked?
      "blocked"
    elsif client_detail.stripe_customer_id.nil?
      "incomplete"
    else
      "complete"
    end
  end
end
