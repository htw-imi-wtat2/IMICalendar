FactoryBot.define do
  factory :planning_state_1, class: PlanningState do
    date_set false
    room_booked true
    announced false
    notes 'prepare everything'
    association :event, factory: :e1
  end

  factory :planning_state_2, class: PlanningState do
    date_set true
    room_booked false
    announced true
    notes 'prepare everything'
    association :event, factory: :e2
  end

  factory :planning_state_3, class: PlanningState do
    date_set true
    room_booked false
    announced true
    notes 'prepare everything'
    association :event, factory: :e2
  end

end
