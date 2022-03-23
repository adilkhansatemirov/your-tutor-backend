class Api::V1::Admin::TimesheetsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_api_user!, :require_admin

  filterable_by 'timesheet_status'
  sortable_by 'timesheets.timesheet_date', 'clients.first_name', 'freelancers.first_name', 'projects.title'

  # GET /admin/timesheets
  def index
    timesheets = sort(search(filter(timesheets_scope)))
    result = timesheets.page(params[:page]).per(per_page)
    render json: Admin::TimesheetBlueprint.render(result, root: :list, meta: {
      pagination: page_info(result),
      counters: {
        sent_count: timesheets_scope.submitted.count,
        approved_count: timesheets_scope.approved.count,
        paid_count: timesheets_scope.paid.count,
        rejected_count: timesheets_scope.rejected.count,
      }
    })
  end

  # GET /admin/timesheets/:id
  def show 
    timesheet = Timesheet.find(params[:id])
    render json: Admin::TimesheetBlueprint.render(timesheet, view: :extended)
  end

  # PUT /admin/timesheets/:id
  def update 
    Admin::TimesheetsService.update_timesheet(timesheet_params)
    render json: { message: "Timesheet successfully updated" }, status: 200
  end

  def pay_freelancer
    Admin::TimesheetsService.pay_freelancer(params)
    render json: { success: true }, status: 200
  end

  private

  def timesheets_scope
    Timesheet.where.not(timesheet_status: :edited)
    .joins("INNER JOIN projects on timesheets.project_id = projects.id")
    .joins("INNER JOIN client_details on projects.client_detail_id = client_details.id")
    .joins("INNER JOIN freelancer_details on projects.freelancer_detail_id = freelancer_details.id")
    .joins("INNER JOIN users as clients on client_details.user_id = clients.id")
    .joins("INNER JOIN users as freelancers on freelancer_details.user_id = freelancers.id").order(updated_at: :desc)
  end

  def timesheet_params
    params.require(:timesheet).permit(
      :id,
      :project_id,
      :timesheet_status,
      :timesheet_date,
      :notes)
  end
end
