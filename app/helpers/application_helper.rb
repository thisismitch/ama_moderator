module ApplicationHelper
  def anonymous_enabled?
    Rails.configuration.x.enable_anonymous
  end
end
