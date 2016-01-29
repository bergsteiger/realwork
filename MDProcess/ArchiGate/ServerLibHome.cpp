////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::ArchiGate
//
// серверная либа для коммуникации с арчи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/ArchiGate/ServerLibHome.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl_factory.h"

namespace ArchiGate {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *4E14407D0286_ENVIRONMENTS_CONFIG*
	//#UC END# *4E14407D0286_ENVIRONMENTS_CONFIG*

	{
		DocCardRemoteImpl::SearcherImpl_factory_var fctr = new DocCardRemoteImpl::SearcherImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocCardRemoteImpl::ArchiEventsListenerImpl_factory_var fctr = new DocCardRemoteImpl::ArchiEventsListenerImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocCardRemoteImpl::Searcher2Impl_factory_var fctr = new DocCardRemoteImpl::Searcher2Impl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocCardRemoteImpl::UtilsImpl_factory_var fctr = new DocCardRemoteImpl::UtilsImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocCardRemoteImpl::GardocGetterImpl_factory_var fctr = new DocCardRemoteImpl::GardocGetterImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocCardRemoteImpl::BigFileIteratorImpl_factory_var fctr = new DocCardRemoteImpl::BigFileIteratorImpl_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
