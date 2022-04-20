class Timesheet < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search,
                  against: [],
                  associated_against: {
                      project: [:title],
                      student_detail: [:company_name],
                      student: [:first_name, :last_name, :email],
                      tutor: [:first_name, :last_name, :email]
                  },
                  using: {
                      tsearch: { prefix: true },
                  }

  enum timesheet_status: { edited: 0, submitted: 1, approved: 2, rejected: 3, paid: 4 }

  belongs_to :project
  has_one :student_detail, through: :project, source: :student_detail
  has_one :student, through: :student_detail, source: :user

  belongs_to :tutor, class_name: 'User'
  has_many :time_entries
end
