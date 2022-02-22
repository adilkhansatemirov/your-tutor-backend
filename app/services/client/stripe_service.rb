module Client::StripeService

  def self.create_bank_account_token(public_token, account_id)
    client = Plaid::Client.new(env: ENV["PLAID_HOST"],
                               client_id: ENV["PLAID_CLIENT_ID"],
                               secret: ENV["PLAID_SECRET"])

    exchange_token_response = client.item.public_token.exchange(public_token)
    access_token = exchange_token_response["access_token"]
    stripe_response = client.processor.stripe.bank_account_token.create(access_token, account_id)
    stripe_response["stripe_bank_account_token"]
  end

end
