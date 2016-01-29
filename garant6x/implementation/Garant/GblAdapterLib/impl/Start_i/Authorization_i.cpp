////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Authorization_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Business/GblLogging/Home/Client.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/SessionHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"

//#UC START# *46092234033C_CUSTOM_INCLUDES*
#include "garantServer/src/Global/Defines/Common/XMLDef.h"
//#UC END# *46092234033C_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *46092234033C*
//#UC END# *46092234033C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Authorization_i::Authorization_i ()
//#UC START# *45EEE3D303C8_4609270F03C8_46092234033C_BASE_INIT*
	: m_need_logout (false)
	, m_need_full_backup_after_logout (false)
	, m_email (GCI::IO::StringFactory::make (""))
	, m_phone (GCI::IO::StringFactory::make (""))
	, m_has_session (false)
//#UC END# *45EEE3D303C8_4609270F03C8_46092234033C_BASE_INIT*
{
	//#UC START# *45EEE3D303C8_4609270F03C8_46092234033C_BODY*
	CORBA::Boolean available = ApplicationHelper::instance ()->get_cached_user_manager ()->is_public_login_available ();
	if (!available) {
		throw XMLImportRunning ();
	}
	//#UC END# *45EEE3D303C8_4609270F03C8_46092234033C_BODY*
}

