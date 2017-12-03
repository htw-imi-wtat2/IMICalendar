# frozen_string_literal: true

json.extract! event, :id, :title, :start_date, :end_date, :location, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
