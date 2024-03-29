class Admin::ProjectBlueprint < Blueprinter::Base
  identifier :id
  fields :title,
         :description,
         :project_duration,
         :project_status,
         :error_message,
         :invoicing_schedule,
         :student_type_of_billing,
         :student_payment_amount,
         :tutor_payment_amount,
         :automated_invoicing

  association :student_detail, blueprint: Admin::StudentDetailBlueprint
  association :tutor_detail, blueprint: Admin::TutorDetailBlueprint

  view :extended do
    field :project_bids do |project|
      bids = []
      project.project_bids.applied.order(updated_at: :desc).each do |bid|
        tutor_skill_groups = []
        bid.user.tutor_skills.each do |skill|
          tutor_skill_groups.push(skill.skill.category)
        end

        bids.push({
          id: bid.id,
          compensation: bid.compensation,
          bids_status: bid.bids_status,
          user: {
            first_name: bid.user.first_name,
            last_name: bid.user.last_name,
            email: bid.user.email,
            skill_groups: tutor_skill_groups.uniq,
            tutor_detail: {
              id: bid.user.tutor_detail.id,
            },
          },
        })
      end
      bids
    end

    field :timesheets, unless: ->(_field_name, project, _options) { project.project_status == "accepting_bids" } do |project|
      timesheets = []
      project.timesheets.where.not(timesheet_status: "edited").order(updated_at: :desc).each do |timesheet|
        hours = 0
        timesheet.time_entries.each do |time_entry|
          hours += time_entry.hours
        end
        timesheets.push({
          id: timesheet.id,
          timesheet_status: timesheet.timesheet_status,
          timesheet_date: timesheet.timesheet_date,
          hours: hours,
          tutor: timesheet.tutor ? {
            first_name: timesheet.tutor.first_name,
            last_name: timesheet.tutor.last_name,
            email: timesheet.tutor.email,
          } : nil,
        })
      end

      timesheets
    end

    field :invoices, unless: ->(_field_name, project, _options) { project.project_status == "accepting_bids" } do |project|
      invoices = []
      project.invoices.order(updated_at: :desc).each do |invoice|
        amount = 0
        invoice.invoice_items.each do |item|
          amount += item.qty * item.price
        end
        invoices.push({
          id: invoice.id,
          invoice_date: invoice.invoice_date,
          invoice_status: invoice.invoice_status,
          invoice_amount: amount,
        })
      end
      invoices
    end
  end
end