Authorization_i::~Authorization_i () {
	//#UC START# *46092234033C_DESTR_BODY*
	try {
		if (m_need_logout) {
			this->logout ();
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *46092234033C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Authorization_i::guest_login_i () const {
	//#UC START# *4609286002DE*
	this->pre_login ();
	try {
		GCD::ObjectIDList blocks;
		ApplicationHelper::instance ()->get_cached_user_manager ()->guest_login ("", blocks);
		// Пишем в лог информацию об ОС клиента
		GblLogging::add_system_info (GblLogging::LE_CLIENT_SYSTEM_INFO);
		// Пишем в лог данные по настройке бидира
		GblLogging::add_bidir_info (GblLogging::LE_CLIENT_BIDIR);
		
		SessionHelper::instance()->set_is_session_active(true);
	} catch (GslUserManager::NoMoreConnections&) {
		throw NoMoreConnections ();
	} catch (GslUserManager::LicenceViolation&) {
		throw LicenceViolation ();
	} catch (GslUserManager::TrialPeriodExpired&) {
		throw TrialPeriodExpired ();
	} catch (GCD::XMLImportRunning&) {
		throw XMLImportRunning ();
	} catch (GslUserManager::ShutdownInited&) {
		throw ShutdownInited ();
	} catch (...) {
		throw; // we do not know what happened, but something is wrong on the CORBA system level
	}
	this->post_login ();
	//#UC END# *4609286002DE*
}

void Authorization_i::login_i (const char* login, const char* password) const {
	//#UC START# *460927AC002E*
	this->pre_login ();
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->login (login, password);
		// Пишем в лог информацию об ОС клиента
		GblLogging::add_system_info (GblLogging::LE_CLIENT_SYSTEM_INFO);
		// Пишем в лог данные по настройке бидира
		GblLogging::add_bidir_info (GblLogging::LE_CLIENT_BIDIR);
		SessionHelper::instance()->set_is_session_active (true);
	} catch (GslUserManager::LoginDisabled&) {
		throw AccountDisabled ();
	} catch (GslUserManager::LoginBlocked&) {
		throw AccountDisabled ();
	} catch (GslUserManager::LoginDuplicate&) {
		throw AlreadyLogged ();
	} catch (GslUserManager::NoMoreConnections&) {
		throw NoMoreConnections ();
	} catch (GslUserManager::LicenceViolation&) {
		throw LicenceViolation ();
	} catch (GslUserManager::TrialPeriodExpired&) {
		throw TrialPeriodExpired ();
	} catch (GslUserManager::LoginFailed&) {
		throw WrongAuthentication ();
	} catch (GCD::XMLImportRunning&) {
		throw XMLImportRunning ();
	} catch (GslUserManager::ShutdownInited&) {
		throw ShutdownInited ();
	} catch (...) {
		throw; // we do not know what happened, but something is wrong on the CORBA system level
	}
	this->post_login ();
	//#UC END# *460927AC002E*
}

GCD::Uid Authorization_i::logout_i () const {
	//#UC START# *4E23D97902F2*
	ApplicationHelper::instance ()->stop_listen_for_me ();

	GCD::Uid uid = ApplicationHelper::instance ()->get_cached_current_user_id ();

	// сбрасываем незаписанные настройки на сервер
	ConfigurationManagerFactory::make ()->logout ();

	ApplicationHelper::instance ()->get_cached_user_manager ()->logout_current ();
	SessionHelper::instance()->set_is_session_active (false);
	m_need_logout = false;
	ApplicationHelper::instance ()->clear_cache ();

	// информируем чат об окончании работы
	ChatInterfaces::ChatManagerFactory::make ().logout ();

	return uid;
	//#UC END# *4E23D97902F2*
}

void Authorization_i::post_login () const {
	//#UC START# *460928770271*
	ApplicationHelper::instance ()->start_listen_for_me  ();
	m_need_logout = true;
	//#UC END# *460928770271*
}

void Authorization_i::pre_login () const {
	//#UC START# *460A2D0E037A*
	ApplicationHelper::instance ()->get_cached_function_manager (); // Принудительная инициализация `function manager`
	//#UC END# *460A2D0E037A*
}

void Authorization_i::xml_backup (GCD::Uid uid) const {
	//#UC START# *4E23D9EE015C*
	if (m_need_full_backup_after_logout) {
		ApplicationHelper::instance ()->get_cached_xml_save ()->oneway_save (Defines::XT_BACKUP, "");
	} else {
		GDS_ASSERT (uid); // PARANOYA
		if (uid) {
			ApplicationHelper::instance ()->get_cached_xml_save ()->oneway_save_user (uid, Defines::XT_BACKUP, "");
		}
	}
	//#UC END# *4E23D9EE015C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Authorization
// Почта администратора
const GCI::IO::String& Authorization_i::get_administrator_email () const {
	//#UC START# *467006CB035C_46092234033C_GET*
	CORBA::String_var tmp = ApplicationHelper::instance ()->get_cached_function_manager ()->administrator_email ();	
	m_email->reset (tmp.in ());  
	return *(m_email.in ());
	//#UC END# *467006CB035C_46092234033C_GET*
}

GCI::IO::String& Authorization_i::get_administrator_email () {
	return const_cast<GCI::IO::String&>(((const Authorization_i*)this)->get_administrator_email ());
}

void Authorization_i::set_administrator_email (GCI::IO::String* administrator_email) {
	//#UC START# *467006CB035C_46092234033C_SET*
	ApplicationHelper::instance ()->get_cached_function_manager ()->administrator_email (administrator_email->get_data ());
	//#UC END# *467006CB035C_46092234033C_SET*
}

// implemented method from Authorization
// Телефон администратора
const GCI::IO::String& Authorization_i::get_administrator_phone () const {
	//#UC START# *467006E60158_46092234033C_GET*
	CORBA::String_var tmp = ApplicationHelper::instance ()->get_cached_function_manager ()->administrator_phone ();
	m_phone->reset (tmp.in ());  
	return *(m_phone.in ());
	//#UC END# *467006E60158_46092234033C_GET*
}

GCI::IO::String& Authorization_i::get_administrator_phone () {
	return const_cast<GCI::IO::String&>(((const Authorization_i*)this)->get_administrator_phone ());
}

void Authorization_i::set_administrator_phone (GCI::IO::String* administrator_phone) {
	//#UC START# *467006E60158_46092234033C_SET*
	ApplicationHelper::instance ()->get_cached_function_manager ()->administrator_phone (administrator_phone->get_data ());
	//#UC END# *467006E60158_46092234033C_SET*
}

// implemented method from Authorization
// Аналогично login но с регистрацией нового пользователя. email - адрес, на который в последствии
// может быть выслана информация о пользователе (логин, пароль)
void Authorization_i::autoregistration (
	const char* name
	, const char* login
	, const char* password
	, const char* email
) const /*throw (
	WrongAuthentication
	, NoMoreProfiles
	, LicenceViolation
	, XMLImportRunning
	, ShutdownInited
	, TrialPeriodExpired
	, NoMoreConnections
	, AutoregistrationDisabled
)*/ {
	//#UC START# *45EEE3D303D0_46092234033C*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->autoregistration (name, login, password, email);
		ApplicationHelper::instance ()->get_cached_xml_save ()->oneway_save (Defines::XT_BACKUP, "");
	} catch (GslUserManager::LoginDuplicate&) {
		throw LoginDuplicate ();
	} catch (GslUserManager::LicenceViolation&) {
		throw NoMoreProfiles ();
	} catch (GslUserManager::ShutdownInited&) {
		throw ShutdownInited ();
	} catch (GslUserManager::TrialPeriodExpired&) {
		throw TrialPeriodExpired ();
	} catch (GCD::InvalidArgs&) {
		throw WrongAuthentication ();
	} catch (GCD::XMLImportRunning&) {
		throw XMLImportRunning ();
	}
	this->login_i (login, password);
	//#UC END# *45EEE3D303D0_46092234033C*
}

// implemented method from Authorization
// статус авторегистрации
bool Authorization_i::get_autoregistration_status () const {
	//#UC START# *4639B43901BF_46092234033C_GET*
	return ApplicationHelper::instance ()->get_cached_user_manager ()->get_autoregistration_status ();
	//#UC END# *4639B43901BF_46092234033C_GET*
}

void Authorization_i::set_autoregistration_status (bool autoregistration_status)
	/*throw (AccessDenied)*/
{
	//#UC START# *4639B43901BF_46092234033C_SET*
	try {
		ApplicationHelper::instance ()->get_cached_user_manager ()->set_autoregistration_status (autoregistration_status);
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	}
	//#UC END# *4639B43901BF_46092234033C_SET*
}

// implemented method from Authorization
// Начало работы с системой пользователя-гостя. При успешном завершении подключается к базе,
// прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon.
void Authorization_i::guest_login () const /*throw (NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections)*/ {
	//#UC START# *45EEE3D303CD_46092234033C*
	this->guest_login_i ();
	//#UC END# *45EEE3D303CD_46092234033C*
}

// implemented method from Authorization
// возвращает true если сервер доступен, false иначе
bool Authorization_i::is_server_alive () const {
	//#UC START# *45EEE3D303D9_46092234033C*
	try {
		return !ApplicationHelper::instance ()->get_cached_function_manager()->_non_existent();
	} catch (...) {
		return false;
	}
	//#UC END# *45EEE3D303D9_46092234033C*
}

// implemented method from Authorization
// Начало работы с системой. При успешном завершении подключается к базе, прописанной в параметрах,
// как база по умолчанию и возвращает интерфейс ICommon.
void Authorization_i::login (
	const char* login
	, const char* password
) const /*throw (
	WrongAuthentication
	, NoMoreProfiles
	, XMLImportRunning
	, ShutdownInited
	, TrialPeriodExpired
	, AlreadyLogged
	, AccountDisabled
	, NoMoreConnections
)*/ {
	//#UC START# *45EEE3D303C9_46092234033C*
	this->login_i (login, password);

	// xxx: хак, по хорошему нужно завести специальный метод на сервере, но так как
	// у нас всё равно в куче мест есть проверка на чудесный логин, пока так.
	m_need_full_backup_after_logout = 
		login 
		&& (sizeof ("ADMIN") == ACE_OS::strlen (login) + 1) 
		&& !ACE_OS::strncmp ("ADMIN", login, sizeof ("ADMIN"));
	//#UC END# *45EEE3D303C9_46092234033C*
}

// implemented method from Authorization
// Окончание работы с системой.
void Authorization_i::logout () const {
	//#UC START# *45EEE3D303CF_46092234033C*
	GCD::Uid uid = this->logout_i ();
	this->xml_backup (uid);
	//#UC END# *45EEE3D303CF_46092234033C*
}

// implemented method from Authorization
// K274827650
void Authorization_i::logout_without_xml_backup () const {
	//#UC START# *4E23D8250328_46092234033C*
	this->logout_i ();
	//#UC END# *4E23D8250328_46092234033C*
}

// implemented method from Authorization
// Ошибка защиты.
long Authorization_i::get_protection_error () const {
	//#UC START# *45EEE3D303DB_46092234033C_GET*
	return ApplicationHelper::instance ()->get_cached_user_manager ()->get_protection_error ();
	//#UC END# *45EEE3D303DB_46092234033C_GET*
}

// implemented method from Authorization
// Колличество оставшихся триальных дней. Если `== 0` - триальный период истек; если `< 0`
// триальный период не установлен.
long Authorization_i::get_rest_trial_days_count () const {
	//#UC START# *45EEE3D303DC_46092234033C_GET*
	return ApplicationHelper::instance ()->get_cached_user_manager ()->get_rest_trial_days_count ();
	//#UC END# *45EEE3D303DC_46092234033C_GET*
}

// implemented method from Authorization
// Проверяет наличие указанного адреса в базе. Если адрес найден,  высылает на него информацию о
// пользователе.
void Authorization_i::send_user_info_by_email (
	const char* email
) const /*throw (
	SMTPServerAddressNotDefined
	, SMTPServerNotFound
	, UserNotFound
	, BadSMTPReply
	, SMTPAuthorizationFailed
)*/ {
	//#UC START# *45EEE3D303D6_46092234033C*
	try {
		ApplicationHelper::instance ()->get_cached_function_manager ()->send_password (email);
	} catch (GslUserManager::SMTPServerAddressNotDefined&) {
		throw SMTPServerAddressNotDefined ();
	} catch (GslUserManager::SMTPServerNotFound&) {
		throw SMTPServerNotFound ();
	} catch (GslUserManager::BadSMTPReply&) {
		throw BadSMTPReply ();
	} catch (GslUserManager::UserNotFound&) {
		throw UserNotFound ();
	} catch (GslUserManager::SMTPAuthorizationFailed&) {
		throw SMTPAuthorizationFailed ();
	}
	//#UC END# *45EEE3D303D6_46092234033C*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

