# frozen_string_literal: true

module EventsHelper
  def checkbox_id(event, marker)
    "event_#{event.id}_#{marker}"
  end
end
