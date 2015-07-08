class QuestionPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize(user, question)
    @user = user
    @question = question
  end

  def edit?
  	(user.id == question.user_id && !question.event.closed)
  end

  def update?
    (user.id == question.user_id && !question.event.closed)
  end

  def destroy?
  	(user.id == question.user_id && !question.event.closed) || user.admin?
  end

  def new?
    !question.event.closed
  end

  def create?
    !question.event.closed
  end
end