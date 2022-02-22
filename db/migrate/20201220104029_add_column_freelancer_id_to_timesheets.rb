class AddColumnFreelancerIdToTimesheets < ActiveRecord::Migration[6.0]
  def change
    add_column :timesheets, :freelancer_id, :bigint

    Timesheet.all.each do |timesheet|
      if timesheet.project.freelancer != nil
        timesheet.update(freelancer_id: timesheet.project.freelancer.id)
      end
    end
  end
end
