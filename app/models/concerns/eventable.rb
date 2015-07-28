module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable
  end

  def event_content
  end

  def create_event(creator, action, event_content)
    Event.create(user_id: creator.id, user_name: creator.name,
                 eventable: self,
                 action: action,
                 parentable: self.parentable,
                 content: event_content.to_json)
  end

end