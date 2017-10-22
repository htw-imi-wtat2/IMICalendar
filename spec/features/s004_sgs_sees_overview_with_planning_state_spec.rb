require 'rails_helper'
describe 's004: sgs sees overview with planning information' do

  before :each do
    @e1 = Event.create(title: "Event1", start_date: DateTime.new(2018,2,2,10,0), end_date:DateTime.new(2018,2,2,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
    @e1.create_planning_state(date_set: false, room_booked: true, announced: false, notes: 'prepare everything')
    @e2 = Event.create(title: "Event2", start_date: DateTime.new(2018,7,27,10,0), end_date:DateTime.new(2018,7,27,17,0), location: "H001", description: "Präsentation und Messe der IMI-B und IMI-M Projekte des aktuellen Semesters" )
    @e2.create_planning_state(date_set: true, room_booked: false, announced: true, notes: 'prepare everything')
  end

  context '(when logged in)' do
    before :each do
      user = User.create(email: 'someone@htw-berlin.de', password: 'geheimgeheim', password_confirmation: 'geheimgeheim')
      login_as(user, :scope => :user)
    end
    it 'shows the events' do
      visit planning_path
      expect(page).to have_content('Event1')
      expect(page).to have_content('Event2')
    end

    it "shows the planning details for events" do
      [@e1, @e2].each do |e|
        ['date_set','room_booked','announced'].each do |m|
          visit planning_path
          expect(find("##{checkbox_id(e, m)}").checked?).to eq e.planning_state.send(m)
        end
      end
    end
  end
end
