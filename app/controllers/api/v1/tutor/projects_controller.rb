class Api::V1::Tutor::ProjectsController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  def index
    projects = Project
                   .where(tutor_detail_id: current_api_user.tutor_detail.id)
                   .where.not(project_status: 'inactive')
                   .order(updated_at: :desc)
    render json: Tutor::ProjectBlueprint.render(projects)
  end

  def show
    project = Project.find(params[:id])
    render json: Tutor::ProjectBlueprint.render(project, view: :extended)
  end
end
