class Api::V1::SupportController < ApplicationController

  def send_email_to_admin
    SupportService.send_email_to_admin(send_email_to_admin_params)
    render json: { message: "Message delivered" }, status: 200
  end

  private

  def send_email_to_admin_params
    params.require(:data).permit(
      :email,
      :subject,
      :message,
    )
  end
end
