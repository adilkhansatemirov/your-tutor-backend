class Timesheet < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search,
                  against: [],
                  associated_against: {
                      project: [:title],
                      client_detail: [:company_name],
                      client: [:first_name, :last_name, :email],
                      freelancer: [:first_name, :last_name, :email]
                  },
                  using: {
                      tsearch: { prefix: true },
                  }

  enum timesheet_status: { edited: 0, submitted: 1, approved: 2, rejected: 3, paid: 4 }

  belongs_to :project
  has_one :client_detail, through: :project, source: :client_detail
  has_one :client, through: :client_detail, source: :user

  belongs_to :freelancer, class_name: 'User'
  has_many :time_entries
end
