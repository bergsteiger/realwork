#include "ace/ACE.h"
#include "winldap.h"
#include "shared/GCL/network/LdapInitializator.h"

namespace LdapHelper {

	LdapInitializatorSSL::LdapInitializatorSSL (const std::string &host, const unsigned long port) : m_host (host) {
		m_port = port ? port : LDAP_SSL_PORT;
	}

	LDAP* LdapInitializatorSSL::init () {
		return ldap_sslinit (const_cast<char*> (m_host.c_str ()), m_port, 1);
	}

	LdapInitializatorSimple::LdapInitializatorSimple (const std::string &host, const unsigned long port) : m_host (host) {
		m_port = port ? port : LDAP_PORT;
	}

	LDAP* LdapInitializatorSimple::init () {
		return ldap_init (const_cast<char*> (m_host.c_str ()), m_port);
	}

}
