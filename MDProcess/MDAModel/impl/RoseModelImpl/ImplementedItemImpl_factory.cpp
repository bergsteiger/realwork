////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ImplementedItemImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ImplementedItemImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ImplementedItemImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ImplementedItemImpl.h"

namespace RoseModelImpl {

ImplementedItemImpl_factory::ImplementedItemImpl_factory () {
}

void ImplementedItemImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ImplementedItemFactoryManager::register_factory (this, priority);
}

const char* ImplementedItemImpl_factory::key () const {
	return "ImplementedItemImpl";
}

ImplementedItem* ImplementedItemImpl_factory::make (const std::string& uid, bool need_collect_child) {
	ImplementedItemImpl_var ret = new ImplementedItemImpl (uid, need_collect_child);
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

