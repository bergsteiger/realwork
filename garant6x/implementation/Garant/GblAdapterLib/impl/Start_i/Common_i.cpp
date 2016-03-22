////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Common_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FolderNotifier_i.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Start_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"

//#UC START# *460A435B0157_CUSTOM_INCLUDES*
#include "ace/Process.h"

#include "shared/Core/Params/Params.h"
#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *460A435B0157_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *460A435B0157*
//#UC END# *460A435B0157*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Common_i::Common_i ()
//#UC START# *45EEE473005D_460A43770251_460A435B0157_BASE_INIT*
	: m_is_explanatory_dictionary_exist (boost::indeterminate)
	, m_is_pharm_exist (boost::indeterminate)
	, m_is_internal (boost::indeterminate)
	, m_folder_notifier (0)
	, m_is_trimmed_publish_source_exists (boost::indeterminate)
	, m_erase_inactive_users (boost::indeterminate)
//#UC END# *45EEE473005D_460A43770251_460A435B0157_BASE_INIT*
{
	//#UC START# *45EEE473005D_460A43770251_460A435B0157_BODY*
	//#UC END# *45EEE473005D_460A43770251_460A435B0157_BODY*
}

Common_i::~Common_i () {
	//#UC START# *460A435B0157_DESTR_BODY*
	delete m_folder_notifier;
	m_folder_notifier = 0;
	//#UC END# *460A435B0157_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// xml restore method for integration
Core::IObject* Common_i::get_bookmark_by_xml (XercesHelpers::DOMNodeEx& root_node) const {
	//#UC START# *460A4504001F*
	static const char* const type_sub = "SUB";
	static const char* const type_para = "PARA";

	GblPilot::ListEntryInfo list_entry_info;
	XercesHelpers::XMLStr type (root_node.get_attribute ("point_type"));
	const char* type_data = type.in ();
	if (
			(std::strlen (type_sub) == std::strlen (type_data))
			&& !std::memcmp (type_sub, type_data, std::strlen (type_sub))
	) {
		list_entry_info.para = 0;
		list_entry_info.sub = root_node.get_long_attribute ("point");
	} else if (
			(std::strlen (type_para) == std::strlen (type_data))
			&& !std::memcmp (type_para, type_data, std::strlen (type_para))
	) {
		list_entry_info.sub = 0;
		list_entry_info.para = root_node.get_long_attribute ("point");
	} else {
		LOG_E (("%s: can't get point type", GDS_CURRENT_FUNCTION));
		throw InvalidXMLType ();
	}
	long doc_id = root_node.get_long_attribute ("id");
	if (!doc_id) {
		LOG_E (("%s: can't get document number", GDS_CURRENT_FUNCTION));
		throw InvalidXMLType ();
	} else {
		GCD::PID pid;
		pid.m_class_id = Defines::CI_TOPIC;
		pid.m_object_id = doc_id;
		try {
			list_entry_info.doc = ApplicationHelper::instance ()->get_cached_function_manager ()->get_document (pid);
		} catch (::GCD::CanNotFindData&) {
			LOG_E (("%s: error while getting document from server (CanNotFindData)", GDS_CURRENT_FUNCTION));
			throw CanNotFindData ();
		} catch (::GCD::StorageInternalError&) {
			LOG_E (("%s: error while getting document from server (StorageInternalError)", GDS_CURRENT_FUNCTION));
			throw CanNotFindData ();
		} catch (CORBA::Exception& ex) {
			LOG_CEXD ((ex, "%s: error while getting document from server", GDS_CURRENT_FUNCTION));
			throw CanNotFindData ();
		}
	}
	return ListEntryInfoFactory::make (list_entry_info);
	//#UC END# *460A4504001F*
}

FolderNotifier_i* Common_i::get_cached_folder_notifier () const {
	//#UC START# *469775F5006D*
	return m_folder_notifier;
	//#UC END# *469775F5006D*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void Common_i::clear_cache () {
	//#UC START# *45702DA9037A_460A435B0157*
	m_is_explanatory_dictionary_exist = boost::indeterminate;
	m_is_internal = boost::indeterminate;
	m_is_pharm_exist = boost::indeterminate;
	m_base_date = Date();
	m_is_trimmed_publish_source_exists = boost::indeterminate;
	//#UC END# *45702DA9037A_460A435B0157*
}

// implemented method from Common
// показывать ли помощь при первом запуске после инсталяции.
bool Common_i::auto_show_help () const {
	//#UC START# *46F22CA50148_460A435B0157*
	return
		Core::ParamManagerFactory::get ().get_long (GblAdapterLib::AUTO_SHOW_HELP_OPTION, 1) ? true : false;
	//#UC END# *46F22CA50148_460A435B0157*
}

// implemented method from Common
const Date& Common_i::get_base_date () const {
	//#UC START# *460A6A50031C_460A435B0157_GET*
	this->check_update_and_clear_cache ();
	if (m_base_date == Date()) {
		GblPilotDef::DocDate pilot_revision_date;
		pilot_revision_date = ApplicationHelper::instance ()->get_cached_function_manager ()->get_base_revision ();

		m_base_date.day = pilot_revision_date.m_day;
		m_base_date.month = pilot_revision_date.m_mounth;
		m_base_date.year = pilot_revision_date.m_year;
	}
	return m_base_date;
	//#UC END# *460A6A50031C_460A435B0157_GET*
}

// implemented method from Common
// проверка является ли база с лицензионными настройками - "для внутреннего использования"
bool Common_i::check_internal () const {
	//#UC START# *45EEE4730077_460A435B0157*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_is_internal)) {
		bool is_internal = false;
		try {
			GCD::LicenseSettings_var licence_settings = ApplicationHelper::instance ()->get_cached_user_manager ()->get_licence_info ();
			is_internal = (licence_settings->m_licence_type == GCD::lt_InternalUse);
			m_is_internal = is_internal;
		} catch (...) {
			LOG_E (("%s: can't get internal is_internal flag", GDS_CURRENT_FUNCTION));
			m_is_internal = false;
		}
	}
	return m_is_internal;
	//#UC END# *45EEE4730077_460A435B0157*
}

