# frozen_string_literal: true

require 'rails_helper'
describe 's003: students see current events on the start page' do
  before :each do
    @e1 = create(:e1)
    @e2 = create(:e2)
    @e3 = create(:e3)
  end

  it 'shows the events' do
    visit root_path
    [@e1, @e2, @e3].each do |event|
      expect(page).to have_content(event.title)
    end
  end
end
