#ifndef __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPINITIALIZATOR__
#define __SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPINITIALIZATOR__
#include "ace/ACE.h"
#include <string>
#include "winldap.h"

namespace LdapHelper {

	class LdapInitializator {		
	public:
		virtual LDAP* init() = 0;
		virtual ~LdapInitializator() {}
	};

	class LdapInitializatorSSL : public LdapInitializator{
	public:
		LdapInitializatorSSL (const std::string &host, const unsigned long port);
		LDAP* init ();

	private:
		std::string m_host;
		unsigned long m_port;
	};

	class LdapInitializatorSimple : public LdapInitializator{
	public:
		LdapInitializatorSimple (const std::string &host, const unsigned long port); 
		LDAP* init ();

	private:
		std::string m_host;
		unsigned long m_port;
	};	

}

#endif //__SHARED_GCL_NETWORK_COMMON_NETWORK_LDAPINITIALIZATOR__