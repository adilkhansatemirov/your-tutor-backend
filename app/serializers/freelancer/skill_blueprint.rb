class Freelancer::SkillBlueprint < Blueprinter::Base
  identifier :id

  fields :category,
         :sub_category,
         :skill
end
