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
  end
end
