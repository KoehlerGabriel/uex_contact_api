
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a unique email" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is invalid with a duplicate email" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    expect(user).to_not be_valid
  end

  it "is valid with a password of at least 6 characters" do
    user = build(:user, password: "123456", password_confirmation: "123456")
    expect(user).to be_valid
  end

  it "is invalid with a password shorter than 6 characters" do
    user = build(:user, password: "12345", password_confirmation: "12345")
    expect(user).to_not be_valid
  end

  it "should have database authentication enabled" do
    expect(User).to respond_to(:find_for_database_authentication)
  end

  it "should allow user registration" do
    user = build(:user)
    expect(user).to be_valid
  end
end
