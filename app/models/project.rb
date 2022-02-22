class Project < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search,
                  against: [
                    :title,
                  ],
                  associated_against: {
                    client_detail: :company_name,
                    client: [:first_name, :last_name, :email],
                    freelancer: [:first_name, :last_name, :email]
                  },
                  using: {
                    tsearch: { prefix: true },
                  }

  enum project_status: { accepting_bids: 0, active: 1, inactive: 2, error: 3 }
  # assigning_freelancer: 4
  enum invoicing_schedule: { one_time: 0, weekly: 1, bi_weekly: 2 }
  enum client_type_of_billing: { custom_type: 0, hourly_rate: 1 }

  belongs_to :freelancer_detail, optional: true
  belongs_to :client_detail
  has_one :client, through: :client_detail, source: :user
  has_one :freelancer, through: :freelancer_detail, source: :user
  has_many :invoices, dependent: :delete_all
  has_many :project_bids, dependent: :delete_all
  has_many :timesheets, dependent: :delete_all
end
