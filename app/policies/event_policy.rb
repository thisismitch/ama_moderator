class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def new?
  	user.admin?
  end

  def create?
  	user.admin? 
  end

  def edit?
  	user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
  	user.admin?
  end

  def close?
    user.admin?
  end

  def open?
    user.admin?
  end
end