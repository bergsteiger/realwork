////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::UserJournal_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalObjectTypeTranslator.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserJournal_i::UserJournal_i ()
//#UC START# *4A7FF6610114_4A7FFC1801CF_4A92A2B803C5_BASE_INIT*
//#UC END# *4A7FF6610114_4A7FFC1801CF_4A92A2B803C5_BASE_INIT*
{
	//#UC START# *4A7FF6610114_4A7FFC1801CF_4A92A2B803C5_BODY*
	//#UC END# *4A7FF6610114_4A7FFC1801CF_4A92A2B803C5_BODY*
}

UserJournal_i::~UserJournal_i () {
	//#UC START# *4A92A2B803C5_DESTR_BODY*
	//#UC END# *4A92A2B803C5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UserJournal
// Очистить Журнал работы (аналогичен вызову remove (рут дерева журнала работы)
void UserJournal_i::clear () const {
	//#UC START# *4A7FFA7B03B3_4A92A2B803C5*
	dynamic_cast<JournalTree*> (m_root->owner_tree ())->clear ();
	//#UC END# *4A7FFA7B03B3_4A92A2B803C5*
}

// implemented method from UserJournal
// список закладок заданного типа
JournalBookmarkList* UserJournal_i::get_bookmark_history (
	BookmarkJournalType type
	, long max_count
) const /*throw (
	CanNotFindData
)*/ {
	//#UC START# *4A8000BD0335_4A92A2B803C5*
	Core::GDS::StopWatchEx sw ("getting bookmark's for OM");
	GblUserJournal::JournalObjectList_var journal_object_list;
	try {
		journal_object_list = ApplicationHelper::instance ()->get_cached_user_journal ()->get_history_list (
			BookmarkJournalTypeTranslatorSingleton::instance ()->get (type)
			, max_count
		);
	} catch (...) {
		throw CanNotFindData ();
	}
	long size = journal_object_list->length ();
	if (!size) {
		throw CanNotFindData ();
	}
	long count = max_count ? (max_count > size ? size : max_count) : size;
	JournalBookmarkList* journal_bookmark_list = new JournalBookmarkList (count);
	unsigned index = 0;
	for (long i = 0; i < count; i++) {
		GblUserJournal::JournalBookmark_var server_journal_bookmark = 
			GblUserJournal::JournalBookmark::_narrow ((*journal_object_list) [i]);
		JournalBookmark_var journal_bookmark (JournalBookmarkFactory::make (server_journal_bookmark.in ()));
		journal_bookmark_list->operator [] (i) = journal_bookmark;
	}
	return journal_bookmark_list;
	//#UC END# *4A8000BD0335_4A92A2B803C5*
}

// implemented method from UserJournal
// Получит список запросов заданного типа из Журнала
QueryList* UserJournal_i::get_query_history (QueryType query_type, long max_count) const /*throw (CanNotFindData)*/ {
	//#UC START# *4A8000D00269_4A92A2B803C5*
	Core::GDS::StopWatchEx sw ("getting query's for OM");
	GblUserJournal::JournalObjectList_var journal_object_list;
	try {
		journal_object_list = ApplicationHelper::instance ()->get_cached_user_journal ()->get_history_list (
			QueryJournalTypeTranslatorSingleton::instance ()->get (query_type)
			, max_count
		);
	} catch (...) {
		throw CanNotFindData ();
	}
	long size = journal_object_list->length ();
	if (!size) {
		throw CanNotFindData ();
	}
	long count = max_count ? (max_count > size ? size : max_count) : size;
	QueryList* query_list = new QueryList (count);
	for (long i = 0; i < count; i++) {
		GblUserJournal::JournalQuery_var journal_query = 
			GblUserJournal::JournalQuery::_narrow ((*journal_object_list) [i]);
		QueryCreator_var creator (QueryCreatorFactory::make ());
		Query_var query (creator->make_query (journal_query.in ()));
		query_list->operator [] (i) = query;
	}
	return query_list;
	//#UC END# *4A8000D00269_4A92A2B803C5*
}

// implemented method from UserJournal
// Получить дерево Журнала работы
NodeBase* UserJournal_i::get_user_jornal_tree () const {
	//#UC START# *4A7FFAB30168_4A92A2B803C5*
	if (m_root.is_nil ()) {
		GTree::Tree_var server_tree = ApplicationHelper::instance ()->get_cached_user_journal ()->get_tree ();
		Core::Var <JournalTree> journal_tree (new JournalTree (server_tree.in ()));
		m_root = dynamic_cast<RealNodeRoot*> (journal_tree->root ());
	}
	GDS_ASSERT (!m_root.is_nil ());
	return m_root._sretn ();
	//#UC END# *4A7FFAB30168_4A92A2B803C5*
}

// implemented method from UserJournal
// Удалить объект из журнала работы
void UserJournal_i::remove (const NodeBase* obj) const {
	//#UC START# *4A7FF9CA0176_4A92A2B803C5*
	const_cast <NodeBase*> (obj)->delete_node ();
	//#UC END# *4A7FF9CA0176_4A92A2B803C5*
}

// implemented method from UserJournal
// Сохранить объект в журнал работы
void UserJournal_i::save (const Core::IObject* obj, JournalObjectType object_type) const {
	//#UC START# *4A7FF7B40013_4A92A2B803C5*
	::GblUserJournalDef::JournalObject_var journal_object;
	switch (object_type) {
		case JOT_BOOKMARK:
			{
			const JournalBookmark* journal_bookmark = dynamic_cast <const JournalBookmark*> (obj);
			journal_object = new GblUserJournalDef::JournalObject; 
			*journal_object <<= journal_bookmark->get_journal_bookmark ();
			}
			break;

		case JOT_QUERY:
			{
			const Query* query = dynamic_cast <const Query*> (obj);
			GblPilotQueryDef::Query_var journal_query = const_cast <Query*>(query)->build_query ();
			journal_object = new GblUserJournalDef::JournalObject; 
			*journal_object <<= journal_query.in ();
			}
			break;
		default:
			GDS_ASSERT (false);
			return;
	}

	ApplicationHelper::instance ()->get_cached_user_journal ()->save (
		journal_object.in ()
		, translate (object_type)
	);

	//#UC END# *4A7FF7B40013_4A92A2B803C5*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

