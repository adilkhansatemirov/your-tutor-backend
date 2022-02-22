class TimeEntryBlueprint < Blueprinter::Base
  identifier :id

  fields :task,
         :hours,
         :created_at,
         :updated_at,
         :timesheet_id,
         :invoiced,
         :customer
end
