class AddFreelancerCostToFreelancerDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :freelacer_details, :work_hours_per_week, :integer
    add_column :freelacer_details, :desired_hourly_rate, :integer
  end
end
