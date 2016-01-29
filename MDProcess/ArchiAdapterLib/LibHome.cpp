////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::ArchiAdapterLib
//
// ArchiAdapterLib
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/ArchiAdapterLib/LibHome.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl_factory.h"

namespace ArchiAdapterLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4E1440560048_ENVIRONMENTS_CONFIG*
	//#UC END# *4E1440560048_ENVIRONMENTS_CONFIG*

	{
		GardocsImpl::SearcherImpl_factory_var fctr = new GardocsImpl::SearcherImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GardocsImpl::ArchiEventsListenerImpl_factory_var fctr = new GardocsImpl::ArchiEventsListenerImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GardocsImpl::Searcher2Impl_factory_var fctr = new GardocsImpl::Searcher2Impl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GardocsImpl::UtilsImpl_factory_var fctr = new GardocsImpl::UtilsImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GardocsImpl::GardocGetterImpl_factory_var fctr = new GardocsImpl::GardocGetterImpl_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
