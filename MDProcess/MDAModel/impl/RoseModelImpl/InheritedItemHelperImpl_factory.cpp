////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemHelperImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.h"

namespace RoseModelImpl {

InheritedItemHelperImpl_factory::InheritedItemHelperImpl_factory () {
}

void InheritedItemHelperImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	InheritedItemHelperFactoryManager::register_factory (this, priority);
}

const char* InheritedItemHelperImpl_factory::key () const {
	return "InheritedItemHelperImpl";
}

InheritedItemHelper* InheritedItemHelperImpl_factory::get () {
	InheritedItemHelperImpl_var ret = new InheritedItemHelperImpl ();
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

