////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::ApplicationHelper::ApplicationHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
// by <<uses>> dependencies
#include "garantServer/src/Global/Defines/DefinesC.h"

//#UC START# *460A6EF8024B_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterClient/GblAdapterClient.h"
#include "garantServer/src/Global/Defines/Common/XMLDef.h"
//#UC END# *460A6EF8024B_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *460A6EF8024B*
//#UC END# *460A6EF8024B*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ApplicationHelper::ApplicationHelper ()
//#UC START# *474704110312_BASE_INIT*
	: m_server_facade (0), m_uid (0)
//#UC END# *474704110312_BASE_INIT*
{
	//#UC START# *474704110312_BODY*
	//#UC END# *474704110312_BODY*
}

ApplicationHelper::~ApplicationHelper () {
	//#UC START# *460A6EF8024B_DESTR_BODY*
	//#UC END# *460A6EF8024B_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Очистка кешированных серверных объектов
void ApplicationHelper::clear_cache () const {
	//#UC START# *460CDD6C0399*
	m_folders = GblFolders::Folders::_nil ();
	m_under_control_manager = GblUnderControl::UnderControlMng::_nil ();
	m_settings = GblSettings::Settings::_nil ();
	//#UC END# *460CDD6C0399*
}

void ApplicationHelper::clear_cache_and_regenerate_base_id () {
	//#UC START# *460A806C0214*
	m_base_id.stamp++;
	LOG_D (("BaseId has been regenerated"));
	//#UC END# *460A806C0214*
}

bool ApplicationHelper::compare_and_update_base_id (BaseId& base_id) const {
	//#UC START# *460A80AB0254*
	bool result = (ACE_OS_String::memcmp (&base_id, &m_base_id, sizeof (ApplicationHelper::BaseId)) == 0);
	if (!result) {
		ACE_OS_String::memmove (&base_id, &m_base_id, sizeof (ApplicationHelper::BaseId));
		//
		LOG_D (("BaseId has been updated"));
	}
	return result;
	//#UC END# *460A80AB0254*
}

// Получить баннер с сервера
GblPilot::BannerManager* ApplicationHelper::get_cached_banner_manager () const {
	//#UC START# *4ACF446803B9*
	if (CORBA::is_nil (m_banner_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_banner_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_banner_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_BANNER_MANAGER);
			m_banner_manager = GblPilot::BannerManager::_narrow (object.in ());
		}
	}
	return m_banner_manager.ptr ();
	//#UC END# *4ACF446803B9*
}

GblConsultingClient::ConsultationManager* ApplicationHelper::get_cached_consultation_manager () const {
	//#UC START# *460BA73401D4*
	if (CORBA::is_nil (m_consultation_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_consultation_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_consultation_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_CONSULTATION_MANAGER_CLIENT);
			m_consultation_manager = GblConsultingClient::ConsultationManager::_narrow (object.in ());
		}
	}
	return m_consultation_manager.ptr ();
	//#UC END# *460BA73401D4*
}

GTree::ContextFilter* ApplicationHelper::get_cached_context_filter () const {
	//#UC START# *4D3EE8C701C0*
	if (CORBA::is_nil (m_context_filter.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_context_filter_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_context_filter.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_CONTEXT_FILTER);
			m_context_filter = GTree::ContextFilter::_narrow (object.in ());
		}
	}
	return m_context_filter.ptr ();
	//#UC END# *4D3EE8C701C0*
}

GblPrime::ContractForm* ApplicationHelper::get_cached_contract_form () const {
	//#UC START# *460A819B01DA*
	if (CORBA::is_nil (m_contract_form.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_contract_form_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_contract_form.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_PRINT_CONTRACT_FORM);
			m_contract_form = GblPrime::ContractForm::_narrow (object.in ());
		}
	}
	return m_contract_form.ptr ();
	//#UC END# *460A819B01DA*
}

// возвращает идентификатор текущего пользователя
GCD::Uid ApplicationHelper::get_cached_current_user_id () const {
	//#UC START# *4AEE9E0E01D3*
	if (!m_uid) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_user_id_mutex, CORBA::INTERNAL ());
		if (!m_uid) {
			m_uid = this->get_cached_user_manager ()->get_current_user_id ();
			GDS_ASSERT (m_uid && "we must have session");
		}
	}

	return m_uid;
	//#UC END# *4AEE9E0E01D3*
}

