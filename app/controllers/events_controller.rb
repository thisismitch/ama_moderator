class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :show, :update, :destroy]

  def index
  	@events = Event.all.reverse_order
  end

  def show
   	@questions = Event.find(params[:id]).questions.reverse_order
  end

  def new
    @event = Event.new
  end

  def create
    @user = current_user.id
    
    @event = Event.create(event_params)
    redirect_to @event, notice: 'Event was created.'
  end

  def edit
  end

  def update
    @event.update(event_params)
    redirect_to @event, notice: 'Event was updated.'
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event was deleted.'
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
