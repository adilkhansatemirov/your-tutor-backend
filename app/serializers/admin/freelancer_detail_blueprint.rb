module Admin
  class FreelancerDetailBlueprint < Blueprinter::Base
    identifier :id

    fields :user_id,
           :qualified,
           :desired_hourly_rate,
           :work_hours_per_week,
           :resume_url,
           :public_id

    field :user do |freelancer_detail|
      {
        id: freelancer_detail.user.id,
        email: freelancer_detail.user.email,
        first_name: freelancer_detail.user.first_name,
        last_name: freelancer_detail.user.last_name,
        is_blocked: freelancer_detail.user.is_blocked,
      }
    end

    field :profile_status do |freelancer_detail|
      user = freelancer_detail.user
      if user.is_blocked?
        'blocked'
      elsif Project.where(freelancer_detail_id: freelancer_detail.id).exists?
        'billing'
      elsif freelancer_detail.qualified?
        'approved'
      else
        'pending_approval'
      end
    end

    field :specialization do |freelancer_detail|
      freelancer_skill_groups = []
      freelancer_detail.user.freelancer_skills.each do |skill|
        freelancer_skill_groups.push(skill.skill.category)
      end
      freelancer_skill_groups.uniq
    end

  end
end
