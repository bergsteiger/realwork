////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FullAttributeInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i.h"

namespace GblAdapterLib {

FullAttributeInfo_i_factory::FullAttributeInfo_i_factory () {
}

void FullAttributeInfo_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FullAttributeInfoFactoryManager::register_factory (this, priority);
}

const char* FullAttributeInfo_i_factory::key () const {
	return "FullAttributeInfo_i";
}

FullAttributeInfo* FullAttributeInfo_i_factory::make (const GblPilotQueryDef::FullAttributeInfo& full_info) {
	FullAttributeInfo_i_var ret = new FullAttributeInfo_i (full_info);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

