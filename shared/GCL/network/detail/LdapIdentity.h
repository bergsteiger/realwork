#ifndef __SHARED_GCL_NETWORK_DETAIL_LDAPIDENTITY_H__
#define __SHARED_GCL_NETWORK_DETAIL_LDAPIDENTITY_H__
#include "ace/ACE.h"
#include <string>
#include <memory>
#include "winldap.h"
#include "shared/Core/sys/Exception.h"
#include <boost/shared_ptr.hpp>

namespace LdapHelper {

	class Ident {
	public:
		virtual PCHAR get_ident () = 0;
		virtual ~Ident () {}

	}; 

	class DefaultIdent : public Ident {
	public:
		PCHAR get_ident () {
			return 0;
		}
	};
	
	class SpecificIdent : public Ident {
		struct Data {
			Data (const std::string &host, const std::string &user, const std::string &password);
			SEC_WINNT_AUTH_IDENTITY m_ident;
			std::string m_host;
			std::string	m_user;
			std::string	m_password;	
		};
	public:
		SpecificIdent (const std::string &host, const std::string &user, const std::string &password);
		PCHAR get_ident ();
		boost::shared_ptr <Data> m_data;			
	};
}
#endif //__SHARED_GCL_NETWORK_LDAPOPTIONS_H__