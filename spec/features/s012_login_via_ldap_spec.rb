require 'rails_helper'
describe 'ldap login' do
  context 'with LDAP auth' do
    before :each do
      @user = User.create(email: 'someone@htw-berlin.de')
      login_as(@user, scope: :user)
    end
    it 'ldap authorization can be detected' do
      expect(@user.ldap_authorized?).to be true
    end
    it 'user profile info can be edited' do
      pending
    #  visit # go on here
    end
  end
  context 'with DB AUTH' do
    before :each do
      @user = User.new(email: 'someone2@htw-berlin.de',
                       password: 'geheimgeheim',
                       password_confirmation: 'geheimgeheim')
      login_as(@user, scope: :user)
    end
    it 'DB authorization can be detected' do
      expect(@user.ldap_authorized?).to be false
    end
    it 'user profile info can be edited' do
      visit edit_user_registration_path
      fill_in 'user_current_password', with: @user.password
      fill_in 'user_first_name', with: 'Grace'
      fill_in 'user_middle_name', with: 'Brewster Murray'
      fill_in 'user_last_name', with: 'Hopper'
      click_on 'user-registration-edit-submit'
      edited_user = User.where(email: @user.email).first
      expect(edited_user.first_name).to eq 'Ada'
      expect(edited_user.middle_name).to eq 'Brewster Murray'
      expect(edited_user.last_name).to eq 'Hopper'
    end
  end
  #  # SQLite3::ConstraintException:
     #   UNIQUE constraint failed: users.email
end
