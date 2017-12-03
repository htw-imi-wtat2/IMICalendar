# frozen_string_literal: true

require 'rails_helper'
describe LDAPAdapter do
  ENV['LDAP'] = 'host.domain.ext|123|connection_string'

  def params
    { email: 's012345@student.htw-berlin.de',
      password: 'geheimgheim' }
  end

  before(:each) do
    @ldapadapter = LDAPAdapter.new(params)
  end

  it 'validates params' do
  end

  it 'reads the environment variable for config' do
    ldap_host, ldap_port, ldap_htw = @ldapadapter.config
    expect(ldap_host).to eq 'host.domain.ext'
    expect(ldap_port).to eq '123'
    expect(ldap_htw).to eq 'connection_string'
  end
end
