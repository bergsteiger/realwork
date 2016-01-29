////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::VariantsForDocFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i.h"

namespace GblAdapterLib {

VariantsForDocFilter_i_factory::VariantsForDocFilter_i_factory () {
}

void VariantsForDocFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	VariantsForDocFilterFactoryManager::register_factory (this, priority);
}

const char* VariantsForDocFilter_i_factory::key () const {
	return "VariantsForDocFilter_i";
}

VariantsForDocFilter* VariantsForDocFilter_i_factory::make (unsigned long doc_id) {
	VariantsForDocFilter_i_var ret = new VariantsForDocFilter_i (doc_id);
	return ret._retn ();
}

VariantsForDocFilter* VariantsForDocFilter_i_factory::make () {
	VariantsForDocFilter_i_var ret = new VariantsForDocFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

