class QuestionPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize(user, question)
    @user = user
    @question = question
  end

  def edit?
  	user.id == question.user_id
  end

  def update?
    user.id == question.user_id
  end

  def destroy?
  	user.id == question.user_id || user.admin?
  end
end