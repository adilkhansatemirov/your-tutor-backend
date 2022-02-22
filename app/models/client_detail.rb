class ClientDetail < ApplicationRecord
  belongs_to :user

  include PgSearch::Model

  pg_search_scope :search,
                  against: [
                    :company_name,
                  ],
                  associated_against: {
                    user: [:first_name, :last_name, :email],
                  },
                  using: {
                    tsearch: { prefix: true },
                  }
end
