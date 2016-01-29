////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::JournalBookmark_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i.h"

namespace GblAdapterLib {

JournalBookmark_i_factory::JournalBookmark_i_factory () {
}

void JournalBookmark_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	JournalBookmarkFactoryManager::register_factory (this, priority);
}

const char* JournalBookmark_i_factory::key () const {
	return "JournalBookmark_i";
}

JournalBookmark* JournalBookmark_i_factory::make (ObjectId doc_id, ParaId para_id) {
	JournalBookmark_i_var ret = new JournalBookmark_i (doc_id, para_id);
	return ret._retn ();
}

JournalBookmark* JournalBookmark_i_factory::make (GblUserJournal::JournalBookmark* journal_bookmark) {
	JournalBookmark_i_var ret = new JournalBookmark_i (journal_bookmark);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

