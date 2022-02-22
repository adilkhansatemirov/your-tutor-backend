class Freelancer::FreelancerSkillBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id,
         :skill_id

  field :skill do |freelancer_skill|
    freelancer_skill.skill
  end
end
