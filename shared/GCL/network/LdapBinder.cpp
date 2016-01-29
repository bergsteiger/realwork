#include "ace/ACE.h"
#include "shared/GCL/network/LdapBinder.h"
#include "shared/Core/sys/Exception.h"
#include "winldap.h"
#include <string>

namespace LdapHelper {

	BinderSync::BinderSync(Ident* ident): m_ident (ident) {
	}

	void BinderSync::bind (LDAP* connection) {

		unsigned long return_code = ldap_connect (connection, 0);
		if (return_code != LDAP_SUCCESS) {
			throw std::exception (Core::create_exception_string ("can't connect", return_code).c_str ());
		}

		return_code = ldap_bind_s (connection, 0, m_ident->get_ident() , LDAP_AUTH_NEGOTIATE);
		if (return_code != LDAP_SUCCESS) {
			throw std::exception (Core::create_exception_string ("can't bind", return_code).c_str ());
		}

	}



}