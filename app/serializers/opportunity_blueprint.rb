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
      freelancer_payment_amount: bid.project.freelancer_payment_amount,
      client_type_of_billing: bid.project.client_type_of_billing,
    }
  end
end
