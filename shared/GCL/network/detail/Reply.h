#ifndef __SHARED_GCL_NETWORK_DETAIL_REPLY_H__
#define __SHARED_GCL_NETWORK_DETAIL_REPLY_H__

#include "shared/GCL/network/ldap/LdapFind.h"
#include "shared/GCL/network/LdapConnection.h"
#include "shared/GCL/network/LdapStringWrappers.h" 
#include <boost/optional.hpp>

namespace LdapHelper {

	class LdapAccessor {
	public:
		unsigned long find (const Request& request, LDAPMessage** result);
		LDAPMessage* next (LDAPMessage* entry);
		LDAPMessage* first (LDAPMessage* entry);
		std::string  value (LDAPMessage* entry, const std::string& attribute);
		unsigned long count (LDAPMessage* entry);

	private:
		LdapConnection m_connection;
	};

	class Reply {
	public:
		Reply (const Request& request);
		unsigned long count () const;
		void for_each (EntryHandler& handler);
	private:
		LdapAccessor m_accessor;
		unsigned long m_count;
		LdapMessageWrapper m_data; 
	};
}

#endif //__SHARED_GCL_NETWORK_DETAIL_REPLY_H__