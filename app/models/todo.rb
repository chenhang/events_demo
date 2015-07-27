class Todo < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: "User", :foreign_key => "creator_id"
  belongs_to :doer, class_name: "User", :foreign_key => "doer_id"
  has_many :comments, as: :commentable
end
