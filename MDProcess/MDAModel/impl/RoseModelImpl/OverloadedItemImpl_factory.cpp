////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/OverloadedItemImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::OverloadedItemImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/OverloadedItemImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/OverloadedItemImpl.h"

namespace RoseModelImpl {

OverloadedItemImpl_factory::OverloadedItemImpl_factory () {
}

void OverloadedItemImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	OverloadedItemFactoryManager::register_factory (this, priority);
}

const char* OverloadedItemImpl_factory::key () const {
	return "OverloadedItemImpl";
}

OverloadedItem* OverloadedItemImpl_factory::make (const std::string& uid, bool need_collect_child) {
	OverloadedItemImpl_var ret = new OverloadedItemImpl (uid, need_collect_child);
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

