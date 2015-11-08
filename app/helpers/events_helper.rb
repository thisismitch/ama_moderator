module EventsHelper
  def format_datetime(event_datetime)
    unless event_datetime.nil?
      event_datetime.strftime('%B %d, %Y at%l:%M%p')
    end
  end

  def descending_events(events)
    events.order(scheduled_datetime: :desc, created_at: :desc)
  end

end