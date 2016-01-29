////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalLinkFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink.h"

namespace GblAdapterLib {

ExternalLinkFromLink_factory::ExternalLinkFromLink_factory () {
}

void ExternalLinkFromLink_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ObjectFromLinkFactoryManager::register_factory (this, priority);
}

const LinkedObjectType ExternalLinkFromLink_factory::key () const {
	return LO_EXTERNAL_LINK;
}

ObjectFromLink* ExternalLinkFromLink_factory::make (GblPilot::Link* server_link) {
	ExternalLinkFromLink_var ret = new ExternalLinkFromLink (server_link);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

