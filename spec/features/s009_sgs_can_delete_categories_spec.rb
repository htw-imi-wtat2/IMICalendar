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
    it 'shows categories on maintenance page' do
      c_names = %w[A B C D].map { |s| "Category #{s}" }
      c_names.map { |n| Category.create(name: n) }
      visit categories_path
      c_names.each do |category|
        expect(page).to have_content(category)
      end
    end

    it 'deletes category' do
      c_names = %w[A B C D].map { |s| "Category #{s}" }
      categories = c_names.map { |n| Category.create(name: n) }
      visit categories_path
      category_to_delete = categories[2]
      expect do
        within("#category_#{category_to_delete.id}") do
          check 'category_ids[]'
        end
        click_on 'Delete'
      end.to change { Category.count }.by(-1)
    end
  end
end
