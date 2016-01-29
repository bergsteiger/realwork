////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/GenSupport/GenSupport.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::GenSupport
//
// вспомогательные интерфейсы для генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

namespace GenSupport {


const char* GenerationNotStarted::uid () const /*throw ()*/ {
	return "AD5FC975-952A-401C-B9D6-CA81C8DBE806";
}

const char* GenerationNotStarted::what () const throw () {
	//#UC START# *4AD6C3A701D9_WHAT_IMPL*
	return "GenerationNotStarted ()";
	//#UC END# *4AD6C3A701D9_WHAT_IMPL*
}


const char* GenerationCanceled::uid () const /*throw ()*/ {
	return "FDE881FF-8040-4809-950B-F1DF00CE67DC";
}

const char* GenerationCanceled::what () const throw () {
	//#UC START# *4AD5DE5100B9_WHAT_IMPL*
	return "GenerationCanceled (Генерация была прервана пользователем)";
	//#UC END# *4AD5DE5100B9_WHAT_IMPL*
}


const char* GenerationAlreadyStarted::uid () const /*throw ()*/ {
	return "B715430E-C1F7-4A92-AE7D-F8ADDAFE5D61";
}

const char* GenerationAlreadyStarted::what () const throw () {
	//#UC START# *4AD6C3BE00FF_WHAT_IMPL*
	return "GenerationAlreadyStarted ()";
	//#UC END# *4AD6C3BE00FF_WHAT_IMPL*
}

// factory interface wrapper for ProgessIndicatorService
ProgessIndicatorService& ProgessIndicatorServiceFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ProgessIndicatorServiceFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for PageProxy
PageProxy& PageProxyFactory::get (
	ServerGate::GenerationContents::ModelElementId_const page_guid
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PageProxyFactoryManager::Singleton::instance ()->get (page_guid);
}

// factory interface wrapper for LogManager
LogManager& LogManagerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return LogManagerFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for ErrorManager
ErrorManager& ErrorManagerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ErrorManagerFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for Environment
Environment& EnvironmentFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return EnvironmentFactoryManager::Singleton::instance ()->get ();
}

AutoErrorSuppress::~AutoErrorSuppress () {
	//#UC START# *4BE245810227_DCTOR*
	GenSupport::EnvironmentFactory::get ().set_suppress_generation_errors (saved_value);
	//#UC END# *4BE245810227_DCTOR*
}

// need_error - если  false - ошибки будут подавляться
AutoErrorSuppress::AutoErrorSuppress (bool need_error)
//#UC START# *4BE245D30311_INIT_CTOR_BASE_INIT*
	: saved_value (GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ())
//#UC END# *4BE245D30311_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4BE245D30311_CTOR_BODY*
	GenSupport::EnvironmentFactory::get ().set_suppress_generation_errors (!need_error);
	//#UC END# *4BE245D30311_CTOR_BODY*
}
} // namespace GenSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

