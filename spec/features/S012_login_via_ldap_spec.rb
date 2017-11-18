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
      visit # go on here
    end
  end
  context 'with DB AUTH' do
    before :each do
      user = User.create(email: 'someone@htw-berlin.de',
                         password: 'geheimgeheim',
                         password_confirmation: 'geheimgeheim')
      login_as(user, scope: :user)
    end
    it 'DB authorization can be detected' do
      expect(@user.ldap_authorized?).to be false
    end
    it 'user profile info can be edited' do
    end
  end
end
