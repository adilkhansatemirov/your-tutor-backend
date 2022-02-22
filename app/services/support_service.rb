module SupportService

  def self.send_email_to_admin(params)
    admins = User.admin
    admins.each do |admin|
      email = {
        address: admin[:email],
        user_role: "admin",
        subject: "Support request from #{params[:email]}: #{params[:subject]}",
        text: params[:message],
      }
      Mailer.send(email)
    end
  end

end
