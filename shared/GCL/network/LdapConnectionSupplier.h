#ifndef __SHARED_GCL_NETWORK_LDAPCONNECTIONSUPPLIER_H__
#define __SHARED_GCL_NETWORK_LDAPCONNECTIONSUPPLIER_H__	
#include "ace/ACE.h"
#include "winldap.h"

namespace LdapHelper {

class LdapConnectionSupplier {
public:
	virtual LDAP* get () = 0;
	virtual void close (LDAP*) = 0;	
	static LdapConnectionSupplier& ldap_connection_supplier ();
	virtual ~LdapConnectionSupplier () {}
};

}
#endif //__SHARED_GCL_NETWORK_LDAPCONNECTIONSUPPLIER_H__