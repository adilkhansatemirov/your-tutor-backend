class Api::V1::Admin::UsersController < ApplicationController
  before_action :authenticate_api_user!, :require_admin

  # POST /admin/users/:id/block
  def block
    user = User.find(params[:id])
    user.update(is_blocked: true)
    render json: { message: "User has been blocked" }, status: 200
  end

  # POST /admin/users/:id/unblock
  def unblock
    user = User.find(params[:id])
    user.update(is_blocked: false)
    render json: { message: "User has been unblocked" }, status: 200
  end
end
