class EventController < ApplicationController
  def view
  	# view event (list questions) - add event ID parameter
  	
  	@event = Event.first  # replace with next line
  	#@event = Event.find(idparam)
  	@questions = @event.questions

  	
  	### Test stuff
  	@question = @event.questions.first
  	@username = @question.user.name
  end

  private

  def render_question(id)

  end
end
