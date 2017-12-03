# frozen_string_literal: true

require 'rails_helper'
describe 'category maintenance' do
  context '(when logged in)' do
    before :each do
      user = create(:user)
      login_as(user, scope: :user)
      @categories = [create(:category_a),
                     create(:category_b),
                     create(:category_c),
                     create(:category_d)]
    end
    it 'shows categories on maintenance page' do
      visit categories_path
      @categories.each do |category|
        expect(page).to have_content(category.name)
      end
    end

    it 'deletes category' do
      visit categories_path
      category_to_delete = @categories[2]
      expect do
        within("#category_#{category_to_delete.id}") do
          check 'category_ids[]'
        end
        click_on 'Delete'
      end.to change { Category.count }.by(-1)
    end
  end
end
