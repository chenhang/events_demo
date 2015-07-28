
class EventsController < ApplicationController
  def index
    @team = Team.find(1)
    @user = User.find(1)
    @projects = @user.projects
    project_ids = @projects.map { |project| project[:id] }
    @events = Event.where(parentable_type: "Project")
                  .where("parentable_id in (?)", project_ids)
                  .paginate(page: params[:page], per_page: 50)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
