#include "ace/ACE.h"
#include "ace/Singleton.h"
#include "ace/Null_Mutex.h"

#include "shared/GCL/network/LdapConnectionSupplier.h"
#include "shared/GCL/network/LdapConnectionConfigurator.h"
#include "shared/Core/sys/Exception.h"
#include "shared/Core/sys/assert.h"
#include "winldap.h"
#include <memory>
#include "shared/GCL/network/LdapConnectionPolicy.h"

namespace LdapHelper {
	class LdapConnectionFactory : public LdapConnectionSupplier {
	public:
		friend class ACE_Singleton<LdapConnectionFactory, ACE_Null_Mutex>;

		LDAP* get () {	
			this->check ();
			return m_policy->get_connection ();			
		}

		void close (LDAP* connection) {
			this->check ();
			return m_policy->close_connection (connection);
		}		

		void set_policy (std::auto_ptr<LdapPolicy> policy) {
			OutputDebugString ("set policy in environment \n");
			m_policy = policy;
		}

		LdapConnectionConfigurator& get_configurator () {
			return m_configurator;
		}

	private:
		void check () const {
			GDS_ASSERT (m_policy.get ());
			if (!m_policy.get ()) {
				std::exception ("you need to initialize ldap environment");
			}
		}

		std::auto_ptr<LdapPolicy> m_policy;	
		LdapConnectionConfigurator m_configurator;		
	};

	typedef ACE_Singleton<LdapConnectionFactory, ACE_Null_Mutex> LdapFactory;
 

	LdapConnectionSupplier& LdapConnectionSupplier::ldap_connection_supplier () {
		return *LdapFactory::instance ();
	}		

	void LdapConnectionConfigurator::set_environment_config (const LdapConfiguration & config) {
		LdapFactory::instance ()->set_policy (create_policy (config));
	}

	
}