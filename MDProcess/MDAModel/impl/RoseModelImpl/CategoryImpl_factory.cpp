////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::CategoryImpl
//
// реализация элемента-папка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl.h"

namespace RoseModelImpl {

CategoryImpl_factory::CategoryImpl_factory () {
}

void CategoryImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	CategoryFactoryManager::register_factory (this, priority);
}

const char* CategoryImpl_factory::key () const {
	return "CategoryImpl";
}

Category* CategoryImpl_factory::make (IRoseCategoryPtr cat) {
	CategoryImpl_var ret = new CategoryImpl (cat);
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

