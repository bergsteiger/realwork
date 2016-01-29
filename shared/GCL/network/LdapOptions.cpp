#include "shared/GCL/network/LdapOptions.h"
#include "shared/Core/sys/Exception.h"

namespace LdapHelper {

	void LdapVersion::set_option (LDAP *connection){
		unsigned long version = LDAP_VERSION3;
		unsigned long return_code = ldap_set_option (connection, LDAP_OPT_PROTOCOL_VERSION, (void*) &version);
		if (return_code != LDAP_SUCCESS) {
			throw std::exception (Core::create_exception_string ("can't set options ", return_code).c_str ());
		}
	}

	void LdapSSLOn::set_option (LDAP *connection) {
		unsigned long ssl_enabled = 0;
		unsigned long return_code = ldap_get_option (connection, LDAP_OPT_SSL,(void*)&ssl_enabled);
		if (return_code != LDAP_SUCCESS) {
			throw std::exception (Core::create_exception_string ("can't get options ", return_code).c_str ());
		}

		if ((void*)ssl_enabled != LDAP_OPT_ON) {
			unsigned long return_code = ldap_set_option (connection, LDAP_OPT_SSL, LDAP_OPT_ON);
			if (return_code != LDAP_SUCCESS) {
				throw std::exception (Core::create_exception_string ("can't set options ", return_code).c_str ());
			}
		}
	}

}