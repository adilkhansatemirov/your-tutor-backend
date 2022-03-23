class Api::V1::Admin::FreelancerDetailsController < ApplicationController
  before_action :authenticate_api_user!, :require_admin
  include Searchable
  include Sortable

  sortable_by 'users_freelancer_details.first_name'

  # GET /admin/freelancer_details
  def index
    freelancers_details = sort(search(filter_freelancers(freelancer_details_scope)))
    result = freelancers_details.page(params[:page]).per(per_page)

    render json: Admin::FreelancerDetailBlueprint.render(result, root: :list, meta: {
        pagination: page_info(result),
        counters: {
            approved_count: freelancer_details_scope.where(qualified: true).count,
            pending_approval_count: freelancer_details_scope.where(qualified: false).count,
            billing_count: billing_freelancer_details_ids.count,
            blocked_count: blocked_freelancer_ids.count
        }
    })
  end

  # GET /admin/freelancer_details/all
  def all
    freelancer_details = FreelancerDetail.all.order(updated_at: :desc)
    render json: Admin::FreelancerDetailBlueprint.render(freelancer_details)
  end

  # PUT /admin/freelancer_details/:id
  def update
    freelancer_detail = FreelancerDetail.find(params[:id])
    freelancer_detail.update(freelancer_detail_params)
    render json: { message: "Freelancer detail successfully updated." }, status: 200
  end

  private

  def freelancer_details_scope
    FreelancerDetail.all.joins("INNER JOIN Users as users on freelancer_details.user_id = users.id").includes(user: { freelancer_skills: :skill }).order(created_at: :desc)
  end

  def freelancer_detail_params
    params.require(:freelancer_detail).permit(
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

  def filter_freelancers(scope)
    case params[:profile_status]
    when 'billing'
      scope.where(id: billing_freelancer_details_ids)
          .where.not(user_id: blocked_freelancer_ids)
    when 'pending_approval'
      scope.where
          .not(id: billing_freelancer_details_ids)
          .where(qualified: false)
          .where.not(user_id: blocked_freelancer_ids)
    when 'approved'
      scope.where
          .not(id: billing_freelancer_details_ids)
          .where(qualified: true)
          .where.not(user_id: blocked_freelancer_ids)
    when 'blocked'
      scope.where(user_id: blocked_freelancer_ids)
    else
      scope
    end
  end

  def billing_freelancer_details_ids
    Project.where.not(freelancer_detail_id: nil).pluck(:freelancer_detail_id).uniq
  end

  def blocked_freelancer_ids
    User.freelancer.where(is_blocked: true).pluck(:id)
  end
end
