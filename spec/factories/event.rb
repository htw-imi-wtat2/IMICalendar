
# frozen_string_literal: true

FactoryBot.define do
  factory :event, aliases: [:e1] do
    title 'Showtime WS 2017/18'
    start_date DateTime.new(2018, 2, 2, 10, 0)
    end_date DateTime.new(2018, 2, 2, 17, 0)
    location 'H001'
    description 'Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters'
  end

  factory :showtime_ss2018, aliases: [:e2], class: Event do
    title 'Showtime SS 2018'
    start_date DateTime.new(2018, 7, 27, 10, 0)
    end_date DateTime.new(2018, 7, 27, 17, 0)
    location 'H001'
    description 'Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters'
  end

  factory :info_praktikum, aliases: [:e3], class: Event do
    title 'Infoveranstaltung Auslandspraktikum IMI-B'
    start_date DateTime.new(2018, 11, 8, 0, 0)
    end_date DateTime.new(2018, 11, 8, 0, 0)
    description 'Informationen zum Auslandspraktikum: Anmeldung, Anerkennung, Finanzierung'
  end

  #  factory :event_with_planning_state_1, class: Event do
  #    title "Showtime WS 2017/18"
  #    start_date DateTime.new(2018,2,2,10,0)
  #    end_date DateTime.new(2018,2,2,17,0)
  #    location "H001"
  #    description "Präsentation und Messe der IMI-B und IMI-M Projekte des
  # aktuellen Semesters"
  #    association :planning_state, factory: :planning_state_1
  #    end
  #
  #  factory :event_with_planning_state_2, class: Event do
  #    title "Showtime SS 2018"
  #    start_date DateTime.new(2018,7,27,10,0)
  #    end_date DateTime.new(2018,7,27,17,0)
  #    location "H001"
  #    description "Präsentation und Messe der IMI-B und IMI-M Projekte des
  # aktuellen Semesters"
  #    association :planning_state, factory: :planning_state_2
  #
  #  end
end
