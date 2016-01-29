#ifndef __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPBINDER_H__
#define __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPBINDER_H__

#include "shared/GCL/network/detail/LdapIdentity.h"

namespace LdapHelper {

	class LdapBinder {
	public:
		virtual void bind (LDAP* connection) = 0;
		virtual	~LdapBinder() {};	
	};

	class BinderSync  : public LdapBinder {
	public:	
		BinderSync(Ident* ident);
		void bind (LDAP* connection);

	private:
		BinderSync (const BinderSync&);
		BinderSync& operator= (const BinderSync&);
		std::auto_ptr<Ident> m_ident;
	};


}

#endif //__SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPBINDER_H__