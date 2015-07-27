class Todo < ActiveRecord::Base
  include Eventable

  belongs_to :project
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :doer, class_name: "User"
  has_many :comments, as: :commentable

  validates :creator_id, presence: true
  validates :title, presence: true
  after_create do
    create_event(creator, "add", event_content)
  end

  def event_content
    event_content = {
        creator_name: creator.name,
        title: title,
        content: content,
        status: status
    }
  end


  def delete(user)
    self.destroy
    self.create_event(user, "destroy", self.event_content)
  end

  def assign(user, doer)
    action = "assign"
    if self.doer.present?
      action = "change_doer"
    end
    self.doer = doer
    if self.save
      self.create_event(user, action, self.event_content.update({
                                                                    doer_id: doer.id,
                                                                    doer_name: doer.name
                                                                }))
    end
  end

  def change_due(user, due)
    old_due = self.due
    self.due=due
    if self.save
      self.create_event(user, "change_due", self.event_content.update({
                                                                          old_due: old_due,
                                                                          due: due
                                                                      }))
    end
  end

  def finish(user)
    self.status = "finished"
    if self.save
      self.create_event(user, "finish", self.event_content)
    end
  end
end
