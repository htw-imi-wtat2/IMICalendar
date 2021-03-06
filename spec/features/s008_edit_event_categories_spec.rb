# frozen_string_literal: true

require 'rails_helper'
describe 'S008: As a SGS, I can edit the Categories of an event while editing the event..' do
  before :each do
    @e1 = create(:planning_state_1).event
  end

  context '(when logged in)' do
    before :each do
      user = create(:user)
      login_as(user, scope: :user)
    end

    it 'has a text field accepting categories' do
      visit edit_event_path(@e1)
      fill_in 'categories', with: 'D, A, B'
      click_button 'Update Event'
      expect(@e1.categories.size).to eq(3)
      expect(page).to have_content('Categories: A, B, D')
    end

    it 'missing categories are automatically created' do
      @e1.categories.create(name: 'one')
      expect do
        visit edit_event_path(@e1)
        fill_in 'categories', with: 'one, two, three'
        click_button 'Update Event'
      end.to change { Category.count }.by(2)
    end
    context 'with existing categories' do
      before :each do
        create(:trick)
        create(:tick)
        create(:track)
        @categories = Category.names_alphabetically.join(', ')
      end
      it 'existing categories are shown on the edit view' do
        visit edit_event_path(@e1)
        expect(page).to have_content @categories
      end
      it 'existing categories are shown on the new view' do
        visit new_event_path
        expect(page).to have_content @categories
      end
    end
  end
end
