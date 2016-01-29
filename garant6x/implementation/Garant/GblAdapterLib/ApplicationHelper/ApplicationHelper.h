////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::ApplicationHelper::ApplicationHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_APPLICATIONHELPER_H__
#define __GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_APPLICATIONHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "ace/Thread_Manager.h"
#include "garantServer/src/Business/GblConsultingClient/GblConsultingClientC.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Business/GblUnderControl/GblUnderControlC.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garantServer/src/Business/GblSettings/GblSettingsC.h"
#include "garantServer/src/Services/GslSecurity/GslSecurityC.h"
#include "garantServer/src/Business/GblLogging/GblLoggingC.h"
#include "garantServer/src/Business/GblIntegration/GblIntegrationC.h"
#include "garantServer/src/Business/GblXMLSave/GblXMLSaveC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ServerFacade.h"
#include "garantServer/src/Business/GblPrime/Home/Client.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalC.h"
#include "garantServer/src/Business/GblRemoteDocumentSupport/GblRemoteDocumentSupportC.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"

//#UC START# *460A6EF8024B_CUSTOM_INCLUDES*
#include "ace/Synch.h"
//#UC END# *460A6EF8024B_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class ApplicationHelper {
	SET_OBJECT_COUNTER (ApplicationHelper)

	// singleton declaration
	typedef ACE_Singleton <ApplicationHelper, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ApplicationHelper, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static ApplicationHelper* instance () {
		return Singleton::instance();
	}

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	struct BaseId {
		unsigned long stamp;
		//#UC START# *460A80090380*
		BaseId () : stamp (0) {};
		//#UC END# *460A80090380*
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ApplicationHelper ();

	virtual ~ApplicationHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Очистка кешированных серверных объектов
	virtual void clear_cache () const;

	virtual void clear_cache_and_regenerate_base_id ();

	virtual bool compare_and_update_base_id (BaseId& base_id) const;

	// Получить баннер с сервера
	virtual GblPilot::BannerManager* get_cached_banner_manager () const;

	virtual GblConsultingClient::ConsultationManager* get_cached_consultation_manager () const;

	virtual GTree::ContextFilter* get_cached_context_filter () const;

	virtual GblPrime::ContractForm* get_cached_contract_form () const;

	// возвращает идентификатор текущего пользователя
	virtual GCD::Uid get_cached_current_user_id () const;

	virtual GblRemoteDocumentSupport::DecisionsArchiveSupport* get_cached_decisions_archive_support () const;

	virtual GblPilot::DocumentTypeResolver* get_cached_document_type_resolver () const;

	virtual GblFilters::FiltersManager* get_cached_filters_manager () const;

	virtual GblFolders::Folders* get_cached_folders () const;

	virtual GblPilot::FunctionMng* get_cached_function_manager () const;

	virtual GslUserManager::GroupManager* get_cached_group_manager () const;

	virtual GblIntegration::Integration* get_cached_integration () const;

	virtual GCD::LifeCycleManager* get_cached_life_cycle_manager () const;

	virtual GblPilot::LinkManager* get_cached_link_manager () const;

	virtual GblLogging::LoggingManager* get_cached_logging_manager () const;

	virtual GblPilot::MainMenu* get_cached_main_menu () const;

	virtual GblPrime::Prime* get_cached_prime () const;

	virtual GblPrime::PrimeXMLSave* get_cached_prime_xml_save () const;

	virtual GslSecurity::PropertiesManager* get_cached_property_manager () const;

	virtual GblRemoteDocumentSupport::RemoteDocumentSupport* get_cached_remote_document_support () const;

	virtual GblPilot::SearchManager* get_cached_search_manager () const;

	virtual GblSettings::Settings* get_cached_settings () const;

	virtual GblSettings::SettingsManager* get_cached_settings_manager () const;

	virtual GblPilot::TreeFactory* get_cached_tree_factory () const;

	virtual GblUnderControl::UnderControlMng* get_cached_under_control_manager () const;

	virtual GblUserJournal::UserJournal* get_cached_user_journal () const;

	virtual GslUserManager::UserManager* get_cached_user_manager () const;

	virtual GblXMLSave::XMLSave* get_cached_xml_save () const;

	virtual void init (const ServerFacade* server_facade);

	virtual bool is_configurations_exist () const;

	// Заставляем NotifyManager слушать нотификации только для меня
	virtual void start_listen_for_me ();

	// Прекратить слушать нотификации для меня
	virtual void stop_listen_for_me ();

protected:
	virtual ACE_Thread_Manager* thr_mgr () const;

private:
	virtual const ServerFacade& server_facade () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GblPilot::BannerManager_var m_banner_manager;

	mutable BaseId m_base_id;

	mutable GblConsultingClient::ConsultationManager_var m_consultation_manager;

	mutable GTree::ContextFilter_var m_context_filter;

	mutable GblPrime::ContractForm_var m_contract_form;

	mutable GblRemoteDocumentSupport::DecisionsArchiveSupport_var m_decisions_archive_support;

	mutable GblPilot::DocumentTypeResolver_var m_document_type_resolver;

	mutable GblFilters::FiltersManager_var m_filters_manager;

	mutable GblFolders::Folders_var m_folders;

	mutable GblPilot::FunctionMng_var m_function_manager;

	mutable GslUserManager::GroupManager_var m_group_manager;

	mutable GblIntegration::Integration_var m_integration;

	mutable GCD::LifeCycleManager_var m_life_cycle_manager;

	mutable GblPilot::LinkManager_var m_link_manager;

	mutable GblLogging::LoggingManager_var m_logging_manager;

	mutable GblPilot::MainMenu_var m_main_menu;

	mutable GblPrime::Prime_var m_prime;

	mutable GblPrime::PrimeXMLSave_var m_prime_xml_save;

	mutable GslSecurity::PropertiesManager_var m_property_manager;

	mutable GblRemoteDocumentSupport::RemoteDocumentSupport_var m_remote_support;

	mutable GblPilot::SearchManager_var m_search_manager;

	ServerFacade_cvar m_server_facade;

	mutable GblSettings::Settings_var m_settings;

	mutable GblSettings::SettingsManager_var m_settings_manager;

	mutable GblPilot::TreeFactory_var m_tree_factory;

	// uid текущего пользователя
	mutable GCD::Uid m_uid;

	mutable GblUnderControl::UnderControlMng_var m_under_control_manager;

	// Журнал работы
	mutable GblUserJournal::UserJournal_var m_user_journal;

	mutable GslUserManager::UserManager_var m_user_manager;

	mutable GblXMLSave::XMLSave_var m_xml_save;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	GCD::Uid get_uid () const;

//#UC START# *460A6EF8024B*
	mutable ACE_SYNCH_MUTEX m_function_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_context_filter_mutex;
	mutable ACE_SYNCH_MUTEX m_property_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_contract_form_mutex;
	mutable ACE_SYNCH_MUTEX m_search_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_user_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_group_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_folders_mutex;
	mutable ACE_SYNCH_MUTEX m_under_control_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_settings_mutex;
	mutable ACE_SYNCH_MUTEX m_settings_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_life_cycle_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_consultation_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_logging_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_integration_mutex;
	mutable ACE_SYNCH_MUTEX m_xml_save_mutex;
	mutable ACE_SYNCH_MUTEX m_prime_mutex;
	mutable ACE_SYNCH_MUTEX m_prime_xml_save_mutex;
	mutable ACE_SYNCH_MUTEX m_user_journal_mutex;
	mutable ACE_SYNCH_MUTEX m_banner_manager_mutex;
	mutable ACE_SYNCH_MUTEX m_user_id_mutex;
	mutable ACE_SYNCH_MUTEX m_remote_support_mutex;
	mutable ACE_SYNCH_MUTEX m_filters_mutex;
	mutable ACE_SYNCH_MUTEX m_main_menu_mutex;
	mutable ACE_SYNCH_MUTEX m_decisions_archive_support_mutex;
	mutable ACE_SYNCH_MUTEX m_document_type_resolver_mutex;
	mutable ACE_SYNCH_MUTEX m_link_manager_mutex;
//#UC END# *460A6EF8024B*
}; // class ApplicationHelper

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_APPLICATIONHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

