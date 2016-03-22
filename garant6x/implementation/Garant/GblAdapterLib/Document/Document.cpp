////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Document/Document.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for MissingInfo
MissingInfo* MissingInfoFactory::make (
	const GCD::PID& pid
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MissingInfoFactoryManager::Singleton::instance ()->make (pid);
}


const char* InvalidParaId::uid () const /*throw ()*/ {
	return "81D2E64B-0285-4665-8EBB-77AB7B23A3AE";
}

const char* InvalidParaId::what () const throw () {
	//#UC START# *45EEB6520306_WHAT_IMPL*
	return "InvalidParaId (Неверный идентификатор параграфа)";
	//#UC END# *45EEB6520306_WHAT_IMPL*
}


const char* InvalidTopicId::uid () const /*throw ()*/ {
	return "FE878400-C219-4FEC-BB94-F2810419776F";
}

const char* InvalidTopicId::what () const throw () {
	//#UC START# *45EEB6520321_WHAT_IMPL*
	return "InvalidTopicId (Возвращается при попытке выполнить операцию с внутренним идентификатором документа, несуществующим в базе.)";
	//#UC END# *45EEB6520321_WHAT_IMPL*
}


const char* FolderLinkNotFound::uid () const /*throw ()*/ {
	return "C8772FCD-1532-45DA-B06F-B8CFEEC690F5";
}

const char* FolderLinkNotFound::what () const throw () {
	//#UC START# *45EEB6520328_WHAT_IMPL*
	return "FolderLinkNotFound (Не найдена ссылка на папочный элемент (возможно он был удален))";
	//#UC END# *45EEB6520328_WHAT_IMPL*
}


const char* RedactionNotFound::uid () const /*throw ()*/ {
	return "C67DEF89-E674-4575-BCDD-F5B4232F6C43";
}

const char* RedactionNotFound::what () const throw () {
	//#UC START# *45EED9780391_WHAT_IMPL*
	return "RedactionNotFound (Возвращается в случае попытки получения несуществующей редакции объекта.)";
	//#UC END# *45EED9780391_WHAT_IMPL*
}


const char* InvalidDate::uid () const /*throw ()*/ {
	return "831C4B6F-1F96-4FD9-BC5B-72C094403C0C";
}

const char* InvalidDate::what () const throw () {
	//#UC START# *45EED97B0372_WHAT_IMPL*
	return "InvalidDate ()";
	//#UC END# *45EED97B0372_WHAT_IMPL*
}


const char* ExplanationDictionaryNotInstalled::uid () const /*throw ()*/ {
	return "26E18290-AD8C-4074-8A60-93B5C3A1A1EE";
}

const char* ExplanationDictionaryNotInstalled::what () const throw () {
	//#UC START# *45EEDA9A00B1_WHAT_IMPL*
	return "ExplanationDictionaryNotInstalled (Толковый словарь не установлен в системе. Возвращается в случае вызова операции \"поиск толкования\" и отсутствии в системе толкового словаря.)";
	//#UC END# *45EEDA9A00B1_WHAT_IMPL*
}

// factory interface wrapper for DiffIterator
DiffIterator* DiffIteratorFactory::make (
	const GblPilot::DiffData& diff_data
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DiffIteratorFactoryManager::Singleton::instance ()->make (diff_data);
}


const char* InvalidObjectClass::uid () const /*throw ()*/ {
	return "BBCC4DD8-8638-4E20-A012-B93EA66BDFF5";
}

const char* InvalidObjectClass::what () const throw () {
	//#UC START# *4A49F79C011A_WHAT_IMPL*
	return "InvalidObjectClass ()";
	//#UC END# *4A49F79C011A_WHAT_IMPL*
}


const char* NoPrevRedaction::uid () const /*throw ()*/ {
	return "A5E6BDD6-1CF7-42F1-A269-BC9C04E9708A";
}

const char* NoPrevRedaction::what () const throw () {
	//#UC START# *4A6D655A02A8_WHAT_IMPL*
	return "NoPrevRedaction ()";
	//#UC END# *4A6D655A02A8_WHAT_IMPL*
}


const char* InvalidEntryPoint::uid () const /*throw ()*/ {
	return "C9FCD56A-2C69-47CC-8B48-32E8C4296A40";
}

const char* InvalidEntryPoint::what () const throw () {
	//#UC START# *4C5ABA9401A6_WHAT_IMPL*
	return "InvalidEntryPoint ()";
	//#UC END# *4C5ABA9401A6_WHAT_IMPL*
}


const char* InvalidLayerID::uid () const /*throw ()*/ {
	return "E6D5FB9E-A514-44F7-B841-38A27EC6E33B";
}