GblRemoteDocumentSupport::DecisionsArchiveSupport* ApplicationHelper::get_cached_decisions_archive_support () const {
	//#UC START# *4F71D2D20136*
	if (CORBA::is_nil (m_decisions_archive_support.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_decisions_archive_support_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_decisions_archive_support.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_DECISIONS_ARCHIVE_SUPPORT);
			m_decisions_archive_support = GblRemoteDocumentSupport::DecisionsArchiveSupport::_narrow (object.in ());
		}
	}
	return m_decisions_archive_support.ptr ();
	//#UC END# *4F71D2D20136*
}

GblPilot::DocumentTypeResolver* ApplicationHelper::get_cached_document_type_resolver () const {
	//#UC START# *4FE86FAD00A3*
	if (CORBA::is_nil (m_document_type_resolver.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_document_type_resolver_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_document_type_resolver.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_DOCUMENT_TYPE_RESOLVER);
			m_document_type_resolver = GblPilot::DocumentTypeResolver::_narrow (object.in ());
		}
	}
	return m_document_type_resolver.ptr ();
	//#UC END# *4FE86FAD00A3*
}

GblFilters::FiltersManager* ApplicationHelper::get_cached_filters_manager () const {
	//#UC START# *4CA5C3E1000C*
	if (CORBA::is_nil (m_filters_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_filters_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_filters_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_FILTERS_MANAGER);
			m_filters_manager = GblFilters::FiltersManager::_narrow (object.in ());
		}
	}
	return m_filters_manager.ptr ();
	//#UC END# *4CA5C3E1000C*
}

GblFolders::Folders* ApplicationHelper::get_cached_folders () const {
	//#UC START# *460B91FC0157*
	if (CORBA::is_nil (m_folders.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_folders_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_folders.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_FOLDERS);
			m_folders = GblFolders::Folders::_narrow (object.in ());
		}
	}
	return m_folders.ptr ();
	//#UC END# *460B91FC0157*
}

GblPilot::FunctionMng* ApplicationHelper::get_cached_function_manager () const {
	//#UC START# *460A80C603C1*
	if (CORBA::is_nil (m_function_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_function_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_function_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_FUNCTION_MNG);
			m_function_manager = GblPilot::FunctionMng::_narrow (object.in ());
		}
	}
	return m_function_manager.ptr ();
	//#UC END# *460A80C603C1*
}

GslUserManager::GroupManager* ApplicationHelper::get_cached_group_manager () const {
	//#UC START# *4AF00C4B02A1*
	if (CORBA::is_nil (m_group_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_group_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_group_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_GROUP_MANAGER);
			m_group_manager = GslUserManager::GroupManager::_narrow (object.in ());
		}
	}
	return m_group_manager.ptr ();
	//#UC END# *4AF00C4B02A1*
}

GblIntegration::Integration* ApplicationHelper::get_cached_integration () const {
	//#UC START# *463F5B37009C*
	if (CORBA::is_nil (m_integration.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_integration_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_integration.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_INTEGRATION);
			m_integration = GblIntegration::Integration::_narrow (object.in ());
		}
	}
	return m_integration.ptr ();
	//#UC END# *463F5B37009C*
}

GCD::LifeCycleManager* ApplicationHelper::get_cached_life_cycle_manager () const {
	//#UC START# *460B95D9004E*
	if (CORBA::is_nil (m_life_cycle_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_life_cycle_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_life_cycle_manager.in ())) {
			m_life_cycle_manager = this->get_cached_function_manager ()->get_life_cycle_manager ();
		}
	}
	return m_life_cycle_manager.ptr ();
	//#UC END# *460B95D9004E*
}

GblPilot::LinkManager* ApplicationHelper::get_cached_link_manager () const {
	//#UC START# *55952CE501E5*
	if (CORBA::is_nil (m_link_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_link_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_link_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_LINK_MANAGER);
			m_link_manager = GblPilot::LinkManager::_narrow (object.in ());
		}
	}
	return m_link_manager.ptr ();
	//#UC END# *55952CE501E5*
}

