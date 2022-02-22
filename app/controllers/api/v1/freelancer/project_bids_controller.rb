class Api::V1::Freelancer::ProjectBidsController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  def update
    Freelancer::ProjectBidsService.update_project_bid(project_bid_params, params[:id])
    render json: { message: "Project bid successfully updated" }, status: 200
  end

  private

  def project_bid_params
    params.require(:project_bid).permit(
      :compensation,
      :bids_status
    )
  end
end
