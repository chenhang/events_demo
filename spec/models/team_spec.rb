require 'rails_helper'

describe Team do
  it "is valid with a name" do
    expect(Team.new(name: 'test_team')).to be_valid
  end
  it "is invalid without a name" do
    team = Team.new(name: nil)
    team.valid?
    expect(team.errors[:name]).to include("can't be blank")
  end
  it "is invalid to have a duplicate name" do
    Team.create(name: "test_team")
    team = Team.new(name: "test_team")
    team.valid?
    expect(team.errors[:name]).to include("has already been taken")
  end
end