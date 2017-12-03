# frozen_string_literal: true

require 'rails_helper'
describe 's004: SGS can announce events' do
  context '(when logged in)' do
    before :each do
      user = create(:user)
      login_as(user, scope: :user)
    end
    it 'by creating events' do
      visit new_event_path

      # note that these are all ids used to locate the fields.
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
  context '(when logged out)' do
    it 'blocks the new event' do
      visit new_event_path
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end
  end
end
