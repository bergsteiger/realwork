////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::FoundContext_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i.h"

namespace GblAdapterLib {

FoundContext_i_factory::FoundContext_i_factory () {
}

void FoundContext_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FoundContextFactoryManager::register_factory (this, priority);
}

const char* FoundContext_i_factory::key () const {
	return "FoundContext_i";
}

FoundContext* FoundContext_i_factory::make (const GblPilot::ContextList& list) {
	FoundContext_i_var ret = new FoundContext_i (list);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

