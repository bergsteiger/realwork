////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/ComponentManagerBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::ComponentManagerBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/ComponentManagerBase.h"

//#UC START# *474D69D80059_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"

#include "garantServer/src/Global/Core/Common/ACESocketParams.h"
#include "garantServer/src/Global/Core/Common/GCL.h"
#include "garantServer/src/Global/Core/Common/TimeStampSync_i.h"
#include "garantServer/src/Global/Core/Common/AutoIPConfig.h"
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Defines/DefinesC.h"

#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h" // for BadNetworkConfig
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h" // LicenceViolation
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h" // ConfigurationsNotDefined

#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"

namespace {
	void exception_safe_cleanup () {
	_SAFE_TRY
		GCM::GCM_clear_manager ();
	_SAFE_CATCH
	}
}
//#UC END# *474D69D80059_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *474D69D80059*
class GblAdapterCorbaExHandler: public CoreSrv::Exception::CorbaExHandler {
public:
	bool do_handle (CORBA::Exception& ex, bool must_throw) {
		if (::TimeStampSync::InvalidTimeStamp* stump_ex = dynamic_cast <::TimeStampSync::InvalidTimeStamp*> (&ex)) {
			SLOG_SHIFT
			SLOG_D (("corba_ex_handler: catching InvalidTimeStamp (stump_ex->catch_action = %d)", stump_ex->catch_action));
			if (stump_ex->catch_action == ::TimeStampSync::CA_RETRY) {
				TimeStampSync::TimeStampObjectManager::instance()->wait_for_changes (stump_ex->needed_ts);
				return true;
			}
			if (must_throw) {
				GblAdapterLib::InvalidTimeStamp ex;			
				Core::Exception::std_ex_handler (ex);
			}
		} else if (dynamic_cast <GTree::ConstantModify*> (&ex)) {
			GblAdapterLib::ConstantModify ex;
			Core::Exception::std_ex_handler (ex);
		} else if (dynamic_cast <GCL::SysStorageLocked*> (&ex) || dynamic_cast <CORBA::NO_RESOURCES*> (&ex)) {
			GblAdapterLib::StorageLocked ex;
			Core::Exception::std_ex_handler (ex);
		} else if (dynamic_cast <GCD::StorageInternalError*> (&ex)) {
			GblAdapterLib::InternalServerError ex;
			Core::Exception::std_ex_handler (ex);
		} else if (
			dynamic_cast <CORBA::TRANSIENT*> (&ex) 
			|| dynamic_cast <CORBA::COMM_FAILURE*> (&ex)
			|| dynamic_cast <CORBA::OBJECT_NOT_EXIST*> (&ex)
		) {
			GblAdapterLib::NoServer ex;
			Core::Exception::std_ex_handler (ex);
		} 

		return false;
	}
};
//#UC END# *474D69D80059*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ComponentManagerBase::ComponentManagerBase ()
//#UC START# *474C0E2703A6_474C117B0280_474D69D80059_BASE_INIT*
//#UC END# *474C0E2703A6_474C117B0280_474D69D80059_BASE_INIT*
{
	//#UC START# *474C0E2703A6_474C117B0280_474D69D80059_BODY*
	this->register_receptacles (Defines::FN_FUNCTION_MNG);
	this->register_receptacles (Defines::FN_USER_MANAGER);
	this->register_receptacles (Defines::FN_GROUP_MANAGER);
	this->register_receptacles (Defines::FN_USERCOMMENTS);
	this->register_receptacles (Defines::FN_SEARCH_MANAGER);
	this->register_receptacles (Defines::FN_FOLDERS);
	this->register_receptacles (Defines::FN_SECURITY_PROPERTIES);
	this->register_receptacles (Defines::FN_UNDERCONTROL_MNG);
	this->register_receptacles (Defines::FN_SETTINGS_MANAGER);
	this->register_receptacles (Defines::FN_CONSULTATION_MANAGER_CLIENT);
	this->register_receptacles (Defines::FN_LOGGING_MANAGER);
	this->register_receptacles (Defines::FN_INTEGRATION);
	this->register_receptacles (Defines::FN_XML_SAVE);
	this->register_receptacles (Defines::FN_PRIME);
	this->register_receptacles (Defines::FN_PRINT_CONTRACT_FORM);
	this->register_receptacles (Defines::FN_PRIME_XML_SAVE);
	this->register_receptacles (Defines::FN_USER_JOURNAL);
	this->register_receptacles (Defines::FN_TREE_FACTORY);
	this->register_receptacles (Defines::FN_BANNER_MANAGER);
	this->register_receptacles (Defines::FN_REMOTE_DOCUMENT_SUPPORT);
	this->register_receptacles (Defines::FN_FILTERS_MANAGER);
	this->register_receptacles (Defines::FN_CONTEXT_FILTER);
	this->register_receptacles (Defines::FN_MAIN_MENU);
	this->register_receptacles (Defines::FN_DECISIONS_ARCHIVE_SUPPORT);
	this->register_receptacles (Defines::FN_DOCUMENT_TYPE_RESOLVER);
	this->register_receptacles (Defines::FN_LINK_MANAGER);


	// register global DataTransformers
	NotifyManager& notify_manager = NotifyManagerFactory::make();
	
	Core::Var<DataTransformer> string_transformer = DataTransformerFactory::make ("string");
	notify_manager.register_transformer (NT_LONG_OPERATION_START, string_transformer.in ());
	Core::Var<DataTransformer> long_transformer = DataTransformerFactory::make ("long");
	notify_manager.register_transformer (NT_SHUTDOWN, long_transformer.in ());
	notify_manager.register_transformer (NT_LOGOUT, long_transformer.in ());
	//#UC END# *474C0E2703A6_474C117B0280_474D69D80059_BODY*
}

