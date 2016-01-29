////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/InpharmFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::InpharmFilter_i
//
// реализация фильтра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/InpharmFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/InpharmFilter_i.h"

namespace GblAdapterLib {

InpharmFilter_i_factory::InpharmFilter_i_factory () {
}

void InpharmFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	InpharmFilterFactoryManager::register_factory (this, priority);
}

const char* InpharmFilter_i_factory::key () const {
	return "InpharmFilter_i";
}

InpharmFilter* InpharmFilter_i_factory::make () {
	InpharmFilter_i_var ret = new InpharmFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

