////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::NotifyLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocalFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for DataTransformer
DataTransformer* DataTransformerFactory::make (const char* key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DataTransformerFactoryManager::Singleton::instance ()->make (key);
}


DataTransformerFactory::KeySet* DataTransformerFactory::keys () {
	return DataTransformerFactoryManager::keys ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

