#include "shared/GCL/network/ldap/LdapConfiguration.h"

namespace LdapHelper {

	LdapOptionsSet::LdapOptionsSet () 
		: ssl(false), use_current_user_credentials (true), use_one_connection (false)  {			
	}

    LdapAddress::LdapAddress (const std::string& ldap_host, unsigned long ldap_port) : host (ldap_host), port (ldap_port) {
	}

	LdapConfiguration::LdapConfiguration (const std::string &host, unsigned long port) : m_address (host, port) {
	}


	void LdapConfiguration::turn_on_one_connection_policy () {
		m_options.use_one_connection = true;
	}

	void LdapConfiguration::turn_off_one_connection_policy () {
		m_options.use_one_connection = false;
	}

	void LdapConfiguration::turn_on_ssl () {
		m_options.ssl = true;
	}

	void LdapConfiguration::turn_off_ssl () {
		m_options.ssl = false;
	}

	void LdapConfiguration::use_current_user_credintials () {
		m_options.use_current_user_credentials = true;
	}

	void LdapConfiguration::use_spec_user_credintials (const std::string &login, const std::string &password) {
		m_options.use_current_user_credentials = false;
		m_credentials.login = login;
		m_credentials.password = password;
	}

	const LdapOptionsSet& LdapConfiguration::get_options () const {
		return m_options;
	}

	const LdapUserCredentials& LdapConfiguration::get_credentials () const {
		return m_credentials;
	}

	const LdapAddress& LdapConfiguration::get_address () const {
		return m_address;
	}
}