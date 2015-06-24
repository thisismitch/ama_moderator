class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :show, :update, :destroy, :close, :open]
  before_action :set_events

  def index
    set_users_questions_votes_count # for stat summary
  end

  def show
   	@questions = @event.questions
    @user = current_user

    if params[:sort] == 'date'
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
      redirect_to @event, alert: "Error: " + @event.errors.full_messages.to_sentence
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
    @event.update(closed: true)
    redirect_to :back, notice: 'Event was closed.'
  end

  def open
    authorize @event
    @event.update(closed: false)
    redirect_to :back, notice: 'Event was opened.'
  end


  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_events
    @events = Event.all
  end

  def set_users_questions_votes_count
    @users_count = User.count
    @questions_count = Question.count
    @votes_count = Vote.count
  end
end
