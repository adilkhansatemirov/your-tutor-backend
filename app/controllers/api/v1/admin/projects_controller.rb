class Api::V1::Admin::ProjectsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_api_user!, :require_admin

  filterable_by 'project_status'
  sortable_by 'projects.title', 'clients.first_name', 'freelancers.first_name'

  def index
    projects = sort(search(filter(projects_scope)))
    result = projects.page(params[:page]).per(per_page)
    render json: Admin::ProjectBlueprint.render(result, root: :list, meta: {
      pagination: page_info(result),
      counters: {
        accepting_bids_count: projects_scope.accepting_bids.count,
        active_count: projects_scope.active.count,
        inactive_count: projects_scope.inactive.count,
        error_count: projects_scope.error.count
      }
    })
  end

  def show
    project = Project.find(params[:id])
    render json: Admin::ProjectBlueprint.render(project, view: :extended)
  end

  def create
    Admin::ProjectsService.create_project(create_project_params)
    render json: { message: 'project created' }
  end

  def update
    Admin::ProjectsService.update_project(update_project_params, params[:id])
    render json: { message: 'project updated' }
  end

  def assign_freelancer
    Admin::ProjectsService.assign_freelancer(assign_freelancer_params, params[:id])
    render json: { message: 'freelancer assigned' }
  end

  def start_bids
    Admin::ProjectsService.start_bids(start_bids_params, params[:id])
    render json: { message: 'bids started' }
  end

  def uninvoiced_time_entries
    time_entries = Admin::ProjectsService.uninvoiced_time_entries(params[:id])
    render json: time_entries
  end

  def pay_freelancer
    outcome = Admin::ProjectsService.pay_freelancer(pay_freelancer_params, params[:id])
    render json: { message: outcome[:message] }, status: outcome[:status]
  end

  def deactivate
    Admin::ProjectsService.deactivate_project(params[:id])
    render json: { message: 'project deactivated' }, status: 200
  end

  def enable_automated_invoicing
    outcome = Admin::ProjectsService.enable_automated_invoicing(params[:id])
    render json: { message: outcome[:message] }, status: outcome[:status]
  end

  def disable_automated_invoicing
    Admin::ProjectsService.disable_automated_invoicing(params[:id])
    render json: { message: "automated invoicing disabled" }, status: 200
  end

  private

  def projects_scope
    Project.joins("INNER JOIN client_details on projects.client_detail_id = client_details.id")
    .joins("INNER JOIN users as clients on client_details.user_id = clients.id")
    # .joins("INNER JOIN freelancer_details on projects.freelancer_detail_id = freelancer_details.id")
    # .joins("INNER JOIN users as freelancers on freelancer_details.user_id = freelancers.id")
        .order(updated_at: :desc)
  end

  def create_project_params
    params.require(:project_data).permit(
      project: [
        :title,
        :description,
        :project_duration,
        :project_status,
        :invoicing_schedule,
        :client_type_of_billing,
        :client_payment_amount,
        :freelancer_payment_amount,
        :freelancer_detail_id,
        :client_detail_id,
      ],
      project_bids: [
        :user_id,
      ],
    )
  end

  def update_project_params
    params.require(:project_data).permit(
      :title,
      :description,
      :client_detail_id,
      :invoicing_schedule,
      :client_type_of_billing,
      :client_payment_amount,
      :freelancer_payment_amount,
      :freelancer_detail_id,
      :project_status,
    )
  end

  def pay_freelancer_params
    params.require(:payment_data).permit(:payment_amount)
  end

  def assign_freelancer_params
    params.require(:project_data).permit(:freelancer_detail_id, :project_status, :freelancer_payment_amount)
  end

  def start_bids_params
    params.require(:project_data).permit(
      project: [
        :project_status,
        :freelancer_payment_amount,
      ],
      project_bids: [
        :user_id,
      ],
    )
  end
end
