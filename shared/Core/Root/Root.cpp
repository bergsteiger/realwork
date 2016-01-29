////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/Root/Root.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Root
//
// Пакет интерфейсов фремворка GCM2 (не сетевая часть)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/mt/mt.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/Root/RootFactories.h"

namespace Core {
namespace Root {


const char* InvalidParams::uid () const /*throw ()*/ {
	return "2846088D-00FE-4A38-BCA6-0D4994A3FEBE";
}

const char* InvalidParams::what () const throw () {
	//#UC START# *457FEE6A0222_WHAT_IMPL*
	return "InvalidParams (неверные параметры инициализации приложения (недостаточно данных или не корректные значения))";
	//#UC END# *457FEE6A0222_WHAT_IMPL*
}


const char* HomeManagerInitError::uid () const /*throw ()*/ {
	return "FD7C1541-D61D-4569-A685-75CE5C77F513";
}

const char* HomeManagerInitError::what () const throw () {
	//#UC START# *457FEEA20280_WHAT_IMPL*
	return "HomeManagerInitError (Внутрення ошибка инициализации менеджера библиотек (например отсутствие доступа к внешним ресурсам))";
	//#UC END# *457FEEA20280_WHAT_IMPL*
}


// oneway methods impl
struct ExecuteParams_ {
	Executor_var self;
	ExecuteParams_ (Executor* self_) : self(Executor::_duplicate(self_)) {
	}
};

void Executor::thr_execute_ (void* arg) {
	try {
		Core::Aptr<ExecuteParams_> arg_ (reinterpret_cast<ExecuteParams_*>(arg));
		arg_->self->execute_ ();
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute Executor::execute oneway function"));
	} catch (...) {
		LOG_UEX (("while execute Executor::execute oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle Executor::execute () {
	Core::Aptr<ExecuteParams_> arg = new ExecuteParams_ (this);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (Executor::thr_execute_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}
// factory interface wrapper for Configuration
const Configuration& ConfigurationFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConfigurationFactoryManager::Singleton::instance ()->get ();
}


MDAGenNotImplemented::MDAGenNotImplemented (const std::string& method)
	: m_method (method)
//#UC START# *45169212034B_BASE_INIT*
//#UC END# *45169212034B_BASE_INIT*
{
	//#UC START# *45169212034B_BODY*
	//#UC END# *45169212034B_BODY*
}

MDAGenNotImplemented::~MDAGenNotImplemented () throw () {
}

const char* MDAGenNotImplemented::uid () const /*throw ()*/ {
	return "FB20AC5D-5615-4B58-953F-6FEC4F5636C2";
}

const char* MDAGenNotImplemented::what () const throw () {
	//#UC START# *45169212034B_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "MDAGenNotImplemented (Method is generated but not implemented), method=%s"
		, m_method.c_str ()
	);
	return m_message;
	//#UC END# *45169212034B_WHAT_IMPL*
}


CachedAttrUninitialized::CachedAttrUninitialized (const std::string& attr_name)
	: m_attr_name (attr_name)
//#UC START# *452A33970236_BASE_INIT*
//#UC END# *452A33970236_BASE_INIT*
{
	//#UC START# *452A33970236_BODY*
	//#UC END# *452A33970236_BODY*
}

CachedAttrUninitialized::~CachedAttrUninitialized () throw () {
}

const char* CachedAttrUninitialized::uid () const /*throw ()*/ {
	return "0621C617-F979-4458-A14E-F3FAB4E2A587";
}

const char* CachedAttrUninitialized::what () const throw () {
	//#UC START# *452A33970236_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "Class attribute accessed by cached function (%s) wasn't initialized"
		, m_attr_name.c_str ()
	);
	return m_message;
	//#UC END# *452A33970236_WHAT_IMPL*
}


NoActiveFactory::NoActiveFactory (const std::string& factory_name)
	: m_factory_name (factory_name)
//#UC START# *45169FB70186_BASE_INIT*
//#UC END# *45169FB70186_BASE_INIT*
{
	//#UC START# *45169FB70186_BODY*
	//#UC END# *45169FB70186_BODY*
}

NoActiveFactory::~NoActiveFactory () throw () {
}

const char* NoActiveFactory::uid () const /*throw ()*/ {
	return "8C36CFDA-BB6F-4918-8A2D-730DCC298BD9";
}

const char* NoActiveFactory::what () const throw () {
	//#UC START# *45169FB70186_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "NoActiveFactory (No one servant was registers for factory), factory_name=%s"
		, m_factory_name.c_str ()
	);
	return m_message;
	//#UC END# *45169FB70186_WHAT_IMPL*
}


DuplicatedFactoryKey::DuplicatedFactoryKey (const std::string& factory_name, const std::string& key_name)
	: m_factory_name (factory_name), m_key_name (key_name)
//#UC START# *4516A04500FA_BASE_INIT*
//#UC END# *4516A04500FA_BASE_INIT*
{
	//#UC START# *4516A04500FA_BODY*
	//#UC END# *4516A04500FA_BODY*
}

DuplicatedFactoryKey::~DuplicatedFactoryKey () throw () {
}

const char* DuplicatedFactoryKey::uid () const /*throw ()*/ {
	return "61D48B2D-1A08-4261-9DE3-9396F3356539";
}

const char* DuplicatedFactoryKey::what () const throw () {
	//#UC START# *4516A04500FA_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "Just one servant can registers in one factory (%s) with a same key (%s)"
		, m_factory_name.c_str ()
		, m_key_name.c_str ()
	);
	return m_message;
	//#UC END# *4516A04500FA_WHAT_IMPL*
}


UnknownFactoryKey::UnknownFactoryKey (const std::string& factory_name, const std::string& key_name)
	: m_factory_name (factory_name), m_key_name (key_name)
//#UC START# *45169D440222_BASE_INIT*
//#UC END# *45169D440222_BASE_INIT*
{
	//#UC START# *45169D440222_BODY*
	//#UC END# *45169D440222_BODY*
}

UnknownFactoryKey::~UnknownFactoryKey () throw () {
}

const char* UnknownFactoryKey::uid () const /*throw ()*/ {
	return "42540CD0-2B0C-45F2-82DB-0474D2D29867";
}

const char* UnknownFactoryKey::what () const throw () {
	//#UC START# *45169D440222_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "No one servant was registers for factory (%s) with a given key (%s)"
		, m_factory_name.c_str ()
		, m_key_name.c_str ()
	);
	return m_message;
	//#UC END# *45169D440222_WHAT_IMPL*
}

