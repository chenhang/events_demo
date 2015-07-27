class EventsController < ApplicationController
  def index
    @team = Team.find(1)
    @project = Project.find(2)
    @events = @project.events.order(created_at: :desc)
  end
end
