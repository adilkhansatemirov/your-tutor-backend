module Student::StudentDetailsService

  def self.connect_card(params, user)
    # customer = Stripe::Customer.create(email: user.email, source: params[:token_id])
    student_detail = StudentDetail.where(user_id: user.id)
    student_detail.update(stripe_customer_id: "test")
  end

  def self.connect_bank(params, user)
    # public_token = params[:public_token]
    # account_id = params[:account_id]

    # bank_account_token = Student::StripeService.create_bank_account_token(public_token, account_id)
    # customer = Stripe::Customer.create(email: user.email, source: bank_account_token)
    student_detail = StudentDetail.where(user_id: user.id)

    student_detail.update(stripe_customer_id: "test")
  end

end
