class ResponsesController < ApplicationController
  before_action :set_response, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:index, :new, :create]

  def index
    @user = current_user
    @responses = @question.responses
  end

  def new
    @user = current_user
    @responses = @question.responses
    @response = @question.responses.new
  end

  def create
    @response = @question.responses.create(copy: response_params[:copy], anonymous_flag: response_params[:anonymous_flag], question_id: @question.id, user_id: current_user.id)

    if @response.errors.any?
      redirect_to :back, alert: "Error: " + @response.errors.full_messages.to_sentence
    else
      redirect_to question_responses_path(@question.id), notice: 'Response was created.'
    end
  end

  def destroy
  end

  def edit
  end

  def update
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
end
