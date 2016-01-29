#include "shared/GCL/network/detail/LdapIdentity.h"

namespace LdapHelper {

	SpecificIdent::SpecificIdent (const std::string &host, const std::string &user, const std::string &password) 
		: m_data (new Data(host, user, password)) {
	}

	SpecificIdent::Data::Data (const std::string &host, const std::string &user, const std::string &password)
		: m_host(host), m_user(user), m_password(password) {
		m_ident.User = (unsigned char*)m_user.c_str ();
		m_ident.UserLength = m_user.length ();
		m_ident.Domain = (unsigned char*)m_host.c_str ();
		m_ident.DomainLength = m_host.length ();
		m_ident.Password = (unsigned char*)m_password.c_str ();
		m_ident.PasswordLength = m_password.length ();
		m_ident.Flags = SEC_WINNT_AUTH_IDENTITY_ANSI;	
	}

	PCHAR SpecificIdent::get_ident () {
		return (PCHAR)&m_data->m_ident;
	}
}
