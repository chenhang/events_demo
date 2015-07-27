require 'rails_helper'

describe Comment do
  before(:each) do
    team = Team.create(name: "test_team")
    @user = User.create(name: "test_user", team_id:team.id)
    @project = Project.create(name: "test_project", team_id:team.id)
    @access = Access.create(user_id: @user.id, project_id: @project.id)
    @todo = Todo.create(title: "test", content: "test", creator_id: @user.id)
  end
  it "is valid with creator and commentable" do
    expect(Comment.new(creator_id: @user.id, commentable_id: @todo.id, commentable_type: @todo.class.to_s)).to be_valid
  end
  it "is invalid without creator_id" do
    comment = Comment.new(creator_id: nil, commentable_id: @todo.id, commentable_type: @todo.class.to_s)
    comment.valid?
    expect(comment.errors[:creator_id]).to include "can't be blank"
  end
  it "is invalid without commentable_id" do
    comment = Comment.new(creator_id: @user.id, commentable_id: nil, commentable_type: @todo.class.to_s)
    comment.valid?
    expect(comment.errors[:commentable_id]).to include "can't be blank"
  end
  it "is invalid without commentable_type" do
    comment = Comment.new(creator_id: @user.id, commentable_type: nil, commentable_id: @todo.id)
    comment.valid?
    expect(comment.errors[:commentable_type]).to include "can't be blank"
  end
end