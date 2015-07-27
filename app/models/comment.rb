class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :creator, class_name: "User", :foreign_key => "creator_id"

  validates :creator_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
end
