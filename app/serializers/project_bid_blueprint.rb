class ProjectBidBlueprint < Blueprinter::Base
  identifier :id

  fields :compensation,
         :bids_status,
         :user_id

  field :user do |project_bid|
    {
      first_name: project_bid.user.first_name,
      last_name: project_bid.user.last_name,
      email: project_bid.user.email,
    }
  end
end
