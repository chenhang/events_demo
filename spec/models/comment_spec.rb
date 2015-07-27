require 'rails_helper'

describe Comment do
  before(:each) do
    team = Team.find_or_create_by(name: "test_team")
    @user = User.find_or_create_by(name: "test_user", team_id:team.id)
    @project = Project.find_or_create_by(name: "test_project", team_id:team.id)
    @access = Access.find_or_create_by(user_id: @user.id, project_id: @project.id)
    @todo = Todo.find_or_create_by(title: "test", content: "test", creator_id: @user.id)
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