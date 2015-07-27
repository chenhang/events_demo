class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def content
    JSON.parse(self.content)
  end

  def content=(dict)
    self.content = dict.to_json
  end
end