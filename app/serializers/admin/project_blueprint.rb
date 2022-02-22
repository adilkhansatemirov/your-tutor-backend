class Admin::ProjectBlueprint < Blueprinter::Base
  identifier :id
  fields :title,
         :description,
         :project_duration,
         :project_status,
         :error_message,
         :invoicing_schedule,
         :client_type_of_billing,
         :client_payment_amount,
         :freelancer_payment_amount,
         :automated_invoicing

  association :client_detail, blueprint: Admin::ClientDetailBlueprint
  association :freelancer_detail, blueprint: Admin::FreelancerDetailBlueprint

  view :extended do
    field :project_bids do |project|
      bids = []
      project.project_bids.applied.order(updated_at: :desc).each do |bid|
        freelancer_skill_groups = []
        bid.user.freelancer_skills.each do |skill|
          freelancer_skill_groups.push(skill.skill.category)
        end

        bids.push({
          id: bid.id,
          compensation: bid.compensation,
          bids_status: bid.bids_status,
          user: {
            first_name: bid.user.first_name,
            last_name: bid.user.last_name,
            email: bid.user.email,
            skill_groups: freelancer_skill_groups.uniq,
            freelancer_detail: {
              id: bid.user.freelancer_detail.id,
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
          freelancer: timesheet.freelancer ? {
            first_name: timesheet.freelancer.first_name,
            last_name: timesheet.freelancer.last_name,
            email: timesheet.freelancer.email,
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
