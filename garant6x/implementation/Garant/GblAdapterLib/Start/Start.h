////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_H__
#define __GARANT6X_GBLADAPTERLIB_START_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// Возбуждается, когда не надено ни одного IP адреса для машины клиента (вероятные причины: нет
// активных сетевых соединений).
class IPAddressNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Отсутствует или неверная база.
class InvalidBase : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возбуждается в случае, когда по каким-то причинам сервер оказался недоступным.
class NoServer : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возбуждается, если в течении 10 секунд не пришел ответ от сервера ни на один из IP адрессов на
// машине-клиенте (вероятные причины: firewall блокирует `incoming connection` на порты, которые
// использует ACE/TAO при обратном вызове).
class BadNetworkConfig : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Не задан адрес SMTP сервера
class SMTPServerAddressNotDefined : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Приложение не может соединиться c SMTP сервером. Возможно была допущена ошибка в при вводе
// адреса сервера.
class SMTPServerNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Пользователь не найден
class UserNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ServerVersionNotValid : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Внутренняя ошибка сервера
class InternalServerError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Не найдены параметры, необходимые для работы приложения.
class WorkingParamsNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class BadSMTPReply : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class SettingsRestoreFails : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Ошибка при работе внешнего приложения
class ExternalApplicationError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class AlreadyLogged : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// параметры инишника для отображения картинок во внешнем приложении
static const char* PATH_TO_PICTURES = "-PathToPictures";
static const char* PATH_TO_EXECUTABLE = "-PathToPicturesExecutable";

// Разрядность
enum Capacity {
	C_32
	, C_64
};

// тип продукта
enum ProductType {
	PT_UNKNOWN
	, PT_DVD
	, PT_MOBILE
	, PT_FILESERVER
	, PT_DESKTOP
	, PT_CLIENTSERVER
	, PT_SUPERMOBILE
};

class AccountDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class NoMoreConnections : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Неудачная авторизация на почтовом сервере
class SMTPAuthorizationFailed : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// отсутствует морфоиндекс.
class MorphoNotExists : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Тип оболочки
enum BaseType {
	BT_UNKNOWN // Неизвестный тип (отсутствует data.org)
	, BT_TRIAL // Ознакомительная версия
	, BT_COMMERCIAL // Коммерческая база
	, BT_NON_COMMERCIAL // Не коммерческая база
	, BT_DEMO // Демоверсия
};

// ошибка в механизме gcm
class InternalApplicationError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// может быть брошено только на desktop версии - сигнализирует о битой базе пользовалетя (что-то из
// содержимого каталога settings)
class InvalidUserDatastore : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Authorization;
typedef ::Core::Var<Authorization> Authorization_var;
typedef ::Core::Var<const Authorization> Authorization_cvar;
// Интерфейс обеспечивает начальную авторизацию в системе, открытие выбранного комплекта данных,
// получение информации о комплекте.
class Authorization
	: virtual public ::Core::IObject
{
public:
	// Ошибка защиты.
	virtual long get_protection_error () const = 0;

	// Колличество оставшихся триальных дней. Если `== 0` - триальный период истек; если `< 0`
	// триальный период не установлен.
	virtual long get_rest_trial_days_count () const = 0;

	// статус авторегистрации
	virtual bool get_autoregistration_status () const = 0;

	virtual void set_autoregistration_status (bool autoregistration_status)
		/*throw (AccessDenied)*/ = 0;

	// Почта администратора
	virtual const GCI::IO::String& get_administrator_email () const = 0;
	virtual GCI::IO::String& get_administrator_email () = 0;

	virtual void set_administrator_email (GCI::IO::String* administrator_email) = 0;

	// Телефон администратора
	virtual const GCI::IO::String& get_administrator_phone () const = 0;
	virtual GCI::IO::String& get_administrator_phone () = 0;

	virtual void set_administrator_phone (GCI::IO::String* administrator_phone) = 0;

	// Начало работы с системой. При успешном завершении подключается к базе, прописанной в
	// параметрах, как база по умолчанию и возвращает интерфейс ICommon.
	virtual void login (
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
	)*/ = 0;

	// Начало работы с системой пользователя-гостя. При успешном завершении подключается к базе,
	// прописанной в параметрах, как база по умолчанию и возвращает интерфейс ICommon.
	virtual void guest_login () const /*throw (NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections)*/ = 0;

	// Окончание работы с системой.
	virtual void logout () const = 0;

	// Аналогично login но с регистрацией нового пользователя. email - адрес, на который в последствии
	// может быть выслана информация о пользователе (логин, пароль)
	virtual void autoregistration (
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
	)*/ = 0;

	// Проверяет наличие указанного адреса в базе. Если адрес найден,  высылает на него информацию о
	// пользователе.
	virtual void send_user_info_by_email (
		const char* email
	) const /*throw (
		SMTPServerAddressNotDefined
		, SMTPServerNotFound
		, UserNotFound
		, BadSMTPReply
		, SMTPAuthorizationFailed
	)*/ = 0;

	// возвращает true если сервер доступен, false иначе
	virtual bool is_server_alive () const = 0;

	// K274827650
	virtual void logout_without_xml_backup () const = 0;
};

/// factory interface for Authorization
class AuthorizationFactory {
public:
	static Authorization* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, XMLImportRunning)*/;
};

