module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable
    after_create do
      self.handler = creator
      create_event("add", event_content)
    end
    after_update :create_events
  end

  attr_accessor :handler

  def create_events
  end

  def event_content
  end

  def create_event(action, event_content)
    Event.create(user_id: handler.id, user_name: handler.name,
                 eventable: self,
                 action: action,
                 parentable: self.parentable,
                 content: event_content.to_json)
  end

end