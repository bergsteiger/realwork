////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookmarkFromLink_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::BookmarkFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookmarkFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookmarkFromLink.h"

namespace GblAdapterLib {

BookmarkFromLink_factory::BookmarkFromLink_factory () {
}

void BookmarkFromLink_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ObjectFromLinkFactoryManager::register_factory (this, priority);
}

const LinkedObjectType BookmarkFromLink_factory::key () const {
	return LO_BOOKMARK;
}

ObjectFromLink* BookmarkFromLink_factory::make (GblPilot::Link* server_link) {
	BookmarkFromLink_var ret = new BookmarkFromLink (server_link);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

