class Todo < ActiveRecord::Base
  include Eventable

  belongs_to :project
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :doer, class_name: "User"
  has_many :comments, as: :commentable

  validates :creator_id, presence: true
  validates :title, presence: true


  def event_content
    event_content = {
        creator_name: creator.name,
        title: title,
        content: content,
        status: status
    }
  end

  def parentable
    project
  end

  def create_events
    if !changes[:due].nil?
      create_event("change_due", event_content.update({old_due: due_was, due: due}))
    end

    if !changes[:doer_id].nil?
      if doer_id_was.nil?
        create_event("assign", event_content.update({doer_id: doer.id, doer_name: doer.name}))
      elsif doer_id.nil?
        create_event("remove_doer", event_content.update({old_doer_name: User.find(doer_id_was).name}))
      else
        create_event("change_doer", event_content.update({doer_id: doer.id, doer_name: doer.name,
                                                          old_doer_name: User.find(doer_id_was).name}))
      end
    end

    if !changes[:delete_at].nil?
      create_event("delete", event_content)
    end
    if !changes[:status].nil? && status == "finish"
      create_event("finish", event_content)
    end
  end


  def delete()
    self.update(delete_at: Time.now)
  end

  def finish()
    self.update(status: "finished")
  end

end
