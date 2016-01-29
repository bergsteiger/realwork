////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibDesktop::Start_i::Desktop
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLibDesktop/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop.h"

//#UC START# *474C107C02E0_CUSTOM_INCLUDES*
#include "shared/GCI/I18N/I18N.h"

#include "shared/XercesHelpers/wrappers/XercesHelper.h"

#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"

#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"

#include "garantServer/src/Services/GslHeartbeatManager/Home/Server.h"
#include "garantServer/src/Services/GslSecurity/Home/Server.h"
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Server.h"
#include "garantServer/src/Services/GslSessionHandlerRegistration/Home/Server.h"
#include "garantServer/src/Services/GslSessionHandlerServer/Home/Server.h"
#include "garantServer/src/Services/GslServerManager/Home/Server.h"

#include "garantServer/src/Business/GblUserComments/Home/Client.h"
#include "garantServer/src/Business/GblUnderControl/Home/client.h"
#include "garantServer/src/Business/GblSettings/Home/Client.h"
#include "garantServer/src/Business/GblXMLRestore/Home/Client.h"
#include "garantServer/src/Business/GblXMLSave/Home/Client.h"
#include "garantServer/src/Business/GblConsultingClient/Home/Client.h"
#include "garantServer/src/Business/GblIntegration/Home/Client.h"
#include "garantServer/src/Services/GslHeartbeatManager/Home/Client.h"
#include "garantServer/src/Services/GslSecurity/Home/Client.h"
#include "garantServer/src/Services/GslServerManager/Home/Client.h"
#include "garantServer/src/Services/GslUserManager/Server/UserManagerServerHome.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClientHome.h"
#include "garantServer/src/Business/GblUserJournal/Home/Client.h"

#include "garantServer/src/Business/GblLogging/Home/Client.h"
#include "garantServer/src/Business/GblPrime/Home/Client.h"
#include "garantServer/src/Business/GblFolders/Home/Server.h"
#include "garantServer/src/Business/GblPilot/Home/Server.h"
#include "garantServer/src/Business/GblSettings/Home/Server.h"
#include "garantServer/src/Business/GblXMLRestore/Home/Server.h"
#include "garantServer/src/Business/GblXMLSave/Home/Server.h"
#include "garantServer/src/Business/GblConsultingClient/Home/Server.h"
#include "garantServer/src/Business/GblIntegration/Home/Server.h"
#include "garantServer/src/Business/GblUserComments/Home/Server.h"
#include "garantServer/src/Business/GblUnderControl/Home/Server.h"
#include "garantServer/src/Business/GblLogging/Home/Server.h"
#include "garantServer/src/Business/GblPrime/Home/Server.h"
#include "garantServer/src/Business/GblUserJournal/Home/Server.h"
#include "garantServer/src/Business/GblChatSupport/Server/ChatSupportServerHome.h"

// Поисковая машина
#include "garantServer/src/Business/GblSearchMachine/Home/Server.h"
#include "garantServer/src/Business/GblSearchMachine/Home/Client.h"

// Поддержка ревизий документов через internet
#include "garantServer/src/Business/GblRemoteDocumentSupport/Server/RemoteDocumentSupportServerHome.h"
#include "garantServer/src/Business/GblRemoteDocumentSupport/GblRemoteDocumentSupportC.h"

#include "garantServer/src/Services/GslSessionIdentifier/Home/Client.h"
#include "garantServer/src/Services/GslSessionIdentifier/Home/Server.h"

// Поддержка фильтров
#include "garantServer/src/Business/GblFilters/Server/FiltersServerHome.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"

#include "garantServer/src/Services/GslAuthenticator/GslAuthenticatorC.h"
#include "garantServer/src/Services/GslAuthenticator/Server/AuthenticatorServerHome.h"


// инициализация чата
#include "shared/ChatLibrary/LibHome.h"
#include "shared/CoreSrv/impl/Root_i/Root_i.h"

#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ORBFacet_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i_factory.h"
//#UC END# *474C107C02E0_CUSTOM_INCLUDES*

