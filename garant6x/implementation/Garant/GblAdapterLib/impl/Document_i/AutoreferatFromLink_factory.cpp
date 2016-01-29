////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatFromLink_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::AutoreferatFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatFromLink.h"

namespace GblAdapterLib {

AutoreferatFromLink_factory::AutoreferatFromLink_factory () {
}

void AutoreferatFromLink_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ObjectFromLinkFactoryManager::register_factory (this, priority);
}

const LinkedObjectType AutoreferatFromLink_factory::key () const {
	return LO_AUTOREFERAT;
}

ObjectFromLink* AutoreferatFromLink_factory::make (GblPilot::Link* server_link) {
	AutoreferatFromLink_var ret = new AutoreferatFromLink (server_link);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

