class Api::V1::Admin::LessonsController < ApplicationController
  def index
    render json: {
      test: "hello world"
    }
  end
end
