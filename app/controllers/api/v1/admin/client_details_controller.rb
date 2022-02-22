class Api::V1::Admin::ClientDetailsController < ApplicationController
  before_action :authenticate_api_user!, :require_admin
  include Searchable
  include Sortable

  sortable_by 'client_details.company_name', 'users.first_name'

  # GET /client_details
  def index
    client_details = sort(search(filter_clients(client_details_scope)))
    result = client_details.page(params[:page]).per(per_page)

    render json: Admin::ClientDetailBlueprint.render(result, root: :list, meta: {
      pagination: page_info(result),
      counters: {
        complete_count: client_details_scope.where.not(stripe_customer_id: nil).count,
        incomplete_count: client_details_scope.where(stripe_customer_id: nil).count,
        blocked_count: blocked_client_ids.count
      }
    })
  end

  # POST /admin/client_details
  def create
    Admin::ClientDetailsService.create_client(create_client_params)
    render json: { message: 'User has been created' }, status: 200
  end

  # GET /client_details/all
  def all
    client_details = ClientDetail.all.order(updated_at: :desc)
    render json: Admin::ClientDetailBlueprint.render(client_details)
  end

  private

  def client_details_scope
    ClientDetail.all.joins("INNER JOIN Users as users on client_details.user_id = users.id").order(updated_at: :desc)
  end

  def filter_clients(scope)
    case params[:profile_status]
    when 'complete'
      scope.where.not(stripe_customer_id: nil)
          .where.not(user_id: blocked_client_ids )
    when 'incomplete'
      scope.where(stripe_customer_id: nil)
          .where.not(user_id: blocked_client_ids)
   when 'blocked'
      scope.where(user_id: blocked_client_ids)
    else
      scope
    end
  end

  def blocked_client_ids
    User.client.where(is_blocked: true).pluck(:id)
  end

  def create_client_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :company_name,
    )
  end
end
