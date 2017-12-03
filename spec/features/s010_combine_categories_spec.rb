# frozen_string_literal: true

require 'rails_helper'
describe 'category maintenance' do
  context '(when logged in)' do
    before :each do
      user = create(:user)
      login_as(user, scope: :user)
    end
    before :each do
      @e1 = create(:e1)

      @e2 = create(:e2)
      @c1 = create(:trick)
      @c2 = create(:tick)
      @c3 = create(:track)
      @e1.categories << @c1
      @e2.categories << @c2
      @e2.categories << @c3
      @categories = [@c1, @c2, @c3]
    end

    it 'shows categories on maintenance page' do
      visit categories_path
      expect(page).to have_content(@c1.name)
      expect(page).to have_content(@c2.name)
      expect(page).to have_content(@c3.name)
    end

    it 'deletes one category' do
      visit categories_path
      expect do
        within("#category_#{@c1.id}") do
          check 'category_ids[]'
        end
        click_on 'Delete'
      end.to change { Category.count }.by(-1)
    end

    it 'deletes two categories' do
      visit categories_path
      expect do
        within("#category_#{@c2.id}") do
          check 'category_ids[]'
        end
        within("#category_#{@c3.id}") do
          check 'category_ids[]'
        end
        click_on 'Delete'
      end.to change { Category.count }.by(-2)
    end

    it 'combines two categories' do
      visit categories_path
      expect do
        within("#category_#{@c2.id}") do
          check 'category_ids[]'
        end
        within("#category_#{@c3.id}") do
          check 'category_ids[]'
        end
        click_on 'Combine'
      end.to change { Category.count }.by(-1)
    end
  end
end
