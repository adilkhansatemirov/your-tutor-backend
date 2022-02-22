module Admin::StripeService

  def self.create_transfer(total, connected_account_id)
    Stripe::Transfer.create({
      amount: total,
      currency: "usd",
      destination: connected_account_id,
      expand: ["balance_transaction"],
    })
  end

  def self.create_invoice(customer_id)
    Stripe::Invoice.create({
      customer: customer_id,
      auto_advance: false,
    })
  end

end
