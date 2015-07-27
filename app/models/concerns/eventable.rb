module Eventable
  extend ActiveSupport::Concern

  def event_content()
  end

  def create_event(creator, action, event_content)
    Event.create(creator_id: creator.id, eventable_id: self.id,
                 eventable_type: self.class.name, action: action,
                 project_id: self.project_id, content: event_content.to_json)
  end

end