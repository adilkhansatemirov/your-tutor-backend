class Tutor::TimesheetBlueprint < Blueprinter::Base
  identifier :id

  fields :timesheet_status,
         :timesheet_date,
         :notes

  field :hours do |timesheet|
    timesheet.time_entries.sum(&:hours)
  end

  association :project, blueprint: Tutor::ProjectBlueprint

  view :extended do
    association :time_entries, blueprint: TimeEntryBlueprint

    field :tutor do |timesheet|
      timesheet.tutor ? {
        id: timesheet.tutor.id,
        first_name: timesheet.tutor.first_name,
        last_name: timesheet.tutor.last_name,
      } : nil
    end
  end
end
