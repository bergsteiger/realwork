#ifndef __SHARED_GCL_NETWORK_LDAP_LDAPCONFIGURATOR_H__
#define __SHARED_GCL_NETWORK_LDAP_LDAPCONFIGURATOR_H__
#include <string>

namespace LdapHelper {

	class LdapConfigurator {
	public:
		LdapConfigurator (const std::string &host, unsigned long port = 0);

		void turn_on_one_connection_policy ();
		void turn_off_one_connection_policy ();

		void turn_on_ssl ();
		void turn_off_ssl ();

		void use_current_user_credintials ();
		void use_spec_user_credintials (const std::string &login, const std::string &password);	


		struct LdapOptionsSet {
			LdapOptionsSet ();
			bool m_ssl;
			bool m_use_current_user_credentials;
			bool m_use_one_connection;			
		};

		struct LdapUserCredentials {
			std::string m_login;
			std::string m_password;
		};

		LdapOptionsSet m_options;
		LdapUserCredentials m_credentials;
		std::string m_host;
		unsigned long m_port;		
	};	

}
#endif //__SHARED_GCL_NETWORK_LDAP_LDAPCONFIGURATOR_H__