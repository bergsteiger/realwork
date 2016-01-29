////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ScriptFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink.h"

namespace GblAdapterLib {

ScriptFromLink_factory::ScriptFromLink_factory () {
}

void ScriptFromLink_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ObjectFromLinkFactoryManager::register_factory (this, priority);
}

const LinkedObjectType ScriptFromLink_factory::key () const {
	return LO_SCRIPT;
}

ObjectFromLink* ScriptFromLink_factory::make (GblPilot::Link* server_link) {
	ScriptFromLink_var ret = new ScriptFromLink (server_link);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

