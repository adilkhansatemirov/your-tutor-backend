class AddStripeCustomerIdToClientDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :client_details, :stripe_customer_id, :string, :default => nil
    users = User.where(role: 'client')
    users.map do |user|
      payment_method = PaymentMethod.where(user_id: user.id).last
      if payment_method
        stripe_token = payment_method.stripe_token
        user.client_detail.update_column(:stripe_customer_id, stripe_token)
      end
    end
  end
end
