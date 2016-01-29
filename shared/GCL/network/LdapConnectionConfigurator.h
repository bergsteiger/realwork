#ifndef __SHARED_GCL_NETWORK_LDAPCONNECTIONCONFIGURATOR_H__
#define __SHARED_GCL_NETWORK_LDAPCONNECTIONCONFIGURATOR_H__

#include "shared/GCL/network/ldap/LdapConfiguration.h"

namespace LdapHelper {

class LdapConnectionConfigurator {
public:
	static void set_environment_config (const LdapConfiguration& config);
};	

}
#endif //__SHARED_GCL_NETWORK_LDAPCONNECTIONCONFIGURATOR_H__