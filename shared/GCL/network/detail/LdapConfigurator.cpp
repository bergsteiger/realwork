#include "shared/GCL/network/ldap/LdapConfigurator.h"

namespace LdapHelper {

	LdapConfigurator::LdapOptionsSet::LdapOptionsSet () 
		: m_ssl(false), m_use_current_user_credentials (true), m_use_one_connection (false)  {			
	}

	LdapConfigurator::LdapConfigurator (const std::string &host, unsigned long port) : m_host (host), m_port (port) {
	}

	void LdapConfigurator::turn_on_one_connection_policy () {
		m_options.m_use_one_connection = true;
	}

	void LdapConfigurator::turn_off_one_connection_policy () {
		m_options.m_use_one_connection = false;
	}

	void LdapConfigurator::turn_on_ssl () {
		m_options.m_ssl = true;
	}

	void LdapConfigurator::turn_off_ssl () {
		m_options.m_ssl = false;
	}

	void LdapConfigurator::use_current_user_credintials () {
		m_options.m_use_current_user_credentials = true;
	}

	void LdapConfigurator::use_spec_user_credintials (const std::string &login, const std::string &password) {
		m_options.m_use_current_user_credentials = false;
		m_credentials.m_login = login;
		m_credentials.m_password = password;
	}
}