////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalLink_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalLink_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalLink_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalLink_i.h"

namespace GblAdapterLib {

ExternalLink_i_factory::ExternalLink_i_factory () {
}

void ExternalLink_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ExternalLinkFactoryManager::register_factory (this, priority);
}

const char* ExternalLink_i_factory::key () const {
	return "ExternalLink_i";
}

ExternalLink* ExternalLink_i_factory::make (const char* url) {
	ExternalLink_i_var ret = new ExternalLink_i (url);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

