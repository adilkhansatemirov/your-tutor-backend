class Api::V1::Admin::FreelancersController < ApplicationController
  before_action :authenticate_api_user!, :require_admin

  # GET /admin/freelancers/:id
  def show
    freelancer = User.find(params[:id])
    render json: Admin::FreelancerBlueprint.render(freelancer, view: :extended)
  end

  # POST /admin/freelancers/upload_resume
  def upload_resume
    Admin::FreelancersService.upload_resume(params[:id], params[:resume])
    render json: { message: "Resume has been uploaded" }, status: 200
  end

  # POST /admin/freelancers/:id/qualify
  def qualify
    Admin::FreelancersService.qualify_freelancer(params[:id])
    render json: { message: "Freelancer qualified" }, status: 200
  end

  # DELETE /admin/freelancers/:id
  def destroy
    Admin::FreelancersService.delete_freelancer(params[:id])
    render json: { message: "Freelancer deleted" }, status: 200
  end

  private

  def freelancer_skill_params
    params.permit(freelancer_skills: [:user_id, :skill_id])
  end
end
