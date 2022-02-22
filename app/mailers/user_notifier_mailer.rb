require 'sendgrid-ruby'
include SendGrid

class UserNotifierMailer < ActionMailer::Base
  FROM_EMAIL = ENV['SENDGRID_FROM_EMAIL']
  API_KEY = ENV['SENDGRID_API_KEY']

  def self.send(to, activation_code)
    data = {
      "personalizations": [
          {
          "to": [
            {
              "email": to
            }
          ],
          "substitutions": {
            "-activation_code-": activation_code
          },
          "subject": "InHome Accountants Verification Code"
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
            <body style="text-align:center; font-family:sans-serif; width:430px; margin:0 auto">
              <img src="http://idylle.maskandesign.com/red/logo_lg.png" style="width:140px; margin:20px 0 0">
              <hr style="height: 1px; background-color:#eee; border:0; margin:20px 0">
              <header>
                <h2 style="margin:0 0 10px; color:#032c5c; font-size:40px;">Welcome to InHome Accountants!</h2>
              </header>
              <div style="color:#868686">
                Please enter the following verification code to complete your registration:
                  <p style="color:#1d1c1d; font-size:50px; margin:20px 0; font-weight: bold">-activation_code-</p>
              </div>
              <hr style="height: 1px; background-color:#eee; border:0; margin:20px 0">
              <footer>
                <h3>Thanks for joining us!</h3>
              </footer>
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