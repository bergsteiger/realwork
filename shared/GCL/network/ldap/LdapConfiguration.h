#ifndef __SHARED_GCL_NETWORK_LDAP_LDAPCONFIGURATOR_H__
#define __SHARED_GCL_NETWORK_LDAP_LDAPCONFIGURATOR_H__
#include <string>

namespace LdapHelper {
	struct LdapOptionsSet {
		LdapOptionsSet ();
		bool ssl;
		bool use_current_user_credentials;
		bool use_one_connection;			
	};

	struct LdapUserCredentials {
		std::string login;
		std::string password;
	};

	struct LdapAddress {
		LdapAddress (const std::string& host, unsigned long port);
		std::string host;
		unsigned long port;	
	};

	class LdapConfiguration {
	public:
		LdapConfiguration (const std::string& host, unsigned long port = 0);

		void turn_on_one_connection_policy ();
		void turn_off_one_connection_policy ();

		void turn_on_ssl ();
		void turn_off_ssl ();

		void use_current_user_credintials ();
		void use_spec_user_credintials (const std::string& login, const std::string& password);	
		const LdapOptionsSet& get_options () const;
		const LdapUserCredentials& get_credentials () const;
		const LdapAddress& get_address () const;

	private:
		LdapOptionsSet m_options;
		LdapUserCredentials m_credentials;
		LdapAddress m_address;
	};	

}
#endif //__SHARED_GCL_NETWORK_LDAP_LDAPCONFIGURATOR_H__