////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::IsVirtualImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl.h"

namespace RoseModelImpl {

IsVirtualImpl_factory::IsVirtualImpl_factory () {
}

void IsVirtualImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IsVirtualFactoryManager::register_factory (this, priority);
}

const char* IsVirtualImpl_factory::key () const {
	return "IsVirtualImpl";
}

IsVirtual* IsVirtualImpl_factory::get () {
	IsVirtualImpl_var ret = new IsVirtualImpl ();
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

