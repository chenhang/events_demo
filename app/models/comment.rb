class Comment < ActiveRecord::Base
  include Eventable

  belongs_to :commentable, polymorphic: true
  belongs_to :creator, class_name: "User", :foreign_key => "creator_id"

  validates :creator_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  def handler
    creator
  end

  def parentable
    self.commentable.project
  end

  def event_content
    {
        content: content,
        commentable_id: commentable_id,
        commentable_type: commentable_type,
        commentable_title: commentable.title
    }
  end
end