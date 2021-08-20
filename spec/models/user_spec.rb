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
