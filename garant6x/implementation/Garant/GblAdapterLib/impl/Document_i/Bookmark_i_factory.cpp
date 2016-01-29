////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Bookmark_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i.h"

namespace GblAdapterLib {

Bookmark_i_factory* Bookmark_i_factory::s_instance = 0;

Bookmark_i_factory::Bookmark_i_factory () {
}

void Bookmark_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	BookmarkFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* Bookmark_i_factory::key () const {
	return "Bookmark_i";
}

Bookmark* Bookmark_i_factory::make (
	const GblPilotDef::Bookmark& bookmark
	, GblFolders::DocBookmark* doc_bookmark
	, FoldersNode* folders_node
) {
	Bookmark_i_var ret = new Bookmark_i (bookmark, doc_bookmark, folders_node);
	return ret._retn ();
}

Bookmark_i* Bookmark_iServantFactory::make (const GblPilotDef::Bookmark& bookmark, GblFolders::DocBookmark* doc_bookmark, FoldersNode* folders_node) {
	if (Bookmark_i_factory::s_instance) {
		return dynamic_cast<Bookmark_i*>(Bookmark_i_factory::s_instance->make (bookmark, doc_bookmark, folders_node));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::Bookmark_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

