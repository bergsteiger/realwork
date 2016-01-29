#ifndef __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPCONNECTIONPOLICY_H__
#define __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPCONNECTIONPOLICY_H__

#include "ace/ACE.h"


#include "shared/Core/sys/Exception.h"
#include "shared/Core/sys/assert.h"
#include "winldap.h"

#include "shared/GCL/network/ldap/LdapConfiguration.h"
#include "shared/GCL/network/detail/LdapConnectionHandler.h"


namespace LdapHelper {	

	class LdapPolicy {
	public:
		virtual LDAP* get_connection () = 0;
		virtual void close_connection (LDAP*) = 0;
		virtual ~LdapPolicy () {}
	};

	class OneConnection: public LdapPolicy {
	public:
		OneConnection (const LdapConfiguration& config);
		LDAP* get_connection ();
		void close_connection (LDAP*);
		~OneConnection ();

	private:
		OneConnection (const OneConnection&);
		OneConnection& operator= (const OneConnection&);
		LdapConnectionHandler m_handler;
		LDAP* m_connection;
	};

	class ManyConnections: public LdapPolicy {
	public:
		ManyConnections (const LdapConfiguration& config);
		LDAP* get_connection ();
		void close_connection (LDAP* connection);
	private:
		LdapConnectionHandler m_handler;
	};
	
	std::auto_ptr<LdapPolicy> create_policy (const LdapConfiguration& config);
	
};
#endif //__SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPCONNECTIONPOLICY_H__