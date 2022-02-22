class Admin::TimesheetBlueprint < Blueprinter::Base
  identifier :id

  fields :timesheet_status,
         :timesheet_date

  field :hours do |timesheet|
    timesheet.time_entries.sum(&:hours)
  end

  field :project do |timesheet|
    {
      title: timesheet.project.title,
      client_detail: {
        company_name: timesheet.project.client_detail.company_name,
        user: {
          first_name: timesheet.project.client_detail.user.first_name,
          last_name: timesheet.project.client_detail.user.last_name,
        },
      },
    }
  end

  field :freelancer do |timesheet|
    timesheet.freelancer ?
      {
        first_name: timesheet.freelancer.first_name,
        last_name: timesheet.freelancer.last_name,
        email: timesheet.freelancer.email,
      } : nil
  end

  view :extended do
    field :notes

    field :amount do |timesheet|
      if timesheet.project.client_type_of_billing == "custom_type"
        timesheet.project.freelancer_payment_amount
      else
        hours = timesheet.time_entries.sum(&:hours)
        total = hours * timesheet.project.freelancer_payment_amount
      end
    end

    association :time_entries, blueprint: TimeEntryBlueprint
  end
end
