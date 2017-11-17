require 'net/ldap'
require 'devise/strategies/authenticatable'

class LDAPAdapter
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def valid
    config && params[:user] && (username && password)
  end

  def username
    m = /\A(.*)@.*htw-berlin.de\z/.match(email)
    Rails.logger.warn("email couln't be matched: #{email}") unless m
    m ? m[1] : nil
  end

  def email
    params[:user][:email]
  end

  def password
    params[:user][:password]
  end

  def config
    ldapconfig = ENV['LDAP']
    Rails.logger.warn("LDAP configuration missing - export set LDAP='' to use ldap") unless ldapconfig
    ldapconfig&.split('|')
  end

  def create

    ldap_host, ldap_port, ldap_htw = config
    ldap_username = username
    ldap_password = password

    @netldap = Net::LDAP.new(host: ldap_host, port: ldap_port,
                         encryption: {
                           method: :simple_tls,
                           verify_mode: OpenSSL::SSL::VERIFY_NONE
                         },
                         auth: {
                           method: :simple,
                           username: "CN=#{ldap_username},#{ldap_htw}",
                           password: ldap_password
                         })
    return self
  end

  def authenticate
    @netldap.bind
  end
end

module Devise
  module Strategies

    # Implements Authentication against HTW FB4 Ldap.
    class LdapAuthenticatable < Authenticatable

      def ldap(params)
        LDAPAdapter.new(params)
      end

      def valid?
        valid = ldap(params).valid
        Rails.logger.warn("config missing params not valid for ldap ") unless valid
        valid
      end

      def authenticate!
        ldapadapter = ldap(params).create
        auth_successful = ldapadapter.authenticate
        Rails.logger.info ("LDAP: failed authentication for #{ldapadapter.email}") unless auth_successful
        return fail(:invalid_login) unless auth_successful
        user = User.find_or_create_by(email: ldapadapter.email)
        success!(user)
      end


    end
  end
end

Warden::Strategies.add(:ldap_authenticatable,
                       Devise::Strategies::LdapAuthenticatable)
