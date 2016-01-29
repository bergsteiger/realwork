////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::RoseModelImpl
//
// Пакет реализации интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImplFactories.h"


namespace RoseModelImpl {

// factory interface wrapper for ImplementedItemEx
ImplementedItemEx* ImplementedItemExFactory::make (
	const std::string& stored_value
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ImplementedItemExFactoryManager::Singleton::instance ()->make (stored_value);
}

ImplementedItemEx* ImplementedItemExFactory::make (
	const std::string& uid
	, bool need_collect_child
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	ImplementedItemEx* ret = dynamic_cast<ImplementedItemEx*> (ImplementedItemFactory::make (uid, need_collect_child));
	if (ret == 0) {
		throw Core::Root::NoActiveFactory ("MDAModel::RoseModelImpl::ImplementedItemExFactory");
	}
	return ret;
}



// factory interface wrapper for OverloadedItemEx
OverloadedItemEx* OverloadedItemExFactory::make (
	const std::string& stored_value
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return OverloadedItemExFactoryManager::Singleton::instance ()->make (stored_value);
}

OverloadedItemEx* OverloadedItemExFactory::make (
	const std::string& uid
	, bool need_collect_child
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	OverloadedItemEx* ret = dynamic_cast<OverloadedItemEx*> (OverloadedItemFactory::make (uid, need_collect_child));
	if (ret == 0) {
		throw Core::Root::NoActiveFactory ("MDAModel::RoseModelImpl::OverloadedItemExFactory");
	}
	return ret;
}



} //namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

