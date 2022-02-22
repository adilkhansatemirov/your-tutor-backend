module Freelancer::TimesheetsService

  def self.create_timesheet(params)
    timesheet = Timesheet.new(params.except(:time_entries))
    timesheet.save
    Freelancer::TimeEntriesService.create_multiple(params[:time_entries], timesheet.id)

    if params[:timesheet_status] == "submitted"
      Freelancer::NotificationsService.notify_about_new_timesheet(timesheet)
    end
  end

  def self.update_timesheet(params, timesheet_id)
    timesheet = Timesheet.find(timesheet_id)
    timesheet.update(params)

    if params[:timesheet_status] == "submitted"
      Freelancer::NotificationsService.notify_about_new_timesheet(timesheet)
    end
  end

  def self.delete_timesheet(timesheet_id)
    timesheet = Timesheet.find(timesheet_id)
    timesheet.destroy

    TimeEntry.where(timesheet_id: timesheet_id).destroy_all 
  end

end
