require 'rails_helper'

describe Event, do
  context "after which can add a new event " do
    before(:each) do
      team = Team.create(name: "test_team")
      @user = User.create(name: "test_user", team_id:team.id)
      @project = Project.create(name: "test_project", team_id:team.id)
      @access = Access.create(user_id: @user.id, project_id: @project.id)
      @todo = Todo.create(title: "test", content: "test", creator_id: @user.id)
    end

    it "after create a todo" 
    it "after destroy a todo"
    it "after finish a todo"
    it "after assign a todo to a user"
    it "after change the doer of a todo"
    it "after change the due date of a todo"
    it "after create a new comment"
  end
end