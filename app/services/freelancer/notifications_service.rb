module Freelancer::NotificationsService

  def self.notify_about_new_timesheet(timesheet)
    admins = User.admin
    admins.each do |admin|
      if AllowedNotification.where(user_id: admin[:id]).first[:new_timesheet_submitted]
        freelancer_full_name = "#{timesheet.freelancer.first_name} #{timesheet.freelancer.last_name}"
        timesheet_link = "#{ENV["FRONTEND_HOST"]}/admin/timesheets/#{timesheet.id}"
        email = {
          address: admin[:email],
          user_role: "admin",
          subject: "New Timesheet",
          text: "We have a new timesheet submitted from #{freelancer_full_name}. Click <a href=\"#{timesheet_link}\" target=\"_blank\" rel=\"noopener noreferrer\">here</a> to view it.",
        }
        Mailer.send(email)
      end
    end
  end

  def self.notify_about_new_freelancer(user)
    admins = User.admin
    admins.each do |admin|
      if AllowedNotification.where(user_id: admin[:id]).first[:new_freelancer_signed_up]
        email = { :address => admin[:email], :user_role => "admin", :subject => "New Freelancer", :text => "New Freelancer #{user.first_name} #{user.last_name} has just signed up!" }
        Mailer.send(email)
      end
    end
  end

end
