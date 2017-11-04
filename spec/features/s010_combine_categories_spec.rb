# frozen_string_literal: true

require 'rails_helper'
describe 'category maintenance' do
  context '(when logged in)' do
    before :each do
      user = User.create(email: 'someone@htw-berlin.de',
                         password: 'geheimgeheim',
                         password_confirmation: 'geheimgeheim')
      login_as(user, scope: :user)
    end
    before :each do
      @e1 = Event.create(title: 'Event 1',
                         start_date: DateTime.new(2018,2,2,10,0),
                         end_date: DateTime.new(2018,2,2,17,0),
                         location: 'H001',
                         description: 'The description of the event no 1')

      @e2 = Event.create(title: 'Event 2',
                         start_date: DateTime.new(2018,2,2,10,0),
                         end_date: DateTime.new(2018,2,2,17,0),
                         location: 'H001',
                         description: 'The description of the event no 2')
      @c1 = Category.create(name: 'category 1')
      @c2 = Category.create(name: 'category 2')
      @c3 = Category.create(name: 'category 3')
      @e1.categories << @c1
      @e2.categories << @c2
      @e2.categories << @c3
      @categories = [@c1, @c2, @c3]
    end

    it 'shows categories on maintenance page' do
      visit categories_path
      expect(page).to have_content('category 1')
      expect(page).to have_content('category 2')
      expect(page).to have_content('category 3')
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
