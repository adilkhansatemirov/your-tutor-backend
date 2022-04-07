class Tutor::TutorBlueprint < Blueprinter::Base
  identifier :id

  fields :email,
         :first_name,
         :last_name

  association :tutor_detail, blueprint: Tutor::TutorDetailBlueprint
end
