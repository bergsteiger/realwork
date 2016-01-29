////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibClient::Start_i::Client
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLibClient/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client.h"

//#UC START# *474C10480085_CUSTOM_INCLUDES*
#include "shared/Core/mng/LogMsgSmartBackend.h"
#include "shared/GCI/I18N/I18N.h"

#include "shared/XercesHelpers/wrappers/XercesHelper.h"

#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"

#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"

#include "garantServer/src/Services/GslSessionHandlerClient/Home/Server.h"
#include "garantServer/src/Services/GslSessionHandlerRegistration/Home/Server.h"

#include "garantServer/src/Business/GblUserComments/Home/Client.h"
#include "garantServer/src/Business/GblUnderControl/Home/client.h"
#include "garantServer/src/Business/GblSettings/Home/Client.h"
#include "garantServer/src/Business/GblXMLRestore/Home/Client.h"
#include "garantServer/src/Business/GblXMLSave/Home/Client.h"
#include "garantServer/src/Business/GblConsultingClient/Home/Client.h"
#include "garantServer/src/Business/GblIntegration/Home/Client.h"
#include "garantServer/src/Services/GslHeartbeatManager/Home/Client.h"
#include "garantServer/src/Services/GslSecurity/Home/Client.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClientHome.h"
#include "garantServer/src/Services/GslServerManager/Home/Client.h"
#include "garantServer/src/Business/GblLogging/Home/Client.h"
#include "garantServer/src/Business/GblPrime/Home/Client.h"
#include "garantServer/src/Business/GblUserJournal/Home/Client.h"

// Поисковая машина
#include "garantServer/src/Business/GblSearchMachine/Home/Client.h"

// Поддержка ревизий документов через internet
#include "garantServer/src/Business/GblRemoteDocumentSupport/GblRemoteDocumentSupportC.h"

// фильтры
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"

// инициализация чата
#include "shared/ChatLibrary/LibHome.h"
#include "shared/CoreSrv/impl/Root_i/Root_i.h"

#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Core/Common/GCMManager_i.h"

#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ORBFacet_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i_factory.h"
//#UC END# *474C10480085_CUSTOM_INCLUDES*

namespace GblAdapterLibClient {
namespace Start_i {

//#UC START# *474C10480085*
//#UC END# *474C10480085*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Client::Client ()
//#UC START# *474C0E2703A6_474C117B0280_474C10480085_BASE_INIT*
//#UC END# *474C0E2703A6_474C117B0280_474C10480085_BASE_INIT*
{
	//#UC START# *474C0E2703A6_474C117B0280_474C10480085_BODY*
	try {
		GCI::I18N::MessagesFactory::messages ().open ("adapter.mo",	GCI::I18N::LocaleOperationsFactory::make ().get_locale ());
	} catch (GCI::I18N::BadFileFormat& e) {
		LOG_SEX ((e, GDS_CURRENT_FUNCTION));	
	} catch (GCI::I18N::CantFindFile& e) {
		LOG_SEX ((e, GDS_CURRENT_FUNCTION));
	}
	XercesHelpers::XercesHelper::instance (); // инициализируем библиотеку xerces
	//#UC END# *474C0E2703A6_474C117B0280_474C10480085_BODY*
}

Client::~Client () {
	//#UC START# *474C10480085_DESTR_BODY*
	//#UC END# *474C10480085_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GblAdapterLib::ComponentManagerBase
void Client::run () {
	//#UC START# *474D991B039A_474C10480085*
	GCM::GCMManager_var gcm_manager = GCM::GCM_get_manager();
	
	gcm_manager->register_component (new GblLogging::LoggingClientHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblUserComments::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblUnderControl::ComponentKey_c));

	gcm_manager->register_local_component (new GslSessionHandlerClientServer::SessionHandlerClientServerHome ());

	gcm_manager->register_component (new GslHeartbeatManager::HeartbeatManagerClientHome);
	gcm_manager->register_component (new GslUserManager::UserManagerClientHome ());
	
	gcm_manager->register_component (new GCM::GCMSimpleClient (GslSecurity::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblSettings::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblFolders::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblUserJournal::ComponentKey_c));		
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblPilot::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblIntegration::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblXMLRestore::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblXMLSave::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblPrime::ComponentKey_c));
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblConsultingClient::ComponentKey_c));
	// Поисковая машина
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblSearchMachine::ComponentKey_c));
	// Поддержка ревизий документов через internet
	gcm_manager->register_component (new GCM::GCMSimpleClient(GblRemoteDocumentSupport::ComponentKey_c));
	// фильтры 
	gcm_manager->register_component (new GCM::GCMSimpleClient(GblFilters::ComponentKey_c));


	gcm_manager->register_local_component (IObject::_duplicate (this));

	gcm_manager->start_components (false);	

	// для интерфейса нужно подсунуть правильный орб
	{
		CoreSrv::Root::OrbAcsessor_var orb_facet (new NemesisChatImplementation::ChatImplementation::ORBFacet_i ());
		dynamic_cast<CoreSrv::Root_i::CorbaLibHomeLocal&> (ChatLibrary::LibHomeFactory::get ()).set_orb_facet (orb_facet.ptr ());

		GblAdapterLib::ChatService_i::MessageListener_i_factory_var fctr = new GblAdapterLib::ChatService_i::MessageListener_i_factory ();
		fctr->registrate_me(0);

		ChatLibrary::ChatService::MessageListenerFactoryManager::publish_self ();
	}
	//#UC END# *474D991B039A_474C10480085*
}

// implemented method from GblAdapterLib::ComponentManagerBase
void Client::smart_backend_init () const {
	//#UC START# *474D96A6012A_474C10480085*

	// init logging truncation (http://mdp.garant.ru/x/wYIGAw)
	const ACE_TCHAR c_max_log_free_size_parameter [] = ACE_TEXT ("-SBEMaxLogFreeSize");

	if (Core::ParamManagerFactory::get ().is_exist (c_max_log_free_size_parameter)) {
		GCM::get_cached_log_msg_smart_backend ()->reset_to_truncate_mode (); 
	}

	//#UC END# *474D96A6012A_474C10480085*
}

// implemented method from GblAdapterLib::ComponentManagerBase
void Client::timestamp_init (GblPilot::FunctionMng* function_manager) const {
	//#UC START# *474D96B80258_474C10480085*
	GblAdapterLib::TimeStampSync::TimeStampObjectManager::instance ()->init (function_manager);
	//#UC END# *474D96B80258_474C10480085*
}
} // namespace Start_i
} // namespace GblAdapterLibClient

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

