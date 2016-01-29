////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Security/Security.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"

namespace GblAdapterLib {


const char* WrongAuthentication::uid () const /*throw ()*/ {
	return "80BFA2E6-4042-47C3-AA1D-88FCEFBBA68A";
}

const char* WrongAuthentication::what () const throw () {
	//#UC START# *45EED4A10222_WHAT_IMPL*
	return "WrongAuthentication (Неверные данные аутентификации)";
	//#UC END# *45EED4A10222_WHAT_IMPL*
}


const char* NoMoreProfiles::uid () const /*throw ()*/ {
	return "B32A68D2-68F0-4DBE-AB9E-08E914C25499";
}

const char* NoMoreProfiles::what () const throw () {
	//#UC START# *45EED4A10224_WHAT_IMPL*
	return "NoMoreProfiles (Превышение лимита профилей пользователей)";
	//#UC END# *45EED4A10224_WHAT_IMPL*
}


const char* UserActive::uid () const /*throw ()*/ {
	return "3638F5BA-04D9-471F-95F1-189DC103C6AA";
}

const char* UserActive::what () const throw () {
	//#UC START# *45EED4A10226_WHAT_IMPL*
	return "UserActive (Попытка удалить работающего в данный момент пользователя)";
	//#UC END# *45EED4A10226_WHAT_IMPL*
}


const char* LicenceViolation::uid () const /*throw ()*/ {
	return "DE3C78AF-C27D-4243-8916-D969C6B1C70C";
}

const char* LicenceViolation::what () const throw () {
	//#UC START# *45EED4A10228_WHAT_IMPL*
	return "LicenceViolation (Нарушение лицензионных настроек)";
	//#UC END# *45EED4A10228_WHAT_IMPL*
}


const char* XMLImportRunning::uid () const /*throw ()*/ {
	return "5A13C909-06FA-4682-8E2D-1C2AD5C2DAED";
}

const char* XMLImportRunning::what () const throw () {
	//#UC START# *45EED4A10232_WHAT_IMPL*
	return "XMLImportRunning (Активен процесс заливки на стороне сервера)";
	//#UC END# *45EED4A10232_WHAT_IMPL*
}


const char* LoginDuplicate::uid () const /*throw ()*/ {
	return "449F06CD-5A0E-477F-8B6D-ADFB8844E8CC";
}

const char* LoginDuplicate::what () const throw () {
	//#UC START# *45EED4A10234_WHAT_IMPL*
	return "LoginDuplicate (Данный пользователь уже зарегестрирован в системе)";
	//#UC END# *45EED4A10234_WHAT_IMPL*
}


const char* ShutdownInited::uid () const /*throw ()*/ {
	return "DC16A621-69A1-4C58-AA89-B0231118E870";
}

const char* ShutdownInited::what () const throw () {
	//#UC START# *45EED4A10236_WHAT_IMPL*
	return "ShutdownInited (Бросается в случае попытки залогинится в момент завершения работы сервера.)";
	//#UC END# *45EED4A10236_WHAT_IMPL*
}

// factory interface wrapper for UserProfile
UserProfile* UserProfileFactory::make (
	Uid uid
	, const char* login
	, const char* name
	, const char* mail
	, bool is_system
	, bool has_password
	, bool can_buy_consulting
	, bool is_permanent
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return UserProfileFactoryManager::Singleton::instance ()->make (uid, login, name, mail, is_system, has_password, can_buy_consulting, is_permanent);
}

UserProfile* UserProfileFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return UserProfileFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for UserFilter
UserFilter* UserFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return UserFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for ProfileNode
ProfileNode* ProfileNodeFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ProfileNodeFactoryManager::Singleton::instance ()->make ();
}


const char* TrialPeriodExpired::uid () const /*throw ()*/ {
	return "7AB288B1-A8C3-40AF-855F-687762019272";
}

const char* TrialPeriodExpired::what () const throw () {
	//#UC START# *45EED8E0009C_WHAT_IMPL*
	return "TrialPeriodExpired (Время ознакомительной версии истекло)";
	//#UC END# *45EED8E0009C_WHAT_IMPL*
}


const char* AutoregistrationDisabled::uid () const /*throw ()*/ {
	return "02B61457-0724-454A-A52C-DB5B78CCA7B1";
}

const char* AutoregistrationDisabled::what () const throw () {
	//#UC START# *4639B499020D_WHAT_IMPL*
	return "AutoregistrationDisabled (Авторегистрация запрещена администратором системы)";
	//#UC END# *4639B499020D_WHAT_IMPL*
}


const char* NoMorePrivilegedProfiles::uid () const /*throw ()*/ {
	return "7CA79B54-8C37-4D00-84C0-52F2F780D68F";
}

const char* NoMorePrivilegedProfiles::what () const throw () {
	//#UC START# *473DCA1E03CD_WHAT_IMPL*
	return "NoMorePrivilegedProfiles (нельзя завести новых пользователей с привилегированным входом)";
	//#UC END# *473DCA1E03CD_WHAT_IMPL*
}

// factory interface wrapper for UserManager
UserManager* UserManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return UserManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for GroupNode
GroupNode* GroupNodeFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return GroupNodeFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

