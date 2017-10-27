require 'rails_helper'
describe 's005: as a Student, I can filter events that are relevant for me (B/M, Semester).' do
  include CategoriesHelper
  before :each do
    @e1 = Event.create(title: "Event 1", start_date: DateTime.new(2018,2,2,10,0), end_date:DateTime.new(2018,2,2,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
    @e1.create_planning_state(date_set: false, room_booked: true, announced: false, notes: 'prepare everything')
    @e2 = Event.create(title: "Event 2", start_date: DateTime.new(2018,7,27,10,0), end_date:DateTime.new(2018,7,27,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
    @e2.create_planning_state(date_set: true, room_booked: false, announced: true, notes: 'prepare everything')
    @e3 = Event.create(title: "Event 3", start_date: DateTime.new(2018,7,27,10,0), end_date:DateTime.new(2018,7,27,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
    @e3.create_planning_state(date_set: true, room_booked: false, announced: true, notes: 'prepare everything')
    @c1 = @e1.categories.create(name: "A")
    @c2 = @e2.categories.create(name: "B")
    @e3.categories << @c2
  end

  it 'shows all events without selection' do
    visit events_path
    expect(page).to have_content('Event 1')
    expect(page).to have_content('Event 2')
    expect(page).to have_content('Event 3')
  end

  it 'filters for category 1 - A' do
    visit events_path
    click_on cat_to_id(@c1)
    expect(page).to have_content('Event 1')
    expect(page).not_to have_content('Event 2')
    expect(page).not_to have_content('Event 3')
  end

  it 'filters for category 2 - B' do
    visit events_path
    click_on cat_to_id(@c2)
    expect(page).not_to have_content('Event 1')
    expect(page).to have_content('Event 2')
    expect(page).to have_content('Event 3')
  end

  it 'has a button to cancel category selection' do
    visit events_path
    click_on cat_to_id(@c2)
    click_on cat_to_id(@c1)
    click_on cat_to_id(:all)
    expect(page).to have_content('Event 1')
    expect(page).to have_content('Event 2')
    expect(page).to have_content('Event 3')
  end


end