GblLogging::LoggingManager* ApplicationHelper::get_cached_logging_manager () const {
	//#UC START# *460BA77D007D*
	if (CORBA::is_nil (m_logging_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_logging_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_logging_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_LOGGING_MANAGER);
			m_logging_manager = ::GblLogging::LoggingManager::_narrow (object.in ());
		}
	}
	return m_logging_manager.ptr ();
	//#UC END# *460BA77D007D*
}

GblPilot::MainMenu* ApplicationHelper::get_cached_main_menu () const {
	//#UC START# *4DD4FCEF01B0*
	if (CORBA::is_nil (m_main_menu.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_main_menu_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_main_menu.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_MAIN_MENU);
			m_main_menu = GblPilot::MainMenu::_narrow (object.in ());
		}
	}
	return m_main_menu.ptr ();
	//#UC END# *4DD4FCEF01B0*
}

GblPrime::Prime* ApplicationHelper::get_cached_prime () const {
	//#UC START# *47C2A4670007*
	if (CORBA::is_nil (m_prime.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_prime_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_prime.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_PRIME);
			m_prime = GblPrime::Prime::_narrow (object.in ());
		}
	}
	return m_prime.ptr ();
	//#UC END# *47C2A4670007*
}

GblPrime::PrimeXMLSave* ApplicationHelper::get_cached_prime_xml_save () const {
	//#UC START# *47C695540167*
	if (CORBA::is_nil (m_prime_xml_save.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_prime_xml_save_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_prime_xml_save.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_PRIME_XML_SAVE);
			m_prime_xml_save = GblPrime::PrimeXMLSave::_narrow (object.in ());
		}
	}
	return m_prime_xml_save.ptr ();

	//#UC END# *47C695540167*
}

GslSecurity::PropertiesManager* ApplicationHelper::get_cached_property_manager () const {
	//#UC START# *4AC4AB0C01BC*
	if (CORBA::is_nil (m_property_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_property_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_property_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_SECURITY_PROPERTIES);
			m_property_manager = GslSecurity::PropertiesManager::_narrow (object);
		}
	}
	return m_property_manager.ptr ();
	//#UC END# *4AC4AB0C01BC*
}

GblRemoteDocumentSupport::RemoteDocumentSupport* ApplicationHelper::get_cached_remote_document_support () const {
	//#UC START# *4BD5566102F9*
	if (CORBA::is_nil (m_remote_support.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_remote_support_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_remote_support.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_REMOTE_DOCUMENT_SUPPORT);
			m_remote_support = GblRemoteDocumentSupport::RemoteDocumentSupport::_narrow (object.in ());
		}
	}
	return m_remote_support.ptr ();
	//#UC END# *4BD5566102F9*
}

GblPilot::SearchManager* ApplicationHelper::get_cached_search_manager () const {
	//#UC START# *460BA7220280*
	if (CORBA::is_nil (m_search_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_search_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_search_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_SEARCH_MANAGER);
			m_search_manager = GblPilot::SearchManager::_narrow (object);
		}
	}
	return m_search_manager.ptr ();
	//#UC END# *460BA7220280*
}

GblSettings::Settings* ApplicationHelper::get_cached_settings () const {
	//#UC START# *460B94F80232*
	if (CORBA::is_nil (m_settings.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_settings_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_settings.in ())) {
			m_settings = this->get_cached_settings_manager ()->get_settings ();
		}
	}
	return m_settings.ptr ();
	//#UC END# *460B94F80232*
}

GblSettings::SettingsManager* ApplicationHelper::get_cached_settings_manager () const {
	//#UC START# *460B95AC03D8*
	if (CORBA::is_nil (m_settings_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_settings_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_settings_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_SETTINGS_MANAGER);
			m_settings_manager = GblSettings::SettingsManager::_narrow (object.in ());
		}
	}
	return m_settings_manager.ptr ();
	//#UC END# *460B95AC03D8*
}

