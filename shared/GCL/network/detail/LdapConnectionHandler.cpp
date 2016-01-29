

#include "shared/GCL/network/detail/LdapConnectionHandler.h"
#include <memory>

#include "shared/Core/sys/Exception.h"
#include "shared/Core/sys/assert.h"
namespace LdapHelper {

	std::auto_ptr<LdapInitializator> make_ldap_initializator (const LdapConfiguration& config) {
		if (config.get_options ().ssl) {
			return std::auto_ptr<LdapInitializator>(new LdapInitializatorSSL (config.get_address ().host, config.get_address ().port));
		} else {
			return std::auto_ptr<LdapInitializator> (new LdapInitializatorSimple (config.get_address ().host, config.get_address ().port));
		}

		GDS_ASSERT (false);
		throw std::exception ("not reachable");
	}

	std::auto_ptr<LdapBinder> make_ldap_binder_with_default_credential (const LdapConfiguration& config) {
		return std::auto_ptr<LdapBinder> (new BinderSync (new DefaultIdent ()));
	}

	std::auto_ptr<LdapBinder> make_ldap_binder_with_specific_credential (const LdapConfiguration& config) {
		SpecificIdent *ident = new SpecificIdent(config.get_address ().host, config.get_credentials().login, config.get_credentials().password);
		return std::auto_ptr<LdapBinder> (new BinderSync (ident));
	}

	std::auto_ptr<LdapBinder> make_ldap_binder (const LdapConfiguration& config) {
		if (config.get_options ().use_current_user_credentials){
			return make_ldap_binder_with_default_credential (config);
		} else {
			return make_ldap_binder_with_specific_credential (config);
		}

		GDS_ASSERT (false);
		throw std::exception ("not reachable");
	}


	LdapConnectionHandler::LdapConnectionHandler (const LdapConfiguration& config) 
		: m_initializator (make_ldap_initializator (config)), m_binder (make_ldap_binder (config))
	{
		this->add_option (new LdapVersion());
		if (config.get_options ().ssl) {
			this->add_option (new LdapSSLOn ());
		}
	}

	LDAP* LdapConnectionHandler::create_connection () {	
		LDAP* connection = m_initializator->init ();
		set_all_options (connection);
		m_binder->bind (connection);	
		return connection;
	}

	void LdapConnectionHandler::destroy_connection (LDAP *connection) {
		ldap_unbind_s (connection);
	}

	void LdapConnectionHandler::add_option (LdapOption* option) {		
		m_options.push_back (option);
	}

	void LdapConnectionHandler::set_all_options (LDAP* connection) {
		for (boost::ptr_vector <LdapOption>::iterator it = m_options.begin (); it!= m_options.end (); ++it) {
			it->set_option (connection);
		}
	}

}
