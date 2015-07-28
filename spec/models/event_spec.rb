require 'rails_helper'

describe Event do
  before(:each) do
    @team = Team.create(name: "test_team")
    @user = User.create(name: "test_user", team_id: @team.id)
    @project = Project.create(name: "test_project", team_id: @team.id)
    @access = Access.create(user_id: @user.id, project_id: @project.id)
    @todo = Todo.create(title: "test", content: "test", creator_id: @user.id, handler: @user)
  end

  it "after create a todo" do
    new_todo = Todo.create(title: "new_todo", content: "new_todo", creator_id: @user.id, handler: @user)
    expect(Event.where(user_id: @user.id, eventable_id: new_todo.id,
                       eventable_type: new_todo.class.name, action: "add")).not_to be_nil
  end
  it "is created after destroy a todo" do
    @todo.delete
    expect(Event.where(user_id: @user.id, eventable_id: @todo.id,
                       eventable_type: @todo.class.name, action: "destroy")).not_to be_nil
  end
  it "is created after finish a todo" do
    @todo.finish
    expect(Event.where(user_id: @user.id, eventable_id: @todo.id,
                       eventable_type: @todo.class.name, action: "finish")).not_to be_nil
  end
  it "is created after assign a todo to a user" do
    @todo.update(doer: @user)
    expect(Event.where(user_id: @user.id, eventable_id: @todo.id,
                       eventable_type: @todo.class.name, action: "assign")).not_to be_nil
  end
  it "is created after change the doer of a todo" do
    @todo.update(doer: @user)

    @todo.update(doer: User.create(name: "new_doer", team_id: @team.id))
    expect(Event.where(user_id: @user.id, eventable_id: @todo.id,
                       eventable_type: @todo.class.name, action: "change_doer")).not_to be_nil
  end
  it "is created after change the due date of a todo" do
    @todo.update(due: Time.now)
    expect(Event.where(user_id: @user.id, eventable_id: @todo.id,
                       eventable_type: @todo.class.name, action: "change_due")).not_to be_nil
  end
  it "is created after create a new comment" do
    comment = Comment.create(creator_id: @user, commentable: @todo, content: "test")
    expect(Event.where(user_id: @user.id, eventable_id: comment.id,
                       eventable_type: comment.class.name, action: "add")).not_to be_nil
  end
end
