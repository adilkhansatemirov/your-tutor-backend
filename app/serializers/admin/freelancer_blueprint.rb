class Admin::FreelancerBlueprint < Blueprinter::Base
  identifier :id

  fields :email,
         :first_name,
         :last_name,
         :image

  field :profile_status do |user|
    if user.is_blocked?
      'blocked'  
    elsif Project.where(freelancer_detail_id: user.freelancer_detail.id).exists?
      'billing'
    elsif user.freelancer_detail.qualified?
      'approved'
    else
      'pending_approval'
    end
  end

  field :specialization do |user|
    freelancer_skill_groups = []
    user.freelancer_skills.each do |skill|
      freelancer_skill_groups.push(skill.skill.category)
    end
    freelancer_skill_groups.uniq
  end

  association :freelancer_detail, blueprint: Admin::FreelancerDetailBlueprint

  view :extended do
    field :skills do |user|
      skills = []
      user.freelancer_skills.each do |freelancer_skill|
        skills.push(freelancer_skill.skill)
      end
 
      skills_by_category = skills.group_by(&:category)

      formatted_skills = []
      skills_by_category.each do |category_name, skills_list|
        formatted_skills.push({
          name: category_name,
          list: skills_list.as_json
        })
      end
      formatted_skills
    end

    field :projects do |user|
      user.freelancer_detail.project.map do |project|
        if project.client_type_of_billing == "custom_type"
          amount = project.freelancer_payment_amount
        else
          hours = 0
          project.timesheets.each do |timesheet|
            hours += timesheet.time_entries.sum(&:hours)
          end
          amount = hours * project.freelancer_payment_amount
        end
        {
            id: project.id,
            title: project.title,
            client_detail: project.client_detail.user.as_json,
            company_name: project.client_detail.company_name,
            type: project.client_type_of_billing,
            amount: amount
        }
      end
    end
  end

end
