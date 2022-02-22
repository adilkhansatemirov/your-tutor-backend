module Admin::TimesheetsService

  def self.update_timesheet(params)
    timesheet = Timesheet.find(params[:id])
    timesheet.update(params)

    if params[:timesheet_status] == 'rejected'
      freelancer = timesheet.project.freelancer_detail.user
      Admin::NotificationsService.notify_about_rejected_timesheet(freelancer, timesheet)
    end
  end

  def self.pay_freelancer(params)
    timesheet = Timesheet.find(params[:id])
    freelancer = timesheet.freelancer
    total = count_total_of_timesheet(timesheet, freelancer)
    transfer = Admin::StripeService.create_transfer(total, freelancer.freelancer_detail.connected_account_id)
    Admin::PaymentsService.create_payment(transfer, freelancer)
    timesheet.update(timesheet_status: 'paid')
  end

  private

  def self.count_total_of_timesheet(timesheet, freelancer)
    total = 0
    if timesheet.project.client_type_of_billing == "custom_type"
      total = timesheet.project.freelancer_payment_amount
    else
      hours = 0
      timesheet.time_entries.each do |time_entry|
        hours += time_entry.hours
      end
      total = hours * timesheet.project.freelancer_payment_amount
    end
    total = (total * 100).round

    total
  end
end
