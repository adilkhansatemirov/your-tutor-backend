class Api::V1::Admin::TutorDetailsController < ApplicationController
  before_action :authenticate_api_user!, :require_admin
  include Searchable
  include Sortable

  sortable_by 'users_tutor_details.first_name'

  # GET /admin/tutor_details
  def index
    tutors_details = sort(search(filter_tutors(tutor_details_scope)))
    result = tutors_details.page(params[:page]).per(per_page)

    render json: Admin::TutorDetailBlueprint.render(result, root: :list, meta: {
        pagination: page_info(result),
        counters: {
            approved_count: tutor_details_scope.where(qualified: true).count,
            pending_approval_count: tutor_details_scope.where(qualified: false).count,
            billing_count: billing_tutor_details_ids.count,
            blocked_count: blocked_tutor_ids.count
        }
    })
  end

  # GET /admin/tutor_details/all
  def all
    tutor_details = TutorDetail.all.order(updated_at: :desc)
    render json: Admin::TutorDetailBlueprint.render(tutor_details)
  end

  # PUT /admin/tutor_details/:id
  def update
    tutor_detail = TutorDetail.find(params[:id])
    tutor_detail.update(tutor_detail_params)
    render json: { message: "Tutor detail successfully updated." }, status: 200
  end

  private

  def tutor_details_scope
    TutorDetail.all.joins("INNER JOIN Users as users on tutor_details.user_id = users.id").includes(user: { tutor_skills: :skill }).order(created_at: :desc)
  end

  def tutor_detail_params
    params.require(:tutor_detail).permit(
      :user_id,
      :contract_signed_date,
      :form_1099_signed_date,
      :background_check_passed,
      :candidate_id,
      :report_id,
      :status,
      :ip_address,
      :resume,
      :sign_up_code,
      :sign_up_code_entered, 
      :interview_scheduled,
      :work_hours_per_week,
      :desired_hourly_rate
    )
  end

  def filter_tutors(scope)
    case params[:profile_status]
    when 'billing'
      scope.where(id: billing_tutor_details_ids)
          .where.not(user_id: blocked_tutor_ids)
    when 'pending_approval'
      scope.where
          .not(id: billing_tutor_details_ids)
          .where(qualified: false)
          .where.not(user_id: blocked_tutor_ids)
    when 'approved'
      scope.where
          .not(id: billing_tutor_details_ids)
          .where(qualified: true)
          .where.not(user_id: blocked_tutor_ids)
    when 'blocked'
      scope.where(user_id: blocked_tutor_ids)
    else
      scope
    end
  end

  def billing_tutor_details_ids
    Project.where.not(tutor_detail_id: nil).pluck(:tutor_detail_id).uniq
  end

  def blocked_tutor_ids
    User.tutor.where(is_blocked: true).pluck(:id)
  end
end
