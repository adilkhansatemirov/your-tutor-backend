module Client::ClientDetailsService

  def self.connect_card(params, user)
    customer = Stripe::Customer.create(email: user.email, source: params[:token_id])
    client_detail = ClientDetail.where(user_id: user.id)
    client_detail.update(stripe_customer_id: customer["id"])
  end

  def self.connect_bank(params, user)
    public_token = params[:public_token]
    account_id = params[:account_id]

    bank_account_token = Client::StripeService.create_bank_account_token(public_token, account_id)
    customer = Stripe::Customer.create(email: user.email, source: bank_account_token)
    client_detail = ClientDetail.where(user_id: user.id)

    client_detail.update(stripe_customer_id: customer["id"])
  end

end
