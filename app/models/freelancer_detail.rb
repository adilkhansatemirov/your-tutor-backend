class FreelancerDetail < ApplicationRecord
  belongs_to :user
  has_many :project, :dependent => :nullify

  include PgSearch::Model

  pg_search_scope :search,
                  against: [],
                  associated_against: {
                      user: [:first_name, :last_name, :email],
                  },
                  using: {
                      tsearch: { prefix: true },
                  }

end
