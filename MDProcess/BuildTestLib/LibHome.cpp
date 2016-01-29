////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::BuildTestLib
//
// библиотека реализующая логику сервера запуска тестов ночных сборок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/BuildTestLib/LibHome.h"
#include "MDProcess/BuildTestLib/TestResults/TestResultsFactories.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublishFactories.h"

namespace BuildTestLib {

void LibHomeImpl::publish_all_servers_factories () const {
	TestResults::TestFactoryManager::publish_self ();
	TestResults::FunctionalTestFactoryManager::publish_self ();
	TestPublish::PublishFactoryManager::publish_self ();
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4C878C39025E_ENVIRONMENTS_CONFIG*
	//#UC END# *4C878C39025E_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
