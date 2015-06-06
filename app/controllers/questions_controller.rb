class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :show, :update, :destroy]
  before_action :set_event, only: [:new, :create]

  def index
    @questions = Question.all.reverse_order
  end

  def show
  end

  def new
    @username = current_user.name
    @question = @event.questions.new
  end

  def create    
    @question = @event.questions.create(copy: question_params[:copy], anonymous_flag: question_params[:anonymous_flag], event_id: @event.id, user_id: current_user.id)
    redirect_to @event, notice: 'Event was created.'
  end

  def edit
  end

  def update
  end

  def destroy
  end



  private

  def question_params
    params.require(:question).permit(:copy, :anonymous_flag)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end


end
