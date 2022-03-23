class Api::V1::Admin::StudentDetailsController < ApplicationController
  before_action :authenticate_api_user!, :require_admin
  include Searchable
  include Sortable

  sortable_by 'student_details.company_name', 'users.first_name'

  # GET /student_details
  def index
    student_details = sort(search(filter_students(student_details_scope)))
    result = student_details.page(params[:page]).per(per_page)

    render json: Admin::StudentDetailBlueprint.render(result, root: :list, meta: {
      pagination: page_info(result),
      counters: {
        complete_count: student_details_scope.where.not(stripe_customer_id: nil).count,
        incomplete_count: student_details_scope.where(stripe_customer_id: nil).count,
        blocked_count: blocked_student_ids.count
      }
    })
  end

  # POST /admin/student_details
  def create
    Admin::StudentDetailsService.create_student(create_student_params)
    render json: { message: 'User has been created' }, status: 200
  end

  # GET /student_details/all
  def all
    student_details = StudentDetail.all.order(updated_at: :desc)
    render json: Admin::StudentDetailBlueprint.render(student_details)
  end

  private

  def student_details_scope
    StudentDetail.all.joins("INNER JOIN Users as users on student_details.user_id = users.id").order(updated_at: :desc)
  end

  def filter_students(scope)
    case params[:profile_status]
    when 'complete'
      scope.where.not(stripe_customer_id: nil)
          .where.not(user_id: blocked_student_ids )
    when 'incomplete'
      scope.where(stripe_customer_id: nil)
          .where.not(user_id: blocked_student_ids)
   when 'blocked'
      scope.where(user_id: blocked_student_ids)
    else
      scope
    end
  end

  def blocked_student_ids
    User.student.where(is_blocked: true).pluck(:id)
  end

  def create_student_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :company_name,
    )
  end
end
