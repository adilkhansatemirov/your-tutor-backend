module Admin::NotificationsService

  def self.notify_about_rejected_timesheet(freelancer, timesheet)
    if AllowedNotification.where(user_id: freelancer[:id]).first[:timesheet_rejected]
      project_title = timesheet.project.title
      email = { :address => freelancer[:email], :user_role => 'freelancer', :subject => 'Timesheet rejected', :text => "Watch out!<br />Your timesheet for project \"#{project_title}\" has been rejected!" }
      Mailer.send(email)
    end
  end

  def self.notify_about_new_opportunity(bids)
    bids.each do |bid|
      user = User.where(id: bid[:user_id]).first
      if AllowedNotification.where(user_id: user[:id]).first[:new_opportunity_available]
        email = {
            address: user[:email],
            user_role: "freelancer",
            subject: "New Opportunity",
            text: "Heads Up!<br />There is a new opportunity for you!"
        }
        Mailer.send(email)
      end
    end
  end

  def self.notify_about_new_invoice(invoice, user)
    invoice_link = "#{ENV["FRONTEND_HOST"]}/client/invoices/#{invoice.id}"
    if AllowedNotification.where(user_id: user[:id]).first[:new_invoice_submitted]
      project_title = invoice.project.title
      email = {
        address: user[:email],
        user_role: "client",
        subject: "New invoice",
        text: "You have received a new invoice for project \"#{project_title}\"!<br />Click <a href=\"#{invoice_link}\" target=\"_blank\" rel=\"noopener noreferrer\">here</a> to view the invoice",
      }
      Mailer.send(email)
    end
  end

end
