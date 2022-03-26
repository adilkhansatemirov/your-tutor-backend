class Api::V1::Client::ProjectsController < ApplicationController
  before_action :authenticate_api_user!, :require_client

  def index
    projects = Project.where(is_created_by_client: true).where(client_detail_id: current_api_user.client_detail.id).order(updated_at: :desc)
    render json: Client::ProjectBlueprint.render(projects, root: :list, meta: {})
  end

  def create
    Client::ProjectsService.create_project(create_project_params, current_api_user)
    render json: { message: "project created" }, status: 200
  end

  def show
    project = Project.find(params[:id])
    render json: Client::ProjectBlueprint.render(project, view: :extended)
  end

  private

  def create_project_params
    params.require(:project_data).permit(
      :title,
      :description,
      :client_payment_amount,
    )
  end
end
