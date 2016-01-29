#ifndef __SHARED_GCL_NETWORK_LDAPCONNECTION_H__
#define __SHARED_GCL_NETWORK_LDAPCONNECTION_H__	
#include "ace/ACE.h"
#include "winldap.h"
namespace LdapHelper {	

class LdapConnection {
public:	
	LdapConnection ();
	LDAP* get () const;
	~LdapConnection();
private:
	LDAP* m_connection;
};

}

#endif //__SHARED_GCL_NETWORK_LDAPCONNECTION_H__

