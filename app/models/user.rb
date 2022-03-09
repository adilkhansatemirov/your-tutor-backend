class User < ActiveRecord::Base
  extend Devise::Models
  include PgSearch::Model

  pg_search_scope :search,
                  against: [
                    :first_name,
                    :last_name,
                    :role,
                    :email
                  ],
                  using: {
                    tsearch: { prefix: true }
                  }

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  enum role: { admin: 0, tutor: 1, student: 2 }
  validates :first_name, :last_name, presence: true

  has_one :tutor_detail, dependent: :delete
  has_one :student_detail, dependent: :delete
  has_many :tutor_skills, dependent: :delete_all

  def token
    JsonWebToken.encode(
      user_id: id,
      email: email
    )
  end

end
