# == Schema Information
#
# Table name: users
#
#  id                           :bigint           not null, primary key
#  access_token                 :string(255)      not null
#  avatar                       :string(255)
#  crypted_password             :string(255)
#  email                        :string(255)      not null
#  introduction                 :text(65535)
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  role                         :integer          default(0), not null
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
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid" do
    user = User.new(
      username: "test-user",
      email: "test@example.com",
      password: "testpass",
      password_confirmation: "testpass"
    )
    expect(user).to be_valid
  end
end
