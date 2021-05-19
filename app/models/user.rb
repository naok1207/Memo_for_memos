# == Schema Information
#
# Table name: users
#
#  id                           :bigint           not null, primary key
#  access_token                 :string(255)      not null
#  crypted_password             :string(255)
#  email                        :string(255)      not null
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  salt                         :string(255)
#  username                     :string(255)      not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_access_token       (access_token)
#  index_users_on_email              (email) UNIQUE
#  index_users_on_remember_me_token  (remember_me_token)
#  index_users_on_username           (username) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!
  VALID_USERNAME_NGWORD = /login|logout|signup|categories|category|memos/
  VALID_USERNAME_REGEX = /\A[A-Za-z][A-Za-z0-9]*/i
  VALID_EMAIL_REGEX = /[\w\-._]+@[\w\-._]+\.[A-Za-z]+/
  before_save { self.email = email.downcase }
  before_create :generate_access_token
  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 30 }
  validates_format_of :username, with: VALID_USERNAME_REGEX
  validates_format_of :username, without: VALID_USERNAME_NGWORD
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8, maximum: 24 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :access_token, presence: true, uniqueness: true

  has_many :categories, dependent: :destroy
  has_many :memos, dependent: :nullify

  def to_param
    username
  end

  private
  def generate_access_token
    self.access_token = loop do
      hex = SecureRandom.hex(10)
      break hex unless self.class.exists?(access_token: hex)
    end
  end
end
