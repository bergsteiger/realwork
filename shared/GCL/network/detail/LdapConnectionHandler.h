#ifndef __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPCONNECTIONHADLER_H__
#define __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPCONNECTIONHADLER_H__

#include "ace/ACE.h"
#include "winldap.h"
#include "shared/GCL/network/LdapBinder.h"
#include "shared/GCL/network/LdapInitializator.h"
#include "shared/GCL/network/LdapOptions.h"
#include "shared/GCL/network/ldap/LdapConfiguration.h"
#include <boost/ptr_container/serialize_ptr_vector.hpp>

namespace LdapHelper {

	class LdapConnectionHandler {
	public:
		LdapConnectionHandler (const LdapConfiguration& config);
		LDAP* create_connection ();
		void destroy_connection (LDAP *connection);

	private:
		LdapConnectionHandler (const LdapConnectionHandler&);
		LdapConnectionHandler& operator= (const LdapConnectionHandler&);
		void add_option (LdapOption* option); 
		void set_all_options (LDAP* connection);
		boost::ptr_vector <LdapOption>  m_options;
		std::auto_ptr <LdapInitializator> m_initializator;
		std::auto_ptr <LdapBinder> m_binder;

	};

}
#endif //__SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPCONNECTIONHADLER_H__