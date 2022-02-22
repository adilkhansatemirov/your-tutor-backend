module Freelancer::ProjectBidsService

  def self.update_project_bid(params, project_bid_id)
    project_bid = ProjectBid.find(project_bid_id)
    project_bid.update(params)
  end

end
