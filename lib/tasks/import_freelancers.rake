require "csv"

task import_freelancers: :environment do
  CSV.foreach("imports.csv", headers: true) do |row|
    user = User.new(row.to_h)
    user.password = "ghbdtn_vbh_9568"
    user.is_legacy_user = true
    user.is_password_set = false
    user.save
    FreelancerDetail.create(:user_id => user.id, :qualified => true, :sign_up_code_entered => true)
    AllowedNotification.create(
      user_id: user.id,
      new_opportunity_available: true,
      project_bid_accepted: true,
      timesheet_rejected: true,
      new_timesheet_submitted: false,
      new_invoice_submitted: false,
    )
  end
end
