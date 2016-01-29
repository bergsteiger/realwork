////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/NotifyService_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> shared::GSI::NotifyService_i
//
// Реализация сервиса нотификаций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include <typeinfo>
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_iFactories.h"
#include "shared/GSI/LibHome.h"


namespace GSI {
namespace NotifyService_i {

// factory interface wrapper for ManagerLocal
ManagerLocal& ManagerLocalFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	try {
		return dynamic_cast<ManagerLocal&> (NotifyService::ManagerFactory::make ());
	} catch (std::bad_cast&) {
		throw Core::Root::NoActiveFactory ("GSI::NotifyService_i::ManagerLocalFactory");
	}

}



} //namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

