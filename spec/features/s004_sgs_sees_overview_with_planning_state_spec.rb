require 'rails_helper'
describe 's004: sgs sees overview with planning information' do

  before :each do
    p1 = create(:planning_state_1)
    p2 = create(:planning_state_2)
    @e1 = p1.event
    @e2 = p2.event
  end

  context '(when logged in)' do
    before :each do
      user = User.create(email: 'someone@htw-berlin.de', password: 'geheimgeheim', password_confirmation: 'geheimgeheim')
      login_as(user, :scope => :user)
    end
    it 'shows the events' do
      visit planning_path
      expect(page).to have_content(@e1.title)
      expect(page).to have_content(@e2.title)
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
