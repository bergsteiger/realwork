////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DocListFactory_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i.h"

namespace GblAdapterLib {

DocListFactory_i_factory::DocListFactory_i_factory () {
}

void DocListFactory_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocListFactoryFactoryManager::register_factory (this, priority);
}

const char* DocListFactory_i_factory::key () const {
	return "DocListFactory_i";
}

DocListFactory* DocListFactory_i_factory::make () {
	return Core::IObject::_duplicate (DocListFactory_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

