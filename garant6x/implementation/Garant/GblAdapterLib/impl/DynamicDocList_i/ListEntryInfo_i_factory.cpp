////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListEntryInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i.h"

namespace GblAdapterLib {

ListEntryInfo_i_factory::ListEntryInfo_i_factory () {
}

void ListEntryInfo_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ListEntryInfoFactoryManager::register_factory (this, priority);
}

const char* ListEntryInfo_i_factory::key () const {
	return "ListEntryInfo_i";
}

ListEntryInfo* ListEntryInfo_i_factory::make (const GblPilot::ListEntryInfo& info, const NodeBase* root) {
	ListEntryInfo_i_var ret = new ListEntryInfo_i (info, root);
	return ret._retn ();
}

ListEntryInfo* ListEntryInfo_i_factory::make (const GblPilot::ListEntryInfo& info) {
	ListEntryInfo_i_var ret = new ListEntryInfo_i (info);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

