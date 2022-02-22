class Freelancer::TimesheetBlueprint < Blueprinter::Base
  identifier :id

  fields :timesheet_status,
         :timesheet_date,
         :notes

  field :hours do |timesheet|
    timesheet.time_entries.sum(&:hours)
  end

  association :project, blueprint: Freelancer::ProjectBlueprint

  view :extended do
    association :time_entries, blueprint: TimeEntryBlueprint

    field :freelancer do |timesheet|
      timesheet.freelancer ? {
        id: timesheet.freelancer.id,
        first_name: timesheet.freelancer.first_name,
        last_name: timesheet.freelancer.last_name,
      } : nil
    end
  end
end
