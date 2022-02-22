class Payment < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search,
                  against: [
                    :description,
                  ],
                  using: {
                    tsearch: { prefix: true },
                  }

  enum payment_type: { charge: 0, payment: 1 }
end
