# frozen_string_literal: true

require 'rails_helper'
describe 'S001: SGS or an Admin user' do
  context '(when logged in)' do
    before :each do
      user = create(:user)
      login_as(user, scope: :user)

    end
    it 'can create events with planning state' do
      visit new_event_path
      # note that these are all ids rather than texts.
      fill_in 'event_title', with: 'IMI-Weihnachtsfeier'
      fill_in 'event_location', with: 'H001'
      fill_in 'event_description', with: 'Glühwein'

      check('planning_state_date_set')
      check('planning_state_room_booked')
      check('planning_state_announced')
      fill_in 'planning_state_notes', with: 'think of everything'
      click_button 'Create Event'
      expect(page).to have_content('Event was successfully created.')
      expect(page).to have_content('IMI-Weihnachtsfeier')
      expect(page).to have_content('Date set: true')
      expect(page).to have_content('Room booked: true')
      expect(page).to have_content('Announced: true')
      expect(page).to have_content('Notes: think of everything')
      expect(page).to have_content('Location: H001')
      expect(page).to have_content('Description: Glühwein')
    end
  end
end
