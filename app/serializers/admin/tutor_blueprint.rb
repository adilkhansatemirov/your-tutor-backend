class Admin::TutorBlueprint < Blueprinter::Base
  identifier :id

  fields :email,
         :first_name,
         :last_name,
         :image

  field :profile_status do |user|
    if user.is_blocked?
      'blocked'  
    elsif Project.where(tutor_detail_id: user.tutor_detail.id).exists?
      'billing'
    elsif user.tutor_detail.qualified?
      'approved'
    else
      'pending_approval'
    end
  end

  field :specialization do |user|
    tutor_skill_groups = []
    user.tutor_skills.each do |skill|
      tutor_skill_groups.push(skill.skill.category)
    end
    tutor_skill_groups.uniq
  end

  association :tutor_detail, blueprint: Admin::TutorDetailBlueprint

  view :extended do
    field :skills do |user|
      skills = []
      user.tutor_skills.each do |tutor_skill|
        skills.push(tutor_skill.skill)
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
      user.tutor_detail.project.map do |project|
        if project.student_type_of_billing == "custom_type"
          amount = project.tutor_payment_amount
        else
          hours = 0
          project.timesheets.each do |timesheet|
            hours += timesheet.time_entries.sum(&:hours)
          end
          amount = hours * project.tutor_payment_amount
        end
        {
            id: project.id,
            title: project.title,
            student_detail: project.student_detail.user.as_json,
            company_name: project.student_detail.company_name,
            type: project.student_type_of_billing,
            amount: amount
        }
      end
    end
  end

end