GblPilot::TreeFactory* ApplicationHelper::get_cached_tree_factory () const {
	//#UC START# *4ABB429C0210*
	if (CORBA::is_nil (m_tree_factory.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_settings_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_tree_factory.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_TREE_FACTORY);
			m_tree_factory = GblPilot::TreeFactory::_narrow (object.in ());
		}
	}
	return m_tree_factory.ptr ();
	//#UC END# *4ABB429C0210*
}

GblUnderControl::UnderControlMng* ApplicationHelper::get_cached_under_control_manager () const {
	//#UC START# *460B92A701F4*
	if (CORBA::is_nil (m_under_control_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_under_control_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_under_control_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_UNDERCONTROL_MNG);
			m_under_control_manager = GblUnderControl::UnderControlMng::_narrow (object.in ());
		}
	}
	return m_under_control_manager.ptr ();
	//#UC END# *460B92A701F4*
}

GblUserJournal::UserJournal* ApplicationHelper::get_cached_user_journal () const {
	//#UC START# *4A80371200CE*
	if (CORBA::is_nil (m_user_journal.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_user_journal_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_user_journal.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_USER_JOURNAL);
			m_user_journal = GblUserJournal::UserJournal::_narrow (object.in ());
		}
	}
	return m_user_journal.ptr ();
	//#UC END# *4A80371200CE*
}

GslUserManager::UserManager* ApplicationHelper::get_cached_user_manager () const {
	//#UC START# *460B91AE00DA*
	if (CORBA::is_nil (m_user_manager.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_user_manager_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_user_manager.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_USER_MANAGER);
			m_user_manager = GslUserManager::UserManager::_narrow (object);
		}
	}
	return m_user_manager.ptr ();
	//#UC END# *460B91AE00DA*
}

GblXMLSave::XMLSave* ApplicationHelper::get_cached_xml_save () const {
	//#UC START# *4682713102DE*
	if (CORBA::is_nil (m_xml_save.in ())) {
		ACE_GUARD_THROW_EX (ACE_SYNCH_MUTEX, _local_guard, m_xml_save_mutex, CORBA::INTERNAL ());
		if (CORBA::is_nil (m_xml_save.in ())) {
			CORBA::Object_var object = this->server_facade ().get_server_interface (Defines::FN_XML_SAVE);
			m_xml_save = GblXMLSave::XMLSave::_narrow (object.in ());
		}
	}
	return m_xml_save.ptr ();
	//#UC END# *4682713102DE*
}

void ApplicationHelper::init (const ServerFacade* server_facade) {
	//#UC START# *4746FE3B0046*
	m_server_facade	= Core::IObject::_duplicate (server_facade);
	//#UC END# *4746FE3B0046*
}

bool ApplicationHelper::is_configurations_exist () const {
	//#UC START# *460BA70A0157*
	return (this->get_cached_settings_manager ()->is_configurations_exist () != CORBA::Boolean (0));
	//#UC END# *460BA70A0157*
}

const ServerFacade& ApplicationHelper::server_facade () const {
	//#UC START# *474705300058*
	GDS_ASSERT (!m_server_facade.is_nil ());	
	return *m_server_facade;
	//#UC END# *474705300058*
}

// Заставляем NotifyManager слушать нотификации только для меня
void ApplicationHelper::start_listen_for_me () {
	//#UC START# *460CD7A6038A*
	NotifyManagerFactory::make ().listen_only_for_me ();
	//#UC END# *460CD7A6038A*
}

// Прекратить слушать нотификации для меня
void ApplicationHelper::stop_listen_for_me () {
	//#UC START# *460CD7D402FD*
	NotifyManagerFactory::make ().stop_listen_me ();
	//#UC END# *460CD7D402FD*
}

ACE_Thread_Manager* ApplicationHelper::thr_mgr () const {
	//#UC START# *460BA6F801D4*
	return ACE_Thread_Manager::instance ();
	//#UC END# *460BA6F801D4*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

GCD::Uid ApplicationHelper::get_uid () const {
	//#UC START# *4AEE9F4A02BF_GET_ACCESSOR*
	return m_uid;
	//#UC END# *4AEE9F4A02BF_GET_ACCESSOR*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

