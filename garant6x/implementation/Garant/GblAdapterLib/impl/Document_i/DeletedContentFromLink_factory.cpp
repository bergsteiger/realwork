////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DeletedContentFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink.h"

namespace GblAdapterLib {

DeletedContentFromLink_factory::DeletedContentFromLink_factory () {
}

void DeletedContentFromLink_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ObjectFromLinkFactoryManager::register_factory (this, priority);
}

const LinkedObjectType DeletedContentFromLink_factory::key () const {
	return LO_DELETED_FOLDERS_CONTENT;
}

ObjectFromLink* DeletedContentFromLink_factory::make (GblPilot::Link* server_link) {
	DeletedContentFromLink_var ret = new DeletedContentFromLink (server_link);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

