class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  before_save { self.email = email.downcase }

  has_secure_password

  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  def self.search(query)
    return self unless query

    User.where('LOWER(username) LIKE ? OR email LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%")
  end
end
