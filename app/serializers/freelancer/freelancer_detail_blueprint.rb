module Freelancer
  class FreelancerDetailBlueprint < Blueprinter::Base
    identifier :id

    fields :desired_hourly_rate,
           :work_hours_per_week,
           :resume_url,
           :public_id

  end
end
