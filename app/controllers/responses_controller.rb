class ResponsesController < ApplicationController
  before_action :set_response, only: [:edit, :update, :destroy, :approve, :disapprove]
  before_action :set_question, only: [:index, :new, :create]
  before_action :set_events

  def index
    @user = current_user

    @responses = @question.responses
    @unapproved_anonymous_responses_count = @responses.where('anonymous_flag = true AND admin_approved_at IS NULL').count
    if anonymous_requires_admin_approval? && !@user.admin
      @responses = @responses.approved_anonymous
    end
    @responses = @responses.sort_by(&:created_at)

    @event = @question.event
  end

  def new
    @user = current_user
    @event = @question.event
    @responses = @question.responses.sort_by(&:created_at) # load existing responses
    @response = @question.responses.new
  end

  def create
    if anonymous_enabled? && response_params[:anonymous_flag] == '1'
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
    if anonymous_enabled? && response_params[:anonymous_flag] == '1'
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

  def approve
    authorize(@response)
    @response.update_columns(admin_approved_at: Time.now, admin_approved_by_user_id: current_user.id)
    redirect_to question_responses_path(@response.question_id, anchor: "response_#{@response.id}"), notice: 'Response was approved.'
  end

  def disapprove
    authorize(@response)
    @response.update_columns(admin_approved_at: nil, admin_approved_by_user_id: nil)
    redirect_to question_responses_path(@response.question_id, anchor: "response_#{@response.id}"), notice: 'Response was disapproved.'
  end

  private

  def response_params
    params.require(:response).permit(:copy, :anonymous_flag)
  end

  def set_response
    @response = Response.find(params[:id])
  end

  def set_question
    if anonymous_requires_admin_approval? && !current_user.admin
      @question = Question.approved_anonymous.find(params[:id])
    else
      @question = Question.find(params[:id])
    end
  end

  def set_events
    @events = Event.all
  end
end
