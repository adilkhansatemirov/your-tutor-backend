class Api::V1::Freelancer::TimeEntriesController < ApplicationController
  before_action :authenticate_api_user!, :require_freelancer

  # POST /time_entries
  def create
    Freelancer::TimeEntriesService.create_time_entry(time_entry_params)
    render json: { message: "time entry created" }, status: 200
  end

  # PUT /time_entries/:id
  def update
    Freelancer::TimeEntriesService.update_time_entry(time_entry_params, params[:id])
    render json: { message: "time entry updated" }, status: 200
  end

  # DELETE /time_entries/:id
  def destroy
    Freelancer::TimeEntriesService.delete_time_entry(params[:id])
    render json: { message: "time entry deleted" }, status: 200
  end 

  private
  def time_entry_params
    params.require(:time_entry).permit(
      :timesheet_id,
      :task,
      :customer,
      :hours)
  end
end
