class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :eventable, polymorphic: true
  belongs_to :parentable, polymorphic: true

  def event_content
    JSON.parse(self.content)
  end

  def event_content=(dict)
    self.content = dict.to_json
  end
end