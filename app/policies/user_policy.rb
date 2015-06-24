class UserPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, event)
    @user = user
    @event = event
  end

  def index?
  	user.admin?
  end

  def update?
    user.admin?
  end
end