// factory interface wrapper for LibHomeManager
LibHomeManager& LibHomeManagerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return LibHomeManagerFactoryManager::Singleton::instance ()->get ();
}


WrongVersion::WrongVersion (unsigned long client_version, unsigned long dll_version)
	: m_client_version (client_version), m_dll_version (dll_version)
//#UC START# *474D670F03E4_BASE_INIT*
//#UC END# *474D670F03E4_BASE_INIT*
{
	//#UC START# *474D670F03E4_BODY*
	//#UC END# *474D670F03E4_BODY*
}

WrongVersion::~WrongVersion () throw () {
}

const char* WrongVersion::uid () const /*throw ()*/ {
	return "69708A24-C2D3-4685-8016-7E2FD8A5888C";
}

const char* WrongVersion::what () const throw () {
	//#UC START# *474D670F03E4_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "Версия клиента (%u) не совпадает с версией ДЛЛ (%u)"
		, m_client_version
		, m_dll_version
	);
	return m_message;
	//#UC END# *474D670F03E4_WHAT_IMPL*
}


const char* ImpossibleConversion::uid () const /*throw ()*/ {
	return "A7B2B824-951F-4EC2-B3F0-23C68B4F68D1";
}

const char* ImpossibleConversion::what () const throw () {
	//#UC START# *475CC8930032_WHAT_IMPL*
	return "ImpossibleConversion (Cоздание объекта по комбинации значений параметров-ключей фабрики невозможно.)";
	//#UC END# *475CC8930032_WHAT_IMPL*
}


const char* FactoryManagerWasDestroyed::uid () const /*throw ()*/ {
	return "2ECC198A-FD94-4065-8EC2-EE9E0A2DF173";
}

const char* FactoryManagerWasDestroyed::what () const throw () {
	//#UC START# *47620A190257_WHAT_IMPL*
	return "FactoryManagerWasDestroyed (Нельзя повторно использовать уже \"уничтоженный\" менеджер фабрик. Возникает при поытке обратится к менеджеру фабрик, который уже был уничтожен.)";
	//#UC END# *47620A190257_WHAT_IMPL*
}


const char* ConstViolation::uid () const /*throw ()*/ {
	return "7628A892-ABCC-46A9-8386-EB9B4D12D92E";
}

const char* ConstViolation::what () const throw () {
	//#UC START# *47B024700129_WHAT_IMPL*
	return "ConstViolation (Возникает при попытке вызвать неконстантный метод на констонтом объекте)";
	//#UC END# *47B024700129_WHAT_IMPL*
}

} // namespace Root
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

