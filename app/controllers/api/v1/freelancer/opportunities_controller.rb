class Api::V1::Freelancer::OpportunitiesController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  def index
    project_bids = ProjectBid.where("user_id = :user_id", { user_id: current_api_user.id }).order(created_at: :desc)
    render json: OpportunityBlueprint.render(project_bids, root: :list, meta: {
      counters: {
        new_count: project_bids.new_project.count + project_bids.seen.count,
        applied_count: project_bids.applied.count,
        awarded_count: project_bids.awarded.count,
        rejected_count: project_bids.rejected.count
      }
    })
  end

  def show
    project_bid = ProjectBid.find(params[:id])
    render json: OpportunityBlueprint.render(project_bid)
  end
end
