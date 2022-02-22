class Api::V1::Client::ClientDetailsController < ApplicationController
  before_action :authenticate_api_user!, :require_client

  # POST /client/clients/connect_card
  def connect_card
    Client::ClientDetailsService.connect_card(connect_card_params, current_api_user)
    render json: { message: "сredit card successfully added" }, status: 200
  end

  # POST /client/clients/connect_bank
  def connect_bank
    Client::ClientDetailsService.connect_bank(connect_bank_params, current_api_user)
    render json: { message: "Your bank account has been successully added" }, status: 200
  end

  private
  def connect_card_params
    params.permit(:token_id)
  end

  def connect_bank_params
    params.permit(
      :public_token,
      :account_id
    )
  end
end
