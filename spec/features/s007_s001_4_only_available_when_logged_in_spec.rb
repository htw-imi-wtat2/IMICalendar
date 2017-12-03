# frozen_string_literal: true

require 'rails_helper'
describe 's007: password protection for special sites' do
  it 'blocks the new event path' do
    visit new_event_path
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
  it 'blocks the planning path' do
    visit planning_path
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end
