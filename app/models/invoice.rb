class Invoice < ApplicationRecord
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
                      tsearch: { prefix: true }
                  }

  belongs_to :project
  has_one :client_detail, through: :project, source: :client_detail
  has_one :freelancer_detail, through: :project, source: :freelancer_detail

  has_one :client, through: :client_detail, source: :user
  has_one :freelancer, through: :freelancer_detail, source: :user
  enum invoice_status: { draft: 0, sent: 1, paid: 2, error: 3 }

  has_many :invoice_items, dependent: :delete_all
end
