module EventsHelper
  def format_datetime(event_datetime)
    unless event_datetime.nil?
      event_datetime.strftime('%B %d, %Y at %-l:%M%p')
    end
  end

  def relative_time_to_event(event)
    if !event.closed? && !event.scheduled_at.nil?
      distance_of_time_in_words(DateTime.now, event.scheduled_at)
    end
  end

  def descending_events(events)
    events.reverse_order
  end
end
