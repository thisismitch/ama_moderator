module ApplicationHelper
  def anonymous_enabled?
    Rails.configuration.x.enable_anonymous
  end

  def anonymous_approval_required?
    anonymous_enabled? && Rails.configuration.x.anonymous_requires_admin_approval
  end
end
