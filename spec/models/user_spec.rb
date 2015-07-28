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
  # it "is invalid to have a duplicate name for user in same team" do
  #   team = Team.create(name: "test_team")
  #   user_a = User.create(name: "test_user_a", team_id: team.id)
  #   user_b = User.new(name: "test_user_a", team_id: team.id)
  #   user_b.valid?
  #   expect(user_b.errors[:name]).to include("is duplicated in user's team")
  # end

end