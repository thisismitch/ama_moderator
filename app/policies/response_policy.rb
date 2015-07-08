class ResponsePolicy < ApplicationPolicy
  attr_reader :user, :response

  def initialize(user, response)
    @user = user
    @response = response
  end

  def edit?
  	user.id == response.user_id
  end

  def update?
    user.id == response.user_id
  end

  def destroy?
  	user.id == response.user_id || user.admin?

  end
end