ComponentManagerBase::~ComponentManagerBase () {
	//#UC START# *474D69D80059_DESTR_BODY*
	//#UC END# *474D69D80059_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void ComponentManagerBase::execute () {
	//#UC START# *474D71240034*
	GCM::register_valuetype_factory<GTree::NameFilter_init> ();
	GCM::register_valuetype_factory<GTree::LayerFilter_init> ();
	GCM::register_valuetype_factory<GTree::LayerNameFilter_init> ();
	GCM::register_valuetype_factory<GTree::TrimFilter_init> ();
	GCM::register_valuetype_factory<GTree::TrimLeafFilter_init> ();
	GCM::register_valuetype_factory<GTree::SortFilter_init> ();
	GCM::register_valuetype_factory<GblPilotDef::ComplectInfoValue_init> ();
	GCM::register_valuetype_factory<GblPilot::ContentsNodeValue_init> ();
	GCM::register_valuetype_factory<GblDocList::ListNodeValue_init> ();
	GCM::register_valuetype_factory<GblDocList::SnippetListNodeValue_init> ();
	GCM::register_valuetype_factory<GblPilotQueryDef::QueryFilter_init> ();

	GCM::register_valuetype_factory<GblPilotQueryDef::QueryDictData_init> ();
	GCM::register_valuetype_factory<GblPilotQueryDef::QueryDateData_init> ();
	GCM::register_valuetype_factory<GblPilotQueryDef::QueryContextData_init> ();
	GCM::register_valuetype_factory<GblPilotQueryDef::QueryPhoneNumberData_init> ();
	GCM::register_valuetype_factory<GblPilotQueryDef::StorableQueryDictData_init> ();

	GCM::register_valuetype_factory<GblPilotQueryDef::CutToLeafCountFilter_init> ();
	GCM::register_valuetype_factory<GblPilotQueryDef::DocIdVariantsFilter_init> ();

	GCM::register_valuetype_factory<GslUserManager::UserNodeValue_init> ();
	GCM::register_valuetype_factory<GslUserManager::UserFilter_init> ();

	GCM::register_valuetype_factory<GblPilot::DocNodeFindFilter_init> ();
	
	GCM::register_valuetype_factory<GTree::ChangeDelta_init> ();
	GCM::register_valuetype_factory<GTree::InsertDelta_init> ();
	GCM::register_valuetype_factory<GTree::DeleteDelta_init> ();
	GCM::register_valuetype_factory<GTree::ResetDelta_init> ();

	// Расширенная информация по документу
	GCM::register_valuetype_factory<GblPilotDef::ExtendedDocInfo_init> ();
	// Расширенная информация по документу-консультации
	GCM::register_valuetype_factory<GblConsultingClient::ExtendedConsultationDocInfo_init> ();

	// Register valuetypes
	GCM::register_valuetype_factory<GblConsultingDef::ConsultationData_init> ();
	GCM::register_valuetype_factory<GblConsultingDef::HCConsultationData_init> ();
	GCM::register_valuetype_factory<GblPilotDef::PrefixValue_init> ();
	GCM::register_valuetype_factory<GblPilotDef::IndexNodeValue_init> ();
	GCM::register_valuetype_factory<GblPilotDef::RubricatorValue_init> ();
	GCM::register_valuetype_factory<GblUserJournalDef::JournalValue_init> ();

	// Фильтр списка фирм по странам
	GCM::register_valuetype_factory<GblPilot::CountryFilter_init> ();

	// Фильтр, оставляющий только те блоки в дереве, по которым пользователю разрешён поиск
	GCM::register_valuetype_factory<GblPilotQueryDef::BlocksFilter_init> ();

	// Фильтр, оставляющий только те блоки в дереве, которые не имеют отношения к инфарму
	GCM::register_valuetype_factory<GblPilotQueryDef::InpharmFilter_init> ();

	GCMSimpleServer::execute ();
	//#UC END# *474D71240034*
}

CORBA::Object* ComponentManagerBase::get_server_interface (const char* name) const {
	//#UC START# *474D6B3003B5*
	CORBA::Object_var object = const_cast<ComponentManagerBase*> (this)->provide (name);
	return object._retn ();
	//#UC END# *474D6B3003B5*
}

ServerFacade* ComponentManagerBase::make_server_facade () {
	//#UC START# *474D6ABC0107*
	class ServerFacade_i : public ServerFacade {
	public:
		CORBA::Object* get_server_interface (const char* name) const {
			ComponentManager& component_manager = Core::TypeTraits<ComponentManager>::Factory::make ();
			return dynamic_cast<ComponentManagerBase&> (component_manager).get_server_interface (name);
		}
	};
	return new ServerFacade_i ();
	//#UC END# *474D6ABC0107*
}

void ComponentManagerBase::pre_orb_run () {
	//#UC START# *4756622C0098*
	//GDS_ASSERT (m_notify_manager.ptr ());
	NotifyManagerFactory::make().listen_for_all ();
	//#UC END# *4756622C0098*
}

void ComponentManagerBase::wait_for_finalize () {
	//#UC START# *475662C90195*
	// we must release notify_manager at this point
	//m_notify_manager = 0;
	//#UC END# *475662C90195*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ComponentManager
void ComponentManagerBase::start () /*throw (StorageLocked, LicenceViolation, ConfigurationsNotDefined, IPAddressNotFound, InvalidBase, NoServer, BadNetworkConfig, ServerVersionNotValid, WorkingParamsNotFound, NoMoreConnections, MorphoNotExists, InternalApplicationError, InvalidUserDatastore, ServerIsStarting)*/ {
	//#UC START# *474C0E5E0042_474D69D80059*
	Core::Var<GblAdapterCorbaExHandler> ch = new GblAdapterCorbaExHandler ();
	CoreSrv::Exception::register_corba_ex_handler (ch.in());

	// redirect to 0, to speed up shell (delphi client) termination:
	_CrtSetReportMode (_CRT_WARN, _CRTDBG_MODE_FILE);
	_CrtSetReportFile (_CRT_WARN, 0);
	_CrtSetReportMode (_CRT_ERROR, _CRTDBG_MODE_FILE);
	_CrtSetReportFile (_CRT_ERROR, 0);
	_CrtSetReportMode (_CRT_ASSERT, _CRTDBG_MODE_FILE);
	_CrtSetReportFile (_CRT_ASSERT, 0);
	
	ServerFacade_cvar server_facade = this->make_server_facade ();
	ApplicationHelper::instance ()->init (server_facade.in ());

	try {
		if (!GCM::default_init_of_param_manager ()) {
			throw GblAdapterLib::WorkingParamsNotFound ();
		}

		// set ACE send/recv options (http://mdp.garant.ru/x/j4sxC)
		GCM::ACESocketParams::set_ace_socket_params ();

		try {
			Core::Aptr <Core::ParamArgs> arg_list = Core::ParamManagerFactory::get ().command_line_for_orb_init ();
		} catch (Core::DataNotFound&) {
			throw GblAdapterLib::WorkingParamsNotFound ();
		}
		
		try {
			this->run ();
		} catch (GCM::AutoIPConfig::BadNetworkConfig& ex) {
			LOG_E ((ex.what ()));
			throw GblAdapterLib::BadNetworkConfig ();
		} catch (GCM::AutoIPConfig::ServerNotFound& ex) {
			LOG_E ((ex.what ()));
			throw GblAdapterLib::NoServer ();
		} catch (GCM::AutoIPConfig::IPAddressNotFound& ex) {
			LOG_E ((ex.what ()));
			throw GblAdapterLib::IPAddressNotFound ();
		} catch (GslUserManager::LicenceViolation&) {
			throw GblAdapterLib::LicenceViolation ();
		} catch (GslUserManager::NoMoreConnections&) {
			throw  GblAdapterLib::NoMoreConnections ();
		} catch (GCM::ComponentError&) {
			throw GblAdapterLib::InternalApplicationError ();
		} catch (GCD::ServerVersionNotValid&) {
			throw GblAdapterLib::ServerVersionNotValid ();
		} catch (GCM::NoServer&) {
			throw GblAdapterLib::NoServer ();
		} catch (GCD::InvalidDatastore&) {
			throw GblAdapterLib::InvalidUserDatastore ();
		} catch (GCM::ServerIsStarting&) {
			throw GblAdapterLib::ServerIsStarting ();
		}

		this->smart_backend_init ();
			
		// check for valid database
		GblPilot::FunctionMng_ptr function_manager = 
			GblAdapterLib::ApplicationHelper::instance ()->get_cached_function_manager ();
		GblPilotDef::StorageStatus datastore_status;
		try {
			datastore_status = (function_manager->check_datastore ());
		} catch (GCL::SysStorageLocked&) {
			throw GblAdapterLib::StorageLocked ();
		}

		switch (datastore_status) {
			case GblPilotDef::SS_INVALID:
			case GblPilotDef::SS_UNKNOWN:
			case GblPilotDef::SS_INVALID_VERSION:
				throw GblAdapterLib::InvalidBase ();
			case GblPilotDef::SS_MORPHO_NOT_EXISTS:
				throw GblAdapterLib::MorphoNotExists ();
			default:
				// все хорошо
				break;
		}

		// check for existing configurations
		if (!GblAdapterLib::ApplicationHelper::instance ()->is_configurations_exist ()) {
			throw GblAdapterLib::ConfigurationsNotDefined ();
		}

		this->timestamp_init (function_manager);
		
	} catch (GblAdapterLib::InvalidBase&) {
		// Разрешенное, не фатальное исключение, завершать GCM при этом не нужно, 
		// иначе при его обработке локальной оболочкой сервер будет уже убит
		throw;
	} catch (GblAdapterLib::MorphoNotExists&) {
		// Разрешенное, не фатальное исключение, завершать GCM при этом не нужно, 
		// иначе при его обработке локальной оболочкой сервер будет уже убит
		throw;
	} catch (...) {
		// А вот так мы уже работать не можем - поэтому завершаем GCM и сигнализируем оболочке
		exception_safe_cleanup ();
		throw;
	}
	//#UC END# *474C0E5E0042_474D69D80059*
}

// implemented method from ComponentManager
void ComponentManagerBase::stop () {
	//#UC START# *474C0E7501F1_474D69D80059*
_SAFE_TRY
	GCM::GCMManager_var gcm_manager = GCM::GCM_get_manager();
	gcm_manager->stop_components ();
	gcm_manager = GCM::GCMManager::_nil ();
	exception_safe_cleanup ();
_SAFE_CATCH
	//#UC END# *474C0E7501F1_474D69D80059*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

