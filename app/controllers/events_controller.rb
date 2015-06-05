class EventsController < ApplicationController
  def index
  	@events = Event.all
  end

  def show
  	# view event (list questions) - add event ID parameter
  	
  	@event = Event.find(params[:id])  # replace with next line
  	@questions = @event.questions

  	
  	### Test stuff
  	# @question = @event.questions.first
  	# @username = @question.user.name
  end

  def new
  end

  private

  def render_question(id)

  end
end
