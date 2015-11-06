module EventsHelper
  def format_datetime(event_datetime)
    unless event_datetime.nil?
      event_datetime.strftime("%B %d, %Y at%l:%M%p")
    end
  end
end
