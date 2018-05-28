class UsersController < ApplicationController
  before_action :set_users
  before_action :set_events
  before_action :set_user, only: [:show_questions, :show_votes]

  def index
    authorize(@users)
  end

  def update
    authorize(@users)
    set_user
    @user.update(admin: user_params[:admin])

    if @user.errors.any?
      redirect_to :back, alert: "Error: #{@user.errors.full_messages.to_sentence}"
    else
      redirect_to users_path, notice: "User (#{@user.name}) was updated."
    end
  end

  def show_questions
    @questions = @user.questions
    @questions = @questions.approved_anonymous if anonymous_requires_admin_approval? && !current_user.admin
    @questions = @questions.reverse
  end

  def show_votes
    @questions = Question.last(10) # broken. replace with questions that the user has voted on
  end

  private

  def set_events
    @events = Event.all
  end

  def set_users
    @users = User.all
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:admin)
  end
end
