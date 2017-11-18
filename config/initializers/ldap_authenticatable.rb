require 'net/ldap'
require 'devise/strategies/authenticatable'

class LDAPAdapter
  attr_accessor :params, :host, :port, :connectstring, :request

  def initialize(request, params)
    @request = request
    @params = params
  end

  def report_issue(message)
    request.logger.warn(message)
    params[:ldap_status] = [] unless params[:ldap_status]
    params[:ldap_status] << message
  end
  def valid
    config && params[:user] && (username && password)
  end

  def username
    m = /\A(.*)@.*htw-berlin.de\z/.match(email)
    return m[1] if m
    report_issue("email couldn't be matched: #{email}")
    nil
  end

  def email
    params[:user][:email]
  end

  def password
    params[:user][:password]
  end

  def config
    # ldap_host|ldap_port|ldap_htw
    ldapconfig = ENV['LDAP']
    report_issue("LDAP configuration missing - export set LDAP='' to use ldap") unless ldapconfig
    @host, @port, @connectstring = ldapconfig&.split('|')
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
    self
  end

  def authenticate
    begin
      success_or_not = @netldap.bind
    rescue StandardError => e
      report_issue("LDAP: Could not connect to server #{host}")
      # report_issue(e.class)
      # report_issue(e.message)
      return false
    end
    success_or_not
  end
end

module Devise
  module Strategies

    # Implements Authentication against HTW FB4 Ldap.
    class LdapAuthenticatable < Authenticatable

      def ldap(request,params)
        LDAPAdapter.new(request,params)
      end

      def valid?
        adapter = ldap(request,params)
        valid = adapter.valid
        adapter.report_issue('LDAP: config missing params not valid for ldap') unless valid
        valid
      end

      def authenticate!
        ldapadapter = ldap(request,params).create
        auth_successful = ldapadapter.authenticate
        ldapadapter.report_issue("LDAP: failed authentication for #{ldapadapter.email}") unless auth_successful
        return fail(:invalid_login) unless auth_successful
        user = User.find_or_create_by(email: ldapadapter.email)
        success!(user)
      end


    end
  end
end

Warden::Strategies.add(:ldap_authenticatable,
                       Devise::Strategies::LdapAuthenticatable)
