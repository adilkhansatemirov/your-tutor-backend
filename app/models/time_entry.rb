class TimeEntry < ApplicationRecord
  belongs_to :timesheet
  has_one :invoice_item, dependent: :nullify
end
