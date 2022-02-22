class Freelancer::FreelancerBlueprint < Blueprinter::Base
  identifier :id

  fields :email,
         :first_name,
         :last_name

  association :freelancer_detail, blueprint: Freelancer::FreelancerDetailBlueprint
end
