class Api::V1::AllowedNotificationsController < ApplicationController
  # GET /allowed_notifications/:user_id
  def show
    allowed_notification = AllowedNotification.where(user_id: params[:user_id]).first
    render json: allowed_notification
  end

  # PUT /allowed_notifications/:user_id
  def update
    allowed_notification = AllowedNotification.where(user_id: params[:user_id]).first
    if allowed_notification
      allowed_notification.update(allowed_notification_params)
      render json: allowed_notification, status: :ok
    else
      render json: { error: "Unable to update" }, status: :unprocessable_entity
    end
  end

  private

  def allowed_notification_params
    params.permit(
      :new_opportunity_available,
      :project_bid_accepted,
      :timesheet_rejected,
      :new_timesheet_submitted,
      :new_invoice_submitted,
      :new_freelancer_signed_up
    )
  end
end
