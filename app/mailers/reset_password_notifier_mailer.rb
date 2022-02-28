require 'sendgrid-ruby'
include SendGrid

class ResetPasswordNotifierMailer < ActionMailer::Base
  default :from => 'any_from_address@example.com'
  FROM_EMAIL = ENV['SENDGRID_FROM_EMAIL']
  API_KEY = ENV['SENDGRID_API_KEY']
  FRONTEND_HOST = ENV['FRONTEND_HOST']

  def self.send(to, activation_code)
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    user = User.find_by(email: to)
    user.reset_password_token = raw
    user.reset_password_sent_at = Time.now.utc
    user.save

    data = {
      "personalizations": [
          {
          "to": [
            {
              "email": to
            }
          ],
          "substitutions": {
            "-activation_code-": "#{FRONTEND_HOST}/reset-password?token=#{raw}" 
          },
          "subject": "InHome accountants password reset"
          }
        ],
        "from": {
        "email": FROM_EMAIL,
        "name": "InHome Accountants"
      },
      "content": [
        {
          "type": "text/html",
          "value": '<html>
            <head></head>
            <body style="text-align:center; font-family:sans-serif; width:630px; margin:0 auto">
              <img src="http://idylle.maskandesign.com/red/logo_lg.png" style="width:140px; margin:20px 0 0">
              <hr style="height: 1px; background-color:#eee; border:0; margin:20px 0">
              <div style="color:#868686;">
                <p style="color:#1d1c1d; font-size:20px; margin:5px 0;"> Please follow the link to reset your password: </p>
                <p style="color:#1d1c1d; font-size:25px; margin:20px 0; font-weight: bold">
                  <a href="-activation_code-" target="_blank">
                    -activation_code-
                  </a>                    
                </p>
              </div>
              <hr style="height: 1px; background-color:#eee; border:0; margin:20px 0">
            </body>
          </html>'
        }
      ]
    }

    sg = SendGrid::API.new(api_key: API_KEY)
    begin
      response = sg.client.mail._("send").post(request_body: data)
      return response.status_code
    rescue Exception => e
      puts e.message
    end
  end
end