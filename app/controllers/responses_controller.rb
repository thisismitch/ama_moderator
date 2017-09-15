class ResponsesController < ApplicationController
  before_action :set_response, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:index, :new, :create]
  before_action :set_events

  def index
    @user = current_user
    @responses = @question.responses.sort_by(&:created_at)
    @event = @question.event
  end

  def new
    @user = current_user
    @event = @question.event
    @responses = @question.responses.sort_by(&:created_at) # load existing responses
    @response = @question.responses.new
  end

  def create
    if response_params[:anonymous_flag] == '1'
      @response = @question.responses.create(response_params.merge(question_id: @question.id, user_id: User.find_by(name: 'Anonymous').id))
    else
      @response = @question.responses.create(response_params.merge(question_id: @question.id, user_id: current_user.id))
    end

    if @response.errors.any?
      redirect_to :back, alert: "Error: " + @response.errors.full_messages.to_sentence
    else
      redirect_to question_responses_path(@question.id, anchor: "response_#{@response.id}"), notice: 'Response was created.'
    end
  end

  def destroy
    authorize(@response)

    question_id = @response.question_id
    @response.destroy
    redirect_to question_responses_path(question_id), notice: "Response was destroyed."
  end

  def edit
    authorize(@response)
    @question = @response.question
    @event = @question.event
    @user = @response.user
    @responses = @question.responses
  end

  def update
    authorize(@response)
    if response_params[:anonymous_flag] == '1'
      @response.update(response_params.merge(user_id: User.find_by(name: 'Anonymous').id))
    else
      @response.update(response_params)
    end

    if @response.errors.any?
      redirect_to :back, alert: "Error: #{@response.errors.full_messages.to_sentence}"
    else
      redirect_to question_responses_path(@response.question_id, anchor: "response_#{@response.id}"), notice: 'Response was updated.'
    end
  end

  private

  def response_params
    params.require(:response).permit(:copy, :anonymous_flag)
  end

  def set_response
    @response = Response.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_events
    @events = Event.all
  end
end
