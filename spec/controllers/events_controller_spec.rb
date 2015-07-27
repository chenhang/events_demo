require 'rails_helper'

describe EventsController do
  before(:each) do
    @team = Team.create(name: "test_team")
    @user = User.create(name: "test_user", team_id: @team.id)
    @project = Project.create(name: "test_project", team_id: @team.id)
    @access = Access.create(user_id: @user.id, project_id: @project.id)
    @todo = Todo.create(title: "test", content: "test", creator_id: @user.id)
  end

  it "render events index view" do
    get :index
    expect(response).to render_template :index
  end
end
