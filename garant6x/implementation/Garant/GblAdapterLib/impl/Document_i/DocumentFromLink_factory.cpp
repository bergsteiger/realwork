////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentFromLink_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentFromLink.h"

namespace GblAdapterLib {

DocumentFromLink_factory::DocumentFromLink_factory () {
}

void DocumentFromLink_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ObjectFromLinkFactoryManager::register_factory (this, priority);
}

const LinkedObjectType DocumentFromLink_factory::key () const {
	return LO_DOCUMENT;
}

ObjectFromLink* DocumentFromLink_factory::make (GblPilot::Link* server_link) {
	DocumentFromLink_var ret = new DocumentFromLink (server_link);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

