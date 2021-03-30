class User < ApplicationRecord
  before_save :downcase_email

  private

  validates :name, presence: true
  validates :email, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
    length: {maximum: Settings.users.email.max_length},
    format: {with: VALID_EMAIL_REGEX}

  def downcase_email
    email.downcase!
  end

  has_secure_password
end