// implemented method from Common
// Создать очередь обработки папочных нотификаций
void Common_i::create_folder_notification_queue () {
	//#UC START# *49DEFB6403B8_460A435B0157*
	if (m_folder_notifier != 0) {
		delete m_folder_notifier;
		m_folder_notifier = 0;
	}
	m_folder_notifier = new FolderNotifier_i ();
	//#UC END# *49DEFB6403B8_460A435B0157*
}

// implemented method from Common
// Получить баннер
Banner* Common_i::get_banner () const /*throw (CanNotFindData)*/ {
	//#UC START# *4ACC7293034A_460A435B0157*
	return BannerFactory::make ();
	//#UC END# *4ACC7293034A_460A435B0157*
}

// implemented method from Common
// Тип базы
BaseType Common_i::get_base_type () const {
	//#UC START# *494B8EB70150_460A435B0157*
	return BaseTypeTypeConvertorSingleton::instance ()->get (
		ApplicationHelper::instance ()->get_cached_function_manager ()->get_base_type ()
	);
	//#UC END# *494B8EB70150_460A435B0157*
}

// implemented method from Common
GCI::IO::String* Common_i::get_complect_name () const {
	//#UC START# *460A4B1C008C_460A435B0157*
	CORBA::String_var name = ApplicationHelper::instance ()->get_cached_function_manager ()->get_complect_name ();
	return GCI::IO::StringFactory::make (name.in ());
	//#UC END# *460A4B1C008C_460A435B0157*
}

// implemented method from Common
// Возвращает документ (Document) по заданному внутреннему ("гарантовскому") номеру.
bool Common_i::get_document_on_number (long number, Document*& document, MissingInfo*& missing_info) const {
	//#UC START# *45EEE473005E_460A435B0157*
	GCD::PID pid;
	pid.m_object_id = number;
	pid.m_class_id = Defines::CI_TOPIC;

	document = 	DocumentFactory::make (pid, true /* may be redaction*/, 0, DocumentFactoryKeyHelper::PID_to_key (pid));
	bool ret = document->is_alive ();
	try {
		missing_info = ret ? 0 : MissingInfoFactory::make (pid);
	} catch (...) {
		// Все загасим
	}
	return ret;
	//#UC END# *45EEE473005E_460A435B0157*
}