namespace GblAdapterLibDesktop {
namespace Start_i {

//#UC START# *474C107C02E0*
//#UC END# *474C107C02E0*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Desktop::Desktop ()
//#UC START# *474C0E2703A6_474C117B0280_474C107C02E0_BASE_INIT*
//#UC END# *474C0E2703A6_474C117B0280_474C107C02E0_BASE_INIT*
{
	//#UC START# *474C0E2703A6_474C117B0280_474C107C02E0_BODY*
	try {
		GCI::I18N::MessagesFactory::messages ().open ("adapter.mo", GCI::I18N::LocaleOperationsFactory::make ().get_locale ());
		GCI::I18N::MessagesFactory::messages ().open ("server.mo", GCI::I18N::LocaleOperationsFactory::make ().get_locale ());
	} catch (GCI::I18N::BadFileFormat& e) {
		LOG_SEX ((e, GDS_CURRENT_FUNCTION));	
	} catch (GCI::I18N::CantFindFile& e) {
		LOG_SEX ((e, GDS_CURRENT_FUNCTION));
	}

	XercesHelpers::XercesHelper::instance (); // инициализируем библиотеку xerces
	//#UC END# *474C0E2703A6_474C117B0280_474C107C02E0_BODY*
}

Desktop::~Desktop () {
	//#UC START# *474C107C02E0_DESTR_BODY*
	//#UC END# *474C107C02E0_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GblAdapterLib::ComponentManagerBase
void Desktop::run () {
	//#UC START# *474D991B039A_474C107C02E0*
	GCM::GCMManager_var gcm_manager = GCM::GCM_get_manager();
	
	gcm_manager->register_component (new GblLoggingServer::LoggingServerHome ());
	gcm_manager->register_component (new GblLogging::LoggingClientHome ());
	
	// Инициализируем бизнес-компоненту и хранилище как можно раньше
	// возможно, инициализацию хранилища нужно вынести в отдельную компоненту
	// При инициализации хранилища кешируются данные, которые далее используются другими компонентами
	// например, лицензионные настройки используются в GslUserManager
	gcm_manager->register_component (new GblPilotServer::PilotServerHome (GblPilotServer::PilotServerHome::INIT_DATASTORE));

	gcm_manager->register_component (new GblUserCommentsServer::UserCommentsServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblUserComments::ComponentKey_c));

	gcm_manager->register_component (new GblUnderControlServer::UnderControlServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblUnderControl::ComponentKey_c));

	gcm_manager->register_local_component (new GslSessionHandlerClientServer::SessionHandlerClientServerHome ());

	gcm_manager->register_local_component (new GslSessionHandlerRegistrationServer::SessionHandlerRegistrationServerHome ());
	gcm_manager->register_local_component (new GCM::GCMSimpleClient (GslSessionHandlerRegistration::ComponentKey_c));
	gcm_manager->register_local_component (new GslSessionHandlerServerServer::SessionHandlerServerServerHome ());
	gcm_manager->register_local_component (new GCM::GCMSimpleClient (GslSessionHandlerServer::ComponentKey_c));

	gcm_manager->register_component (new GslHeartbeatManagerServer::HeartbeatManagerServerHome);
	gcm_manager->register_component (new GslHeartbeatManager::HeartbeatManagerClientHome);

	gcm_manager->register_component (new GslUserManagerServer::UserManagerServerHome ());
	gcm_manager->register_component (new GslUserManager::UserManagerClientHome ());

	gcm_manager->register_component (new GslSecurityServer::SecurityServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GslSecurity::ComponentKey_c));