const char* InvalidLayerID::what () const throw () {
	//#UC START# *4C5ABAA803CA_WHAT_IMPL*
	return "InvalidLayerID ()";
	//#UC END# *4C5ABAA803CA_WHAT_IMPL*
}

// factory interface wrapper for FoundContext
FoundContext* FoundContextFactory::make (
	const GblPilot::ContextList& list
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FoundContextFactoryManager::Singleton::instance ()->make (list);
}

// factory interface wrapper for DocumentTextProvider
DocumentTextProvider* DocumentTextProviderFactory::make (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DocumentTextProviderFactoryManager::Singleton::instance ()->make (server_doc, handle, all_at_once);
}

DocumentTextProvider* DocumentTextProviderFactory::make (
	GblPilot::Document* server_doc
	, unsigned long handle
	, bool all_at_once
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DocumentTextProviderFactoryManager::Singleton::instance ()->make (server_doc, handle, all_at_once);
}

// factory interface wrapper for Document
Document* DocumentFactory::make (
	GblPilot::Document* document
	, FactoryKey key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DocumentFactoryManager::Singleton::instance ()->make (document, key);
}

Document* DocumentFactory::make (
	const GCD::PID& pid
	, bool is_edition
	, const char* name
	, FactoryKey key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DocumentFactoryManager::Singleton::instance ()->make (pid, is_edition, name, key);
}


DocumentFactory::KeySet* DocumentFactory::keys () {
	return DocumentFactoryManager::keys ();
}

// factory interface wrapper for Bookmark
Bookmark* BookmarkFactory::make (
	const GblPilotDef::Bookmark& bookmark
	, GblFolders::DocBookmark* doc_bookmark
	, FoldersNode* folders_node
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return BookmarkFactoryManager::Singleton::instance ()->make (bookmark, doc_bookmark, folders_node);
}

// factory interface wrapper for DocumentState
DocumentState* DocumentStateFactory::make (
	Document* source_doc
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DocumentStateFactoryManager::Singleton::instance ()->make (source_doc);
}

DocumentState* DocumentStateFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DocumentStateFactoryManager::Singleton::instance ()->make ();
}


const char* AllChangesInTables::uid () const /*throw ()*/ {
	return "E9F52E90-CE36-4583-8178-1872A710E38A";
}

const char* AllChangesInTables::what () const throw () {
	//#UC START# *4ED7B9ED0009_WHAT_IMPL*
	return "AllChangesInTables ()";
	//#UC END# *4ED7B9ED0009_WHAT_IMPL*
}

// factory interface wrapper for JournalBookmark
JournalBookmark* JournalBookmarkFactory::make (
	ObjectId doc_id
	, ParaId para_id
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return JournalBookmarkFactoryManager::Singleton::instance ()->make (doc_id, para_id);
}

JournalBookmark* JournalBookmarkFactory::make (
	GblUserJournal::JournalBookmark* journal_bookmark
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return JournalBookmarkFactoryManager::Singleton::instance ()->make (journal_bookmark);
}

// factory interface wrapper for Link
Link* LinkFactory::make (
	unsigned long doc_id
	, const Topic& topic
	, RedactionID redaction_id
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return LinkFactoryManager::Singleton::instance ()->make (doc_id, topic, redaction_id);
}

Link* LinkFactory::make (
	const Document* document
	, unsigned long doc_id
	, const Topic& topic
	, RedactionID redaction_id
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return LinkFactoryManager::Singleton::instance ()->make (document, doc_id, topic, redaction_id);
}

// factory interface wrapper for ConsultingStateStub
ConsultingStateStub* ConsultingStateStubFactory::make_stub () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConsultingStateStubFactoryManager::Singleton::instance ()->make_stub ();
}

// factory interface wrapper for ConsultingStub
ConsultingStub* ConsultingStubFactory::make_consulting_stub () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConsultingStubFactoryManager::Singleton::instance ()->make_consulting_stub ();
}

// factory interface wrapper for DiffDocDataProvider
DiffDocDataProvider* DiffDocDataProviderFactory::make (
	const Document* left
	, const Document* right
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, AllChangesInTables)*/ {
	return DiffDocDataProviderFactoryManager::Singleton::instance ()->make (left, right);
}

// factory interface wrapper for ObjectFromLink
ObjectFromLink* ObjectFromLinkFactory::make (
	GblPilot::Link* server_link
	, LinkedObjectType key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ObjectFromLinkFactoryManager::Singleton::instance ()->make (server_link, key);
}


ObjectFromLinkFactory::KeySet* ObjectFromLinkFactory::keys () {
	return ObjectFromLinkFactoryManager::keys ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

