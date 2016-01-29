////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperationFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for ExternalOperation
ExternalOperation* ExternalOperationFactory::make (
	ObjectId id
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ExternalOperationFactoryManager::Singleton::instance ()->make (id);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

