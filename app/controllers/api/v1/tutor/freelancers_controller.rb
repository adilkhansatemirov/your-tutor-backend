class Api::V1::Freelancer::FreelancersController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  def current
    freelancer = User.find(current_api_user.id)
    render json: Freelancer::FreelancerBlueprint.render(freelancer)
  end

  def update_freelancer_detail
    freelancer_detail = current_api_user.freelancer_detail
    freelancer_detail.update(update_freelancer_detail_params)
    render json: { message: "Freelancer detail successfully updated." }, status: 200
  end

  # POST /freelancer/freelancers/upload_resume
  def upload_resume
    Freelancer::FreelancersService.upload_resume(current_api_user.id, params[:resume])
    render json: { message: "Resume has been uploaded" }, status: 200
  end

  # POST /freelancer/freelancers/connect_stripe
  def connect_stripe
    Freelancer::FreelancersService.connect_stripe(current_api_user.id, freelancer_connect_stripe_params[:code])
    render json: { message: 'Stripe has been connected' }, status: 200
  end

  # POST /freelancer/freelancers/finish_all_steps
  def finish_all_steps
    Freelancer::FreelancersService.finish_all_steps(current_api_user.id)
    render json: { message: "User updated" }, status: 200
  end

  # POST /freelancer/freelancers/generate_express_dashboard_link
  def generate_express_dashboard_link
    link = Freelancer::FreelancersService.generate_express_dashboard_link(current_api_user.id)
    render json: { link: link }, status: 200
  end

  private

  def freelancer_connect_stripe_params
    params.require(:connect_stripe_data).permit(:code)
  end

  def update_freelancer_detail_params
    params.require(:freelancer_detail).permit(
      :id,
      :work_hours_per_week,
      :desired_hourly_rate
    )
  end
end
