class Tutor::ProjectBlueprint < Blueprinter::Base
  identifier :id
  fields :title,
         :student_type_of_billing,
         :tutor_payment_amount,
         :project_status

  field :student_detail do |project|
    {
      company_name: project.student_detail.company_name,
      user: {
        first_name: project.student_detail.user.first_name,
        last_name: project.student_detail.user.last_name,
        email: project.student_detail.user.email,
      },
    }
  end

  view :extended do
    fields :tutor_payment_amount,
           :description

    association :timesheets, blueprint: Tutor::TimesheetBlueprint
  end
end
