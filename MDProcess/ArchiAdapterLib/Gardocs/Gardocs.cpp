////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/Gardocs/Gardocs.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapterLib {
namespace Gardocs {


const char* CommunicationFailure::uid () const /*throw ()*/ {
	return "0BF2EAA3-3C79-4C5E-9E57-8042530CB65A";
}

const char* CommunicationFailure::what () const throw () {
	//#UC START# *4E18391703CD_WHAT_IMPL*
	return "CommunicationFailure (сетевая ошибка, попробуйте повторить минут через десять)";
	//#UC END# *4E18391703CD_WHAT_IMPL*
}

// factory interface wrapper for Searcher
Searcher& SearcherFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SearcherFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for ArchiEventsListener
ArchiEventsListener& ArchiEventsListenerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ArchiEventsListenerFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for Searcher2
Searcher2* Searcher2Factory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return Searcher2FactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for Utils
Utils* UtilsFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return UtilsFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for GardocGetter
GardocGetter* GardocGetterFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return GardocGetterFactoryManager::Singleton::instance ()->get ();
}

} // namespace Gardocs
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

