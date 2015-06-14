class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :show, :update, :destroy]
  before_action :set_event, only: [:new, :create]

  def index
    @questions = Question.all.reverse_order
  end

  def show
    @user = current_user
  end

  def new
    @question = @event.questions.new
  end

  def create    
    @question = @event.questions.create(copy: question_params[:copy], anonymous_flag: question_params[:anonymous_flag], event_id: @event.id, user_id: current_user.id)

    if @question.errors.any?
      redirect_to :back, alert: "Error: " + @question.errors.full_messages.to_sentence
    else
      redirect_to @event, notice: 'Question was created.'
    end
  end

  def edit
    authorize(@question)
    @event = @question.event
  end

  def update
    authorize(@question)

    @question.update(question_params)

    if @question.errors.any?
      redirect_to :back, alert: "Error: #{@question.errors.full_messages.to_sentence}"
    else
      redirect_to event_path(@question.event_id), notice: 'Question was updated.'
    end
  end

  def destroy
    authorize(@question)

    event_id = @question.event_id
    @question.destroy
    redirect_to event_path(event_id), notice: "Question destroyed."
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
