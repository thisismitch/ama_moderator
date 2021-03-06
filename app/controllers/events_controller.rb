class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :show, :update, :destroy, :close, :open]
  before_action :set_events

  def index
    set_users_questions_votes_count # for stat summary
  end

  # most recently created
  def last
    if @events.empty?
      redirect_to events_path
    elsif @events.last.closed?
      redirect_to events_path
    else
      redirect_to event_path(@events.last)
    end
  end

  def show
    @user = current_user

    @questions = @event.questions
    @unapproved_anonymous_questions_count = @questions.where('anonymous_flag = true AND admin_approved_at IS NULL').count
    if anonymous_requires_admin_approval? && !@user.admin
      @questions = @questions.approved_anonymous
    end
    if params[:sort] == 'date' # reverse chronological
      @questions = @questions.reverse
    else
      @questions = @questions.sort_by(&:score).reverse  # popularity by default
    end
  end

  def new
    @event = Event.new
    authorize(@event)
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    authorize(@event)
    @event.save

    if @event.errors.any?
      render :new, alert: "Error: " + @event.errors.full_messages.to_sentence
    else
      redirect_to events_path, notice: "Event (#{@event.name}) was created."
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event

    @event.update(event_params)

    if @event.errors.any?
      redirect_to :back, alert: "Error: " + @event.errors.full_messages.to_sentence
    else
      redirect_to @event, notice: 'Event was updated.'
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_path, notice: 'Event was deleted.'
  end

  def close
    authorize @event
    @event.close
    redirect_to :back, notice: 'Event was closed.'
  end

  def open
    authorize @event
    @event.open
    redirect_to :back, notice: 'Event was opened.'
  end


  private

  def event_params
    params.require(:event).permit(:name, :scheduled_at, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_events
    @events = Event.interleaved_scheduled.page(params[:page]).per(20)
  end

  def set_users_questions_votes_count
    @users_count = User.count
    @questions_count = Question.count
    @votes_count = Vote.count
  end
end
