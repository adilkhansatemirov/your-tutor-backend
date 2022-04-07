class OpportunityBlueprint < Blueprinter::Base
  identifier :id

  field :bids_status
  field :project do |bid|
    {
      id: bid.project.id,
      title: bid.project.title,
      description: bid.project.description,
      project_duration: bid.project.project_duration,
      project_status: bid.project.project_status,
      tutor_payment_amount: bid.project.tutor_payment_amount,
      student_type_of_billing: bid.project.student_type_of_billing,
    }
  end
end
