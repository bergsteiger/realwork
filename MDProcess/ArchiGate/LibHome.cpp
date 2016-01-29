////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::ArchiGate
//
// серверная либа для коммуникации с арчи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/ArchiGate/LibHome.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

namespace ArchiGate {

void LibHomeImpl::publish_all_servers_factories () const {
	DocCardRemote::BigFileIteratorFactoryManager::publish_self ();
	DocCardRemote::ArchiEventsListenerFactoryManager::publish_self ();
	DocCardRemote::Searcher2FactoryManager::publish_self ();
	DocCardRemote::UtilsFactoryManager::publish_self ();
	DocCardRemote::GardocGetterFactoryManager::publish_self ();
	DocCardRemote::SearcherFactoryManager::publish_self ();
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4E14407D0286_ENVIRONMENTS_CONFIG*
	//#UC END# *4E14407D0286_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
