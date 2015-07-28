require 'rails_helper'

describe Project do
  it "is valid with a name" do
    expect(User.new(name: 'test_project')).to be_valid
  end
  it "is invalid without a name" do
    project = Project.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end
  # it "is invalid to have a duplicate name for project in same team" do
  #   team = Team.create(name: "test_team")
  #   project_a = Project.create(name: "test_project_a", team_id: team.id)
  #   project_b = Project.new(name: "test_project_a", team_id: team.id)
  #   project_b.valid?
  #   expect(project_b.errors[:name]).to include("is duplicated in project's team")
  # end

end