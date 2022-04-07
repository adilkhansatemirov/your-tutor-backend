class Api::V1::Freelancer::TimesheetsController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  # GET /timesheets/:id
  def show
    timesheet = Timesheet.find(params[:id])
    render json: Freelancer::TimesheetBlueprint.render(timesheet, view: :extended)
  end

  # POST /timesheets
  def create
    Freelancer::TimesheetsService.create_timesheet(timesheet_create_params)
    render json: { message: "timesheet created" }, status: 200
  end

  # PUT /timesheets/:id
  def update
    Freelancer::TimesheetsService.update_timesheet(timesheet_update_params, params[:id])
    render json: { message: "timesheet updated" }, status: 200
  end

  # DELETE /timesheets/:id
  def destroy
    Freelancer::TimesheetsService.delete_timesheet(params[:id])
    render json: { message: "timesheet deleted" }, status: 200
  end

  private

  def timesheet_create_params
    params.require(:timesheet).permit(
      :project_id,
      :timesheet_status,
      :timesheet_date,
      :freelancer_id,
      :notes,
      time_entries: [
        :customer,
        :hours,
        :task,
      ],
    )
  end

  def timesheet_update_params
    params.require(:timesheet).permit(
      :project_id,
      :timesheet_status,
      :timesheet_date,
      :notes
    )
  end
end