// implemented method from Common
// получить зашифрованный идентификатор комплекта
GCI::IO::String* Common_i::get_encrypted_complect_id () const {
	//#UC START# *51ADE9F9011C_460A435B0157*
	CORBA::String_var encrypted_complect_id = 
		ApplicationHelper::instance ()->get_cached_function_manager ()->get_encrypted_complect_id ();
	return GCI::IO::StringFactory::make (encrypted_complect_id.in ());
	//#UC END# *51ADE9F9011C_460A435B0157*
}

// implemented method from Common
ExternalObject* Common_i::get_picture (long id) const /*throw (CanNotFindData)*/ {
	//#UC START# *4F3CE8840273_460A435B0157*
	
	struct AutoPersistentObj {
		AutoPersistentObj (GCD::PersistentObj* object) : object (object) {
		}
		~AutoPersistentObj () {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (object.in ());
		}
		GCD::PersistentObj_var object;
	};
	
	try {
		GCD::PID pid;
		pid.m_class_id = Defines::CI_BLOB;
		pid.m_object_id = id;

		AutoPersistentObj persistent_object (
			ApplicationHelper::instance ()->get_cached_function_manager ()->get_object_by_id (pid)
		);
		
		GblPilot::InternalObj_var internal_object (GblPilot::InternalObj::_narrow (persistent_object.object));
		return ExternalObjectFactory::make (internal_object.in ());

	} catch (CORBA::BAD_OPERATION&) {
	} catch (GCD::StorageInternalError&) {
	} catch (GCD::DocumentNotFound&) {
	} catch (GCD::CanNotFindData&) {
	}
	
	throw CanNotFindData ();
	//#UC END# *4F3CE8840273_460A435B0157*
}

// implemented method from Common
// получить тип установленного продукта
ProductType Common_i::get_product_type () const {
	//#UC START# *4715FD8D01C5_460A435B0157*
	GblPilot::VersionType type = ApplicationHelper::instance ()->get_cached_function_manager ()->get_product_info ();
	switch (type) {
		case GblPilot::VT_CLIENTSERVER:
			return PT_CLIENTSERVER;
		case GblPilot::VT_DESKTOP:
			return PT_DESKTOP;
		case GblPilot::VT_FILESERVER:
			return PT_FILESERVER;
		case GblPilot::VT_DVD:
			return PT_DVD;
		case GblPilot::VT_MOBILE:
			return PT_MOBILE;
		case GblPilot::VT_SUPERMOBILE:
			return PT_SUPERMOBILE;
		case GblPilot::VT_UNKNOWN:
			return PT_UNKNOWN;
	}

	GDS_ASSERT (false  && "unknown value for VersionType from get_product_type");
	return PT_UNKNOWN;
	//#UC END# *4715FD8D01C5_460A435B0157*
}

// implemented method from Common
// словарь для скриптов (К271754146)
GCI::IO::Stream* Common_i::get_scripts_system_dictionary () const {
	//#UC START# *4E0C248F0243_460A435B0157*
	GCD::SeqOctet_var system_dictionary (
		ApplicationHelper::instance ()->get_cached_function_manager()->get_scripts_system_dictionary ()
	);

	return MemoryStreamFactory::make (system_dictionary.in (), true);
	//#UC END# *4E0C248F0243_460A435B0157*
}

// implemented method from Common
// Получить менеджер настроек
SettingsManager* Common_i::get_settings_manager () const {
	//#UC START# *47A84BF100A3_460A435B0157*
	return SettingsManagerFactory::make ();
	//#UC END# *47A84BF100A3_460A435B0157*
}

// implemented method from Common
// Получить сплеш
SplashScreen* Common_i::get_splash_screen (bool is_start, short x, short y, bool flash_available) const {
	//#UC START# *47A84A470118_460A435B0157*
	return SplashScreenFactory::make (is_start, x, y, flash_available);
	//#UC END# *47A84A470118_460A435B0157*
}

// implemented method from Common
// доступен ли модуль ЭО.
bool Common_i::is_eo_enabled () const {
	//#UC START# *489AE01901E0_460A435B0157*
	return
		Core::ParamManagerFactory::get ().get_long (GblAdapterLib::EO_ENABLED, 1) ? true : false;
	//#UC END# *489AE01901E0_460A435B0157*
}

// implemented method from Common
// включена ли поддержка удаления пользователей, которые давно не пользовались системой
bool Common_i::is_erase_of_inactive_users_enabled () const {
	//#UC START# *4F547E5602BC_460A435B0157*
	if (boost::indeterminate (m_erase_inactive_users)) {
		m_erase_inactive_users = ApplicationHelper::instance ()->get_cached_function_manager ()->is_erase_of_inactive_enabled ();
	}
	return m_erase_inactive_users;
	//#UC END# *4F547E5602BC_460A435B0157*
}