// сервер запущен, находится в процессе инициализации
class ServerIsStarting : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Константы для электронной отчётности
static const char* EO_ENABLED = "-EOEnable"; // подключён ли модуль ЭО. По-умолчанию считаем, что подключён.

#pragma pack (push, 1)

// Различные лицензионные счетчики
struct LicenseRestrictions {
	// Разрешенное количество обычных пользователей
	unsigned long users;
	// Разрешенное количество пользователей с постоянным доступом
	unsigned long permanent_users;
};

#pragma pack (pop)

class Common;
typedef ::Core::Var<Common> Common_var;
typedef ::Core::Var<const Common> Common_cvar;
// Интерфейс обеспечивает доступ к основной функциональности системы, доступной из "Основного меню"
// или навигатора.
class Common
	: virtual public ::Core::IObject
{
public:
	virtual const Date& get_base_date () const = 0;

	// Лицензионные ограничения на количество пользователей
	virtual const LicenseRestrictions get_license_restrictions () const = 0;

	// Возвращает документ (Document) по заданному внутреннему ("гарантовскому") номеру.
	virtual bool get_document_on_number (long number, Document*& document, MissingInfo*& missing_info) const = 0;

	// Установить нотификацию изменения папок.
	virtual void start_processing_folder_notification (ExternalFoldersChangeNotifier* notifier) = 0;

	// Проверяет существует (доступен) ли в системе Толковый словарь.
	// Возвращает true в случае, если толковый словарь существует.
	virtual bool is_explanatory_dictionary_exist () const = 0;

	virtual bool is_pharm_exist () const = 0;

	// проверка является ли база с лицензионными настройками - "для внутреннего использования"
	virtual bool check_internal () const = 0;

	// показывает рисунки для заданного топика (функциональность внутренней версии)
	virtual void show_pictures_on_number (
		long number
	) const /*throw (
		WorkingParamsNotFound
		, ExternalApplicationError
	)*/ = 0;

	virtual GCI::IO::String* get_complect_name () const = 0;

	// показывать ли помощь при первом запуске после инсталяции.
	virtual bool auto_show_help () const = 0;

	// получить тип установленного продукта
	virtual ProductType get_product_type () const = 0;

	// Получить сплеш
	virtual SplashScreen* get_splash_screen (bool is_start, short x, short y, bool flash_available) const = 0;

	// Получить менеджер настроек
	virtual SettingsManager* get_settings_manager () const = 0;

	// доступен ли модуль ЭО.
	virtual bool is_eo_enabled () const = 0;

	// Тип базы
	virtual BaseType get_base_type () const = 0;

	// Создать очередь обработки папочных нотификаций
	virtual void create_folder_notification_queue () = 0;

	// Получить баннер
	virtual Banner* get_banner () const /*throw (CanNotFindData)*/ = 0;

	// Есть ли усеченный индекс Источник опубликования
	virtual bool is_trimmed_publish_source_exists () const = 0;

	// словарь для скриптов (К271754146)
	virtual GCI::IO::Stream* get_scripts_system_dictionary () const = 0;

	virtual ExternalObject* get_picture (long id) const /*throw (CanNotFindData)*/ = 0;

	// включена ли поддержка удаления пользователей, которые давно не пользовались системой
	virtual bool is_erase_of_inactive_users_enabled () const = 0;

	// получить зашифрованный идентификатор комплекта
	virtual GCI::IO::String* get_encrypted_complect_id () const = 0;
};

/// factory interface for Common
class CommonFactory {
public:
	static Common* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ComponentManager;
typedef ::Core::Var<ComponentManager> ComponentManager_var;
typedef ::Core::Var<const ComponentManager> ComponentManager_cvar;
class ComponentManager
	: virtual public ::Core::IObject
{
public:
	virtual void start () /*throw (StorageLocked, LicenceViolation, ConfigurationsNotDefined, IPAddressNotFound, InvalidBase, NoServer, BadNetworkConfig, ServerVersionNotValid, WorkingParamsNotFound, NoMoreConnections, MorphoNotExists, InternalApplicationError, InvalidUserDatastore, ServerIsStarting)*/ = 0;

	virtual void stop () = 0;
};

/// factory interface for ComponentManager
class ComponentManagerFactory {
public:
	static ComponentManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class AssemblyInfo;
typedef ::Core::Var<AssemblyInfo> AssemblyInfo_var;
typedef ::Core::Var<const AssemblyInfo> AssemblyInfo_cvar;
class AssemblyInfo
	: virtual public ::Core::IObject
{
public:
	virtual bool get_is_debug () const = 0;

	virtual bool get_is_desktop () const = 0;

	virtual bool get_is_commerce () const = 0;

	virtual bool get_first_start () const = 0;

	virtual void set_first_start (bool first_start) = 0;

	// Разрядность сервера
	virtual const Capacity get_server_capacity () const = 0;
};

/// factory interface for AssemblyInfo
class AssemblyInfoFactory {
public:
	static AssemblyInfo* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Authorization> {
	typedef GblAdapterLib::AuthorizationFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Common> {
	typedef GblAdapterLib::CommonFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ComponentManager> {
	typedef GblAdapterLib::ComponentManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::AssemblyInfo> {
	typedef GblAdapterLib::AssemblyInfoFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_START_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
