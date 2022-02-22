class Freelancer::ProjectBlueprint < Blueprinter::Base
  identifier :id
  fields :title,
         :client_type_of_billing,
         :freelancer_payment_amount,
         :project_status

  field :client_detail do |project|
    {
      company_name: project.client_detail.company_name,
      user: {
        first_name: project.client_detail.user.first_name,
        last_name: project.client_detail.user.last_name,
        email: project.client_detail.user.email,
      },
    }
  end

  view :extended do
    fields :freelancer_payment_amount,
           :description

    association :timesheets, blueprint: Freelancer::TimesheetBlueprint
  end
end
