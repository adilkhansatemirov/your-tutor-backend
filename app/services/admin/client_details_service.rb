module Admin::ClientDetailsService

  def self.create_client(params)
    generated_password = Devise.friendly_token.first(8)
    user = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: generated_password,
      role: "client",
    )
    ClientDetail.create(user_id: user.id, company_name: params[:company_name])
    AllowedNotification.create(
      user_id: user.id,
      new_opportunity_available: false,
      project_bid_accepted: false,
      timesheet_rejected: false,
      new_timesheet_submitted: false,
      new_invoice_submitted: true,
      new_freelancer_signed_up: false,
    )
    ClientNotifierMailer.send(user.email, "")
  end

end