	gcm_manager->register_component (new GblSettingsServer::SettingsServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblSettings::ComponentKey_c));

	gcm_manager->register_local_component (new GslSessionIdentifierServer::SessionIdentifierServerHome);
	gcm_manager->register_local_component (new GCM::GCMSimpleClient (GslSessionIdentifier::ComponentKey_c));

	gcm_manager->register_component (new GblFoldersServer::FoldersServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblFolders::ComponentKey_c));

	gcm_manager->register_component (new GCM::GCMSimpleClient(GslAuthenticator::ComponentKey_c));
	gcm_manager->register_component (new GslAuthenticatorServer::AuthenticatorServerHome);

	// Журнал работы нужно инициализировать строго после папок, 
	// так как при первом старте требуется конвертация пользовательского журнала из папок в новое хранилище
	gcm_manager->register_component (new GblUserJournalServer::UserJournalServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient(GblUserJournal::ComponentKey_c));		

	gcm_manager->register_component (new GCM::GCMSimpleClient (GblPilot::ComponentKey_c));

	gcm_manager->register_component (new GslServerManagerServer::ServerManagerServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GslServerManager::ComponentKey_c));

	gcm_manager->register_component (new GblIntegrationServer::IntegrationServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblIntegration::ComponentKey_c));

	gcm_manager->register_component (new GblXMLSaveServer::XMLSaveServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblXMLSave::ComponentKey_c));

	gcm_manager->register_component (new GblPrimeServer::PrimeServerHome ());                         // {{{ init order
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblPrime::ComponentKey_c));            //     для 7.2 - сначала перекладываем прайм из папок _predefined_data, потом заливаем из XML поверх

	gcm_manager->register_component (new GblXMLRestoreServer::XMLRestoreServerHome ());               //     восстанавливаем настройки proxy для походов на СК
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblXMLRestore::ComponentKey_c));

	gcm_manager->register_component (new GblConsultingClientServer::ConsultingClientServerHome ());   //     инициализируем HTIOP
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblConsultingClient::ComponentKey_c)); // }}}

	// Поисковая машина
	gcm_manager->register_component (new GCM::GCMSimpleClient (GblSearchMachine::ComponentKey_c));
	gcm_manager->register_component (new GblSearchMachineServer::SearchMachineServerHome (false));

	// Поддержка ревизий документов через internet
	gcm_manager->register_component (new GblRemoteDocumentSupportServer::RemoteDocumentSupportServerHome ());
	gcm_manager->register_component (new GCM::GCMSimpleClient(GblRemoteDocumentSupport::ComponentKey_c));

	// фильтры
	gcm_manager->register_component (new GCM::GCMSimpleClient(GblFilters::ComponentKey_c));
	gcm_manager->register_component (new GblFiltersServer::FiltersServerHome);


	gcm_manager->register_local_component (IObject::_duplicate (this));
	
	gcm_manager->register_component (new GblChatSupportServer::ChatSupportServerHome ());
 
	GblAdapterLib::TimeStampSync::TimeStampObjectManager::instance ()->init_desktop ();
	
	gcm_manager->start_components (false);

	// для интерфейса нужно подсунуть правильный орб
	{
		CoreSrv::Root::OrbAcsessor_var orb_facet (new NemesisChatImplementation::ChatImplementation::ORBFacet_i ());
		dynamic_cast<CoreSrv::Root_i::CorbaLibHomeLocal&> (ChatLibrary::LibHomeFactory::get ()).set_orb_facet (orb_facet.ptr ());

		GblAdapterLib::ChatService_i::MessageListener_i_factory_var fctr = new GblAdapterLib::ChatService_i::MessageListener_i_factory ();
		fctr->registrate_me(0);

		ChatLibrary::ChatService::MessageListenerFactoryManager::publish_self ();
	}
	//#UC END# *474D991B039A_474C107C02E0*
}

// implemented method from GblAdapterLib::ComponentManagerBase
void Desktop::smart_backend_init () const {
	//#UC START# *474D96A6012A_474C107C02E0*
	//#UC END# *474D96A6012A_474C107C02E0*
}

// implemented method from GblAdapterLib::ComponentManagerBase
void Desktop::timestamp_init (GblPilot::FunctionMng* function_manager) const {
	//#UC START# *474D96B80258_474C107C02E0*
	//#UC END# *474D96B80258_474C107C02E0*
}
} // namespace Start_i
} // namespace GblAdapterLibDesktop

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