// implemented method from Common
// Проверяет существует (доступен) ли в системе Толковый словарь.
// Возвращает true в случае, если толковый словарь существует.
bool Common_i::is_explanatory_dictionary_exist () const {
	//#UC START# *45EEE4730067_460A435B0157*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_is_explanatory_dictionary_exist)) {
		m_is_explanatory_dictionary_exist = ApplicationHelper::instance ()->get_cached_search_manager ()->attribute_exists (GblPilotQueryDef::AT_DICTIONARY);
	}
	return m_is_explanatory_dictionary_exist;
	//#UC END# *45EEE4730067_460A435B0157*
}

// implemented method from Common
bool Common_i::is_pharm_exist () const {
	//#UC START# *47D00A9402BF_460A435B0157*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_is_pharm_exist)) {
		m_is_pharm_exist = 
			ApplicationHelper::instance ()->get_cached_function_manager ()->is_pharm_exists ();	
	}

	return m_is_pharm_exist;
	//#UC END# *47D00A9402BF_460A435B0157*
}

// implemented method from Common
// Есть ли усеченный индекс Источник опубликования
bool Common_i::is_trimmed_publish_source_exists () const {
	//#UC START# *4B4C52210165_460A435B0157*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_is_trimmed_publish_source_exists)) {
		m_is_trimmed_publish_source_exists = 
			ApplicationHelper::instance ()->get_cached_function_manager ()->is_trimmed_publish_source_exists ();	
	}
	
	return m_is_trimmed_publish_source_exists;
	//#UC END# *4B4C52210165_460A435B0157*
}

// implemented method from Common
// Лицензионные ограничения на количество пользователей
const LicenseRestrictions Common_i::get_license_restrictions () const {
	//#UC START# *4A1D2E8202E3_460A435B0157_GET*
	GCD::LicenseSettings_var licence_settings = ApplicationHelper::instance ()->get_cached_user_manager ()->get_licence_info ();
	LicenseRestrictions ret;
	ret.users = licence_settings->m_max_user_count;
	ret.permanent_users = licence_settings->m_max_perm_count;
	return ret;
	//#UC END# *4A1D2E8202E3_460A435B0157_GET*
}

// implemented method from Common
// показывает рисунки для заданного топика (функциональность внутренней версии)
void Common_i::show_pictures_on_number (
	long number
) const /*throw (
	WorkingParamsNotFound
	, ExternalApplicationError
)*/ {
	//#UC START# *45EEE4730078_460A435B0157*
	if (!Core::ParamManagerFactory::get ().is_exist (PATH_TO_PICTURES)
		|| !Core::ParamManagerFactory::get ().is_exist (PATH_TO_EXECUTABLE)
	) { 
		throw WorkingParamsNotFound ();
	}
	std::string path = Core::ParamManagerFactory::get ().get_string (PATH_TO_PICTURES);
	std::string executable = Core::ParamManagerFactory::get ().get_string (PATH_TO_EXECUTABLE);

	ACE_Process_Options options;
	options.creation_flags (CREATE_DEFAULT_ERROR_MODE | DETACHED_PROCESS | NORMAL_PRIORITY_CLASS);
	options.command_line ("\"%s\" \"%s\" %d", executable.c_str (), path.c_str (), number);
	options.handle_inheritence (false);
	ACE_Process picture_display;
	if (picture_display.spawn (options) < 0) {
		throw ExternalApplicationError ();
	}
	// TODO разобраться почему для запуска нового процесса ждём окончания выполнения данной функции
	//picture_display.wait ();
	//if (picture_display.exit_code ()) {
	//	throw ExternalApplicationError ();
	//}
	//#UC END# *45EEE4730078_460A435B0157*
}

// implemented method from Common
// Установить нотификацию изменения папок.
void Common_i::start_processing_folder_notification (ExternalFoldersChangeNotifier* notifier) {
	//#UC START# *45EEE4730065_460A435B0157*
	GDS_ASSERT (m_folder_notifier != 0);
	m_folder_notifier->set_external_folders_change_notifier (notifier);
	//#UC END# *45EEE4730065_460A435B0157*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

