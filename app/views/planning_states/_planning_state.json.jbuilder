json.extract! planning_state, :id, :event_id, :date_set, :room_booked, :announced, :notes, :created_at, :updated_at
json.url planning_state_url(planning_state, format: :json)
