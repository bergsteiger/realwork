////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::TypeLinkHelperImpl
//
// сервант
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl.h"

namespace RoseModelImpl {

TypeLinkHelperImpl_factory::TypeLinkHelperImpl_factory () {
}

void TypeLinkHelperImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TypeLinkHelperFactoryManager::register_factory (this, priority);
}

const char* TypeLinkHelperImpl_factory::key () const {
	return "TypeLinkHelperImpl";
}

TypeLinkHelper* TypeLinkHelperImpl_factory::get () {
	TypeLinkHelperImpl_var ret = new TypeLinkHelperImpl ();
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

