require 'rails_helper'

describe Todo do
  before(:each) do
    team = Team.create(name: "test_team")
    @user = User.create(name: "test_user", team_id:team.id)
    @project = Project.create(name: "test_project", team_id:team.id)
    @access = Access.create(user_id: @user.id, project_id: @project.id)
  end
  it "is valid with creator title" do
    expect(Todo.new(title: "test", content: "test", creator_id: @user.id)).to be_valid
  end
  it "is invalid without creator_id" do
    todo = Todo.new(title: "test", content: "test", creator_id: nil)
    todo.valid?
    expect(todo.errors[:creator_id]).to include "can't be blank"
  end
  it "is invalid without title" do
    todo = Todo.new(title: nil, content: "test", creator_id: @user.id)
    todo.valid?
    expect(todo.errors[:title]).to include "can't be blank"
  end
end