////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BlocksFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::BlocksFilter_i
//
// заглушка для фильтра по блокам
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BlocksFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BlocksFilter_i.h"

namespace GblAdapterLib {

BlocksFilter_i_factory::BlocksFilter_i_factory () {
}

void BlocksFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	BlocksFilterFactoryManager::register_factory (this, priority);
}

const char* BlocksFilter_i_factory::key () const {
	return "BlocksFilter_i";
}

BlocksFilter* BlocksFilter_i_factory::make () {
	BlocksFilter_i_var ret = new BlocksFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

