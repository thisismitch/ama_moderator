class QuestionsController < ApplicationController
  def new
  end

  def index
    @questions = Question.all
  end


  def show
  	@question = Question.find(params[:id])
  end

  def create
  	@event = Event.first
  	@user = User.find_by(name: 'Mitchell Anicas')
  	
  	@question = Question.create(params.require(:question).permit(:copy, :anonymous_flag), event_id: @event.id, user_id: @user.id)
  	redirect_to @question
  end

end
