class ApplicationController < ActionController::API
  include ApiException

  MAX_PER_PAGE = 20

  def authenticate_api_user!
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      decoded = JsonWebToken.decode(header)
      @current_api_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  protected

  def page_info(paginated_scope)
    total_count = paginated_scope.total_count
    {
        page: paginated_scope.current_page,
        num_pages: (total_count.to_f / per_page.to_f).ceil,
        total_count: total_count,
        per_page: per_page,
    }
  end

  def per_page
    [(params[:per_page] || MAX_PER_PAGE).to_i, MAX_PER_PAGE].min
  end

  def current_api_user
    @current_api_user
  end

  def require_admin
    if current_api_user && current_api_user.role != 'admin'
      render json: { error: 'Not authorized to access' }, status: 401
    end
  end

  def require_freelancer
    if current_api_user && current_api_user.role != 'freelancer'
      render json: { error: 'Not authorized to access' }, status: 401
    end
  end

  def require_client
    if current_api_user && current_api_user.role != 'client'
      render json: { error: 'Not authorized to access', status: 401 }
    end
  end
end
