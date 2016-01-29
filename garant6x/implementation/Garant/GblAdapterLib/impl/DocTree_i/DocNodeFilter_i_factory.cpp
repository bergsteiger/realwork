////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocNodeFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i.h"

namespace GblAdapterLib {

DocNodeFilter_i_factory::DocNodeFilter_i_factory () {
}

void DocNodeFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocNodeFilterFactoryManager::register_factory (this, priority);
}

const char* DocNodeFilter_i_factory::key () const {
	return "DocNodeFilter_i";
}

DocNodeFilter* DocNodeFilter_i_factory::make () {
	DocNodeFilter_i_var ret = new DocNodeFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

