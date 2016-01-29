////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/ServerLibHome.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::CoreSrv
//
// ������-��������� ����, ����� ������� ��������������� �������� � ����� ��� ������ � CORBA, � ���
// �� ������-������� ����� ���������� GCM2
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "shared/CoreSrv/ServerLibHome.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeManager_factory.h"
#include "shared/CoreSrv/impl/Root_i/ConfigurationSrv_i_factory.h"
#include "shared/CoreSrv/impl/Security_i/SessionManager_i_factory.h"
#include "shared/CoreSrv/impl/Security_i/Session_i_factory.h"
#include "shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl_factory.h"
#include "shared/CoreSrv/Root/ServerSettings.h"

namespace CoreSrv {

namespace {
	template <typename T>
	bool check_param (const char* key, bool is_requared) {
		bool res = true;
		if (Core::ParamManagerFactory::get ().is_exist (key)) {
			std::string value = Core::ParamManagerFactory::get ().get_string (key);
			try {
				boost::lexical_cast<T> (value);
			} catch (boost::bad_lexical_cast&) {
				res = false;
				LOG_E (("�������� �������� ��������� %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("�� ����� ������������ ��������: %s", key));
		}
		
		return res;
	}
	
	template <>
	bool check_param<std::string> (const char* key, bool is_requared) {
		if (is_requared && !Core::ParamManagerFactory::get ().is_exist (key)) {
			LOG_E(("�� ����� ������������ �������� <%s>", key));
			return false;
		}
		return true;
	}
	
} //namespace

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *457FF5F002EE_ENVIRONMENTS_CONFIG*
	//#UC END# *457FF5F002EE_ENVIRONMENTS_CONFIG*

	//#UC START# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_457EA15F01D0_CorbaLibHomeManager*
	//#UC END# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_457EA15F01D0_CorbaLibHomeManager*
	
	//#UC START# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_45FF9ECE032C_ConfigurationSrv_i*
	{
		Root_i::ConfigurationSrv_i_factory_var fctr = new Root_i::ConfigurationSrv_i_factory ();
		fctr->registrate_me(10);
	}
	//#UC END# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_45FF9ECE032C_ConfigurationSrv_i*
	
	//#UC START# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_45E2B93701A9_SessionManager_i*
	{
		//������������ ������ �� ��������� �������
		bool server_side = true;
		try {
			server_side = Root::ServerSettings::get_orb_init_ref ().empty ();
		} catch (Core::ParameterIsMissing&) {
		}
		if (server_side) {
			Security_i::SessionManager_i_factory_var fctr = new Security_i::SessionManager_i_factory ();
			fctr->registrate_me(0);
		}
	}
	//#UC END# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_45E2B93701A9_SessionManager_i*
	
	{
		Security_i::Session_i_factory_var fctr = new Security_i::Session_i_factory ();
		fctr->registrate_me(0);
	}
	
	//#UC START# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_47FF49C10158_EventChannelManagerImpl*
	{
		//������������ ������ �� ��������� �������
		bool server_side = true;
		try {
			server_side = Root::ServerSettings::get_orb_init_ref ().empty ();
		} catch (Core::ParameterIsMissing&) {
		}
		if (server_side) {
			EvenComm_i::EventChannelManagerImpl_factory_var fctr = new EvenComm_i::EventChannelManagerImpl_factory ();
			fctr->registrate_me(0);
		}
	}
	//#UC END# *457FF5F002EE_CUSTOM_REGISTRATE_FOR_47FF49C10158_EventChannelManagerImpl*
	
}
	
void ServerLibHomeImpl::finalize () {
}
	
void ServerLibHomeImpl::print_usage () const {
	std::cout << "-ORBInitRef: (a-string)  - ������ ������������� ORB'� (�������� �����\n";
	std::cout << "                         NameService)\n";

	std::cout << "-NSContext: (a-string)   - ��� ��������� ��� NameService (������\n";
	std::cout << "                         namespace'�)\n";


}

bool ServerLibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-ORBInitRef", false);
	res &= check_param<std::string> ("-NSContext", false);

	return res;
}
} // namespace CoreSrv


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
