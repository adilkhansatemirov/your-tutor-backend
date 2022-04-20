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
      student_detail: {
        company_name: timesheet.project.student_detail.company_name,
        user: {
          first_name: timesheet.project.student_detail.user.first_name,
          last_name: timesheet.project.student_detail.user.last_name,
        },
      },
    }
  end

  field :tutor do |timesheet|
    timesheet.tutor ?
      {
        first_name: timesheet.tutor.first_name,
        last_name: timesheet.tutor.last_name,
        email: timesheet.tutor.email,
      } : nil
  end

  view :extended do
    field :notes

    field :amount do |timesheet|
      if timesheet.project.student_type_of_billing == "custom_type"
        timesheet.project.tutor_payment_amount
      else
        hours = timesheet.time_entries.sum(&:hours)
        total = hours * timesheet.project.tutor_payment_amount
      end
    end

    association :time_entries, blueprint: TimeEntryBlueprint
  end
end
