#ifndef __SHARED_GCL_NETWORK_LDAPOPTIONS_H__
#define __SHARED_GCL_NETWORK_LDAPOPTIONS_H__	
#include "ace/ACE.h"
#include <string>
#include <memory>
#include "winldap.h"

namespace LdapHelper {

	class LdapOption {
	public:
		virtual void set_option(LDAP* connection) = 0;
		virtual ~LdapOption () {}
	};

	class LdapVersion: public LdapOption {
	public:
		void set_option (LDAP* connection);
	};

	class LdapSSLOn: public LdapOption {
	public:
		void set_option (LDAP* connection);
	};

}

#endif //__SHARED_GCL_NETWORK_LDAPOPTIONS_H__