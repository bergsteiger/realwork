#include "ace/ACE.h"
#include "shared/Core/sys/Exception.h"
#include "shared/Core/sys/assert.h"
#include "winldap.h"
#include "shared/GCL/network/ldap/LdapConfiguration.h"
#include "shared/GCL/network/detail/LdapConnectionHandler.h"
#include "shared/GCL/network/LdapConnectionPolicy.h"

namespace LdapHelper {

	OneConnection::OneConnection (const LdapConfiguration& config) : m_handler (config) {
		m_connection = m_handler.create_connection ();
	}

	LDAP* OneConnection::get_connection () {
		return m_connection;
	}

	void OneConnection::close_connection (LDAP*) {
	}

	OneConnection::~OneConnection () {
		GDS_ASSERT (m_connection);
		m_handler.destroy_connection (m_connection);
	}

	ManyConnections::ManyConnections (const LdapConfiguration& config) : m_handler (config) {
	}

	LDAP* ManyConnections::get_connection () {
		return m_handler.create_connection ();
	}

	void ManyConnections::close_connection (LDAP* connection) {
		GDS_ASSERT (connection);
		m_handler.destroy_connection (connection);
	}

	std::auto_ptr<LdapPolicy> create_policy (const LdapConfiguration& config) {
		if (config.get_options ().use_one_connection) {
			return std::auto_ptr<LdapPolicy> (new OneConnection (config));
		} else {
			return std::auto_ptr<LdapPolicy> (new ManyConnections (config));
		}
	}
	

}
