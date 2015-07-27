require 'rails_helper'

describe Access do
  before(:each) do
    team = Team.create(name: "test_team")
    @user = User.create(name: "test_user", team_id:team.id)
    @project = Project.create(name: "test_project", team_id:team.id)
  end
  it "is valid with both user and project" do
    expect(Access.new(user_id: @user.id, project_id: @project.id)).to be_valid
  end
  it "is invalid without user" do
    access = Access.new(user_id: nil, project_id: @project.id)
    access.valid?
    expect(access.errors[:user_id]).to include "can't be blank"
  end
  it "is invalid without project" do
    access = Access.new(user_id: @user.id, project_id: nil)
    access.valid?
    expect(access.errors[:project_id]).to include "can't be blank"
  end
end