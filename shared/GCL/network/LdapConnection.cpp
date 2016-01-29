#include "shared/GCL/network/LdapConnection.h"
#include "shared/GCL/network/LdapConnectionSupplier.h"


namespace LdapHelper {
	LdapConnection::LdapConnection () {
		m_connection = LdapConnectionSupplier::ldap_connection_supplier ().get ();
	}

	LDAP* LdapConnection::get () const {
		return m_connection;
	}

	LdapConnection::~LdapConnection () {
		LdapConnectionSupplier::ldap_connection_supplier ().close (m_connection);
	}
	
}
