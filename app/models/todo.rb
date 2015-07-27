class Todo < ActiveRecord::Base
  include Eventable
  belongs_to :project
  belongs_to :creator, class_name: "User", :foreign_key => "creator_id"
  belongs_to :doer, class_name: "User", :foreign_key => "doer_id"
  has_many :comments, as: :commentable

  validates :creator_id, presence: true
  validates :title, presence: true

  after_create do
    self.create_event(self.creator, "add", self.event_content)
  end

  def event_content()
    {
        creator_name: self.creator.name,
        title: title,
        content: content,
        due: due,
        doer_id: doer.id,
        doer_name: doer.name,
        status: status
    }
  end


  def destroy(user)
    self.destroy!
    self.create_event(self.creator, "destroy", self.event_content)
  end
  def assign(user,doer)
    action = "assign"
    if self.doer.present?
      action = "change_doer"
    end
    self.doer = doer
    if self.save
      self.create_event(user, action, self.event_content)
    end
  end

  def change_due(user, due)
    self.due=due
    if self.save
      self.create_event(user, "change_due", self.event_content)
    end
  end

  def finish(user)
    self.status = "finished"
    if self.save
      self.create_event(user, "finish", self.event_content)
    end
  end
end
