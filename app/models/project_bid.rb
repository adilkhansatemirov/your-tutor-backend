class ProjectBid < ApplicationRecord
  enum bids_status: { new_project: 0, applied: 1, awarded: 2, rejected: 3, seen: 4 }

  belongs_to :user
  belongs_to :project
end
