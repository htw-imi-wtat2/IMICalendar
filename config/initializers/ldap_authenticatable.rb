require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies

    # Implements Authentication against HTW FB4 Ldap.
    class LdapAuthenticatable < Authenticatable

      def config
        ldapconfig = ENV['LDAP']
        ldapconfig&.split('|')
      end

      def valid?
        config && params[:user] && (username && password)
      end

      def authenticate!
        ldap_host, ldap_port, ldap_htw = config
        ldap_username = username
        ldap_password = password

        ldap = Net::LDAP.new(host: ldap_host, port: ldap_port,
                             encryption: {
                               method: :simple_tls,
                               verify_mode: OpenSSL::SSL::VERIFY_NONE
                             },
                             auth: {
                               method: :simple,
                               username: "CN=#{ldap_username},#{ldap_htw}",
                               password: ldap_password
                             })

        auth_successful = ldap.bind
        return fail(:invalid_login) unless auth_successful
        user = User.find_or_create_by(email: email)
        success!(user)
      end

      def username
        m = /\A(.*)@.*htw-berlin.de\z/.match(email)
        m ? m[1] : nil
      end

      def email
        params[:user][:email]
      end

      def password
        params[:user][:password]
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable,
                       Devise::Strategies::LdapAuthenticatable)
