require 'sendgrid-ruby'
include SendGrid

class Mailer < ActionMailer::Base
  default :from => 'any_from_address@example.com'
  FROM_EMAIL = ENV['SENDGRID_FROM_EMAIL']
  API_KEY = ENV['SENDGRID_API_KEY']
  FRONTEND_HOST = ENV['FRONTEND_HOST']

  def self.send(email)
    data = {
      "personalizations": [
          {
          "to": [
            {
              "email": email[:address]
            }
          ],
          "subject": email[:subject]
          }
        ],
        "from": {
        "email": FROM_EMAIL,
        "name": "InHome Accountants"
      },
      "content": [
        {
          "type": "text/html",
          "value": "<html>
            <head></head>
            <body style=\"text-align:center; font-family:sans-serif; width:630px; margin:0 auto\">
              <img src=\"https://res.cloudinary.com/dghasvvlv/image/upload/v1604128867/logo-blue_koemhn.png\" style=\"width:140px; margin:20px 0 0\" alt=\"Inhome Accountants logo\"/>
              <hr style=\"height: 1px; background-color:#eee; border:0; margin:20px 0\">
              <header>
                <h2 style=\"margin:0 0 10px; color:#032c5c; font-size:40px;\">#{email[:subject]}</h2>
              </header>
              <div style=\"color:#868686;\">
                  <p style=\"color:#1d1c1d; font-size:20px; margin:5px 0;\">#{email[:text]}</p>
              </div>
              <hr style=\"height: 1px; background-color:#eee; border:0; margin:20px 0\">
              <a href=\"#{FRONTEND_HOST}\" target=\"_blank\" rel=\"noopener noreferrer\">Open InHome Accountants</a>
            </body>
          </html>"
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