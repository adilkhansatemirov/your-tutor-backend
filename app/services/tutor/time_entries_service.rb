module Freelancer::TimeEntriesService

  def self.create_time_entry(params)
    time_entry = TimeEntry.new(params)
    time_entry.save
  end

  def self.update_time_entry(params, time_entry_id)
    time_entry = TimeEntry.find(time_entry_id)
    time_entry.update(params)
  end

  def self.delete_time_entry(time_entry_id)
    time_entry = TimeEntry.find(time_entry_id)
    time_entry.destroy
  end

  def self.create_multiple(items, timesheet_id)
    time_entries = []
    items.each do |time_entry|
      time_entries << TimeEntry.new(
        timesheet_id: timesheet_id,
        task: time_entry[:task],
        customer: time_entry[:customer],
        hours: time_entry[:hours],
      )
    end

    TimeEntry.import time_entries, on_duplicate_key_update: {
                                     conflict_target: [:id],
                                     columns: [:timesheet_id, :task, :customer, :hours],
                                   }
  end

end
