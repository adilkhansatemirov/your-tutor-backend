class Admin::PaymentBlueprint < Blueprinter::Base
  identifier :id

  fields :payment_type,
         :net_amount,
         :full_amount,
         :stripe_fee,
         :description,
         :created_at,
         :updated_at

  field :status do |payment|
    if payment.available_on && payment.available_on.future?
      'pending'
    else
      'completed'
    end
  end
end
