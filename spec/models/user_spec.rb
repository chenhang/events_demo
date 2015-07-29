require 'rails_helper'

describe User do
  it "is valid with a name" do
    expect(User.new(name: 'test_user')).to be_valid
  end
  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
end