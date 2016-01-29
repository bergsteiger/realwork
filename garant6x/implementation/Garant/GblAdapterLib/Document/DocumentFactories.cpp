////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/lexical_cast.hpp"
#include "boost/bind.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MissingInfo
bool MissingInfoFactoryManager::s_was_destroyed = false;

MissingInfoFactoryManager::MissingInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MissingInfoFactoryManager::~MissingInfoFactoryManager () {
	s_was_destroyed = true;
}

void MissingInfoFactoryManager::register_factory (
	MissingInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MissingInfoFactoryManager::register_factory_i (
	MissingInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::MissingInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MissingInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MissingInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MissingInfo* MissingInfoFactoryManager::make (const GCD::PID& pid) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::MissingInfoFactory");
	}
	MissingInfo* ret_ = m_single_active_factory->make (pid);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::MissingInfoFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DiffIterator
bool DiffIteratorFactoryManager::s_was_destroyed = false;

DiffIteratorFactoryManager::DiffIteratorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DiffIteratorFactoryManager::~DiffIteratorFactoryManager () {
	s_was_destroyed = true;
}

void DiffIteratorFactoryManager::register_factory (
	DiffIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DiffIteratorFactoryManager::register_factory_i (
	DiffIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::DiffIteratorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DiffIteratorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DiffIteratorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DiffIterator* DiffIteratorFactoryManager::make (const GblPilot::DiffData& diff_data) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::DiffIteratorFactory");
	}
	DiffIterator* ret_ = m_single_active_factory->make (diff_data);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::DiffIteratorFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FoundContext
bool FoundContextFactoryManager::s_was_destroyed = false;

FoundContextFactoryManager::FoundContextFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FoundContextFactoryManager::~FoundContextFactoryManager () {
	s_was_destroyed = true;
}

void FoundContextFactoryManager::register_factory (
	FoundContextAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FoundContextFactoryManager::register_factory_i (
	FoundContextAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::FoundContextFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FoundContextAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FoundContextAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FoundContext* FoundContextFactoryManager::make (const GblPilot::ContextList& list) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::FoundContextFactory");
	}
	FoundContext* ret_ = m_single_active_factory->make (list);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::FoundContextFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DocumentTextProvider
bool DocumentTextProviderFactoryManager::s_was_destroyed = false;

DocumentTextProviderFactoryManager::DocumentTextProviderFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DocumentTextProviderFactoryManager::~DocumentTextProviderFactoryManager () {
	s_was_destroyed = true;
}

void DocumentTextProviderFactoryManager::register_factory (
	DocumentTextProviderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DocumentTextProviderFactoryManager::register_factory_i (
	DocumentTextProviderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::DocumentTextProviderFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DocumentTextProviderAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DocumentTextProviderAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DocumentTextProvider* DocumentTextProviderFactoryManager::make (GblPilot::Document* server_doc, const GblPilot::HighlightHandle& handle, bool all_at_once) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::DocumentTextProviderFactory");
	}
	DocumentTextProvider* ret_ = m_single_active_factory->make (server_doc, handle, all_at_once);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::DocumentTextProviderFactory impl can't return zerro"));
	return ret_;
}

DocumentTextProvider* DocumentTextProviderFactoryManager::make (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::DocumentTextProviderFactory");
	}
	DocumentTextProvider* ret_ = m_single_active_factory->make (server_doc, handle, all_at_once);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::DocumentTextProviderFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Document
bool DocumentFactoryManager::s_was_destroyed = false;

DocumentFactoryManager::DocumentFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DocumentFactoryManager::~DocumentFactoryManager () {
	s_was_destroyed = true;
}

void DocumentFactoryManager::register_factory (
	DocumentAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

DocumentFactory::KeySet* DocumentFactoryManager::keys () {
	Core::Aptr<DocumentFactory::KeySet> keys (new DocumentFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void DocumentFactoryManager::register_factory_i (
	DocumentAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::DocumentFactory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DocumentAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DocumentAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Document* DocumentFactoryManager::make (GblPilot::Document* document, FactoryKey key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"GblAdapterLib::Document::DocumentFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make (document);
}

Document* DocumentFactoryManager::make (const GCD::PID& pid, bool is_edition, const char* name, FactoryKey key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"GblAdapterLib::Document::DocumentFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make (pid, is_edition, name);
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Bookmark
bool BookmarkFactoryManager::s_was_destroyed = false;

BookmarkFactoryManager::BookmarkFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BookmarkFactoryManager::~BookmarkFactoryManager () {
	s_was_destroyed = true;
}

void BookmarkFactoryManager::register_factory (
	BookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BookmarkFactoryManager::register_factory_i (
	BookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::BookmarkFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BookmarkAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BookmarkAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Bookmark* BookmarkFactoryManager::make (const GblPilotDef::Bookmark& bookmark, GblFolders::DocBookmark* doc_bookmark, FoldersNode* folders_node) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::BookmarkFactory");
	}
	Bookmark* ret_ = m_single_active_factory->make (bookmark, doc_bookmark, folders_node);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::BookmarkFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DocumentState
bool DocumentStateFactoryManager::s_was_destroyed = false;

DocumentStateFactoryManager::DocumentStateFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DocumentStateFactoryManager::~DocumentStateFactoryManager () {
	s_was_destroyed = true;
}

void DocumentStateFactoryManager::register_factory (
	DocumentStateAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DocumentStateFactoryManager::register_factory_i (
	DocumentStateAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::DocumentStateFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DocumentStateAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DocumentStateAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DocumentState* DocumentStateFactoryManager::make (Document* source_doc) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::DocumentStateFactory");
	}
	DocumentState* ret_ = m_single_active_factory->make (source_doc);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::DocumentStateFactory impl can't return zerro"));
	return ret_;
}

DocumentState* DocumentStateFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::DocumentStateFactory");
	}
	DocumentState* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::DocumentStateFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for JournalBookmark
bool JournalBookmarkFactoryManager::s_was_destroyed = false;

JournalBookmarkFactoryManager::JournalBookmarkFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

JournalBookmarkFactoryManager::~JournalBookmarkFactoryManager () {
	s_was_destroyed = true;
}

void JournalBookmarkFactoryManager::register_factory (
	JournalBookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void JournalBookmarkFactoryManager::register_factory_i (
	JournalBookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::JournalBookmarkFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = JournalBookmarkAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = JournalBookmarkAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

JournalBookmark* JournalBookmarkFactoryManager::make (ObjectId doc_id, ParaId para_id) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::JournalBookmarkFactory");
	}
	JournalBookmark* ret_ = m_single_active_factory->make (doc_id, para_id);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::JournalBookmarkFactory impl can't return zerro"));
	return ret_;
}

JournalBookmark* JournalBookmarkFactoryManager::make (GblUserJournal::JournalBookmark* journal_bookmark) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::JournalBookmarkFactory");
	}
	JournalBookmark* ret_ = m_single_active_factory->make (journal_bookmark);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::JournalBookmarkFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Link
bool LinkFactoryManager::s_was_destroyed = false;

LinkFactoryManager::LinkFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

LinkFactoryManager::~LinkFactoryManager () {
	s_was_destroyed = true;
}

void LinkFactoryManager::register_factory (
	LinkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void LinkFactoryManager::register_factory_i (
	LinkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::LinkFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = LinkAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = LinkAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Link* LinkFactoryManager::make (unsigned long doc_id, const Topic& topic, RedactionID redaction_id) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::LinkFactory");
	}
	Link* ret_ = m_single_active_factory->make (doc_id, topic, redaction_id);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::LinkFactory impl can't return zerro"));
	return ret_;
}

Link* LinkFactoryManager::make (const Document* document, unsigned long doc_id, const Topic& topic, RedactionID redaction_id) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::LinkFactory");
	}
	Link* ret_ = m_single_active_factory->make (document, doc_id, topic, redaction_id);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::LinkFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ConsultingStateStub
bool ConsultingStateStubFactoryManager::s_was_destroyed = false;

ConsultingStateStubFactoryManager::ConsultingStateStubFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ConsultingStateStubFactoryManager::~ConsultingStateStubFactoryManager () {
	s_was_destroyed = true;
}

void ConsultingStateStubFactoryManager::register_factory (
	ConsultingStateStubAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ConsultingStateStubFactoryManager::register_factory_i (
	ConsultingStateStubAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::ConsultingStateStubFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ConsultingStateStubAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ConsultingStateStubAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ConsultingStateStub* ConsultingStateStubFactoryManager::make_stub () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::ConsultingStateStubFactory");
	}
	ConsultingStateStub* ret_ = m_single_active_factory->make_stub ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::ConsultingStateStubFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ConsultingStub
bool ConsultingStubFactoryManager::s_was_destroyed = false;

ConsultingStubFactoryManager::ConsultingStubFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ConsultingStubFactoryManager::~ConsultingStubFactoryManager () {
	s_was_destroyed = true;
}

void ConsultingStubFactoryManager::register_factory (
	ConsultingStubAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ConsultingStubFactoryManager::register_factory_i (
	ConsultingStubAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::ConsultingStubFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ConsultingStubAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ConsultingStubAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ConsultingStub* ConsultingStubFactoryManager::make_consulting_stub () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::ConsultingStubFactory");
	}
	ConsultingStub* ret_ = m_single_active_factory->make_consulting_stub ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::ConsultingStubFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DiffDocDataProvider
bool DiffDocDataProviderFactoryManager::s_was_destroyed = false;

DiffDocDataProviderFactoryManager::DiffDocDataProviderFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DiffDocDataProviderFactoryManager::~DiffDocDataProviderFactoryManager () {
	s_was_destroyed = true;
}

void DiffDocDataProviderFactoryManager::register_factory (
	DiffDocDataProviderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DiffDocDataProviderFactoryManager::register_factory_i (
	DiffDocDataProviderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::DiffDocDataProviderFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DiffDocDataProviderAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DiffDocDataProviderAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DiffDocDataProvider* DiffDocDataProviderFactoryManager::make (const Document* left, const Document* right) /*throw (Core::Root::NoActiveFactory, AllChangesInTables)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document::DiffDocDataProviderFactory");
	}
	DiffDocDataProvider* ret_ = m_single_active_factory->make (left, right);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Document::DiffDocDataProviderFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ObjectFromLink
bool ObjectFromLinkFactoryManager::s_was_destroyed = false;

ObjectFromLinkFactoryManager::ObjectFromLinkFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ObjectFromLinkFactoryManager::~ObjectFromLinkFactoryManager () {
	s_was_destroyed = true;
}

void ObjectFromLinkFactoryManager::register_factory (
	ObjectFromLinkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

ObjectFromLinkFactory::KeySet* ObjectFromLinkFactoryManager::keys () {
	Core::Aptr<ObjectFromLinkFactory::KeySet> keys (new ObjectFromLinkFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void ObjectFromLinkFactoryManager::register_factory_i (
	ObjectFromLinkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Document::ObjectFromLinkFactory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ObjectFromLinkAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ObjectFromLinkAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ObjectFromLink* ObjectFromLinkFactoryManager::make (GblPilot::Link* server_link, LinkedObjectType key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"GblAdapterLib::Document::ObjectFromLinkFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make (server_link);
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

