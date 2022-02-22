class Api::V1::Freelancer::ProjectsController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  def index
    projects = Project
                   .where(freelancer_detail_id: current_api_user.freelancer_detail.id)
                   .where.not(project_status: 'inactive')
                   .order(updated_at: :desc)
    render json: Freelancer::ProjectBlueprint.render(projects)
  end

  def show
    project = Project.find(params[:id])
    render json: Freelancer::ProjectBlueprint.render(project, view: :extended)
  end
end
