class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :show, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @event = Event.first
    @user = User.find_by(name: 'Mitchell Anicas')
    ## Above code is for testing
    
    @question = Question.create(copy: question_params[:copy], event_id: @event.id, user_id: @user.id)
    redirect_to @question
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

end
