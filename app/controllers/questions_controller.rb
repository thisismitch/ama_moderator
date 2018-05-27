class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :show, :update, :destroy, :approve, :disapprove]
  before_action :set_event, only: [:new, :create]
  before_action :set_events

  def show
    @user = current_user
  end

  def new
    @question = @event.questions.new
    authorize(@question)
  end

  def create
    if anonymous_enabled? && question_params[:anonymous_flag] == '1'
      @question = @event.questions.create(question_params.merge(event_id: @event.id, user_id: User.find_by(name: 'Anonymous').id))
    else
      @question = @event.questions.create(question_params.merge(event_id: @event.id, user_id: current_user.id))
    end
    authorize(@question)

    if @question.errors.any?
      redirect_to :back, alert: "Error: " + @question.errors.full_messages.to_sentence
    else
      redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question was created.'
    end
  end

  def edit
    authorize(@question)
    @event = @question.event
  end

  def update
    authorize(@question)

    if anonymous_enabled? && question_params[:anonymous_flag] == '1'
      @question.update(question_params.merge(user_id: User.find_by(name: 'Anonymous').id))
    else
      @question.update(question_params)
    end

    if @question.errors.any?
      redirect_to :back, alert: "Error: #{@question.errors.full_messages.to_sentence}"
    else
      redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question was updated.'
    end
  end

  def approve
    authorize(@question)
    @question.update_columns(admin_approved_at: Time.now, admin_approved_by_user_id: current_user.id)
    redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question was approved.'
  end

  def disapprove
    authorize(@question)
    @question.update_columns(admin_approved_at: nil, admin_approved_by_user_id: nil)
    redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question was disapproved.'
  end

  def destroy
    authorize(@question)

    event_id = @question.event_id
    @question.destroy
    redirect_to event_path(event_id), notice: "Question was destroyed."
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

  def set_events
    @events = Event.all
  end
end
