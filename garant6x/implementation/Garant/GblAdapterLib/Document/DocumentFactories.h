////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for MissingInfo

class MissingInfoAbstractFactory;

/// factory manager for MissingInfo
class MissingInfoFactoryManager {
public:
	static void register_factory (MissingInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MissingInfoFactoryManager ();
	
	~MissingInfoFactoryManager ();
	
	void register_factory_i (MissingInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MissingInfo* make (const GCD::PID& pid) /*throw (Core::Root::NoActiveFactory)*/;

	friend class MissingInfoFactory;
	typedef ACE_Singleton <MissingInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MissingInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MissingInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MissingInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for MissingInfo
class MissingInfoAbstractFactory : virtual public Core::IObject {
	friend class MissingInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MissingInfo* make (const GCD::PID& pid) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DiffIterator

class DiffIteratorAbstractFactory;

/// factory manager for DiffIterator
class DiffIteratorFactoryManager {
public:
	static void register_factory (DiffIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DiffIteratorFactoryManager ();
	
	~DiffIteratorFactoryManager ();
	
	void register_factory_i (DiffIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DiffIterator* make (const GblPilot::DiffData& diff_data) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DiffIteratorFactory;
	typedef ACE_Singleton <DiffIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DiffIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DiffIteratorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DiffIteratorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DiffIterator
class DiffIteratorAbstractFactory : virtual public Core::IObject {
	friend class DiffIteratorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DiffIterator* make (const GblPilot::DiffData& diff_data) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for FoundContext

class FoundContextAbstractFactory;

/// factory manager for FoundContext
class FoundContextFactoryManager {
public:
	static void register_factory (FoundContextAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FoundContextFactoryManager ();
	
	~FoundContextFactoryManager ();
	
	void register_factory_i (FoundContextAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FoundContext* make (const GblPilot::ContextList& list) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FoundContextFactory;
	typedef ACE_Singleton <FoundContextFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FoundContextFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FoundContextAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FoundContextAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FoundContext
class FoundContextAbstractFactory : virtual public Core::IObject {
	friend class FoundContextFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FoundContext* make (const GblPilot::ContextList& list) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DocumentTextProvider

class DocumentTextProviderAbstractFactory;

/// factory manager for DocumentTextProvider
class DocumentTextProviderFactoryManager {
public:
	static void register_factory (DocumentTextProviderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DocumentTextProviderFactoryManager ();
	
	~DocumentTextProviderFactoryManager ();
	
	void register_factory_i (DocumentTextProviderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DocumentTextProvider* make (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	) /*throw (Core::Root::NoActiveFactory)*/;

	DocumentTextProvider* make (
		GblPilot::Document* server_doc
		, unsigned long handle
		, bool all_at_once
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DocumentTextProviderFactory;
	typedef ACE_Singleton <DocumentTextProviderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DocumentTextProviderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DocumentTextProviderAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DocumentTextProviderAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DocumentTextProvider
class DocumentTextProviderAbstractFactory : virtual public Core::IObject {
	friend class DocumentTextProviderFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DocumentTextProvider* make (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	) = 0;

	virtual DocumentTextProvider* make (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Document

class DocumentAbstractFactory;

/// factory manager for Document
class DocumentFactoryManager {
public:
	static void register_factory (DocumentAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static DocumentFactory::KeySet* keys ();

protected:
	DocumentFactoryManager ();
	
	~DocumentFactoryManager ();
	
	void register_factory_i (DocumentAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Document* make (GblPilot::Document* document, FactoryKey key) /*throw (Core::Root::UnknownFactoryKey)*/;

	Document* make (
		const GCD::PID& pid
		, bool is_edition
		, const char* name
		, FactoryKey key
	) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class DocumentFactory;
	typedef ACE_Singleton <DocumentFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DocumentFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DocumentAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <FactoryKey, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DocumentAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Document
class DocumentAbstractFactory : virtual public Core::IObject {
	friend class DocumentFactoryManager;
protected:
	virtual const FactoryKey key () const = 0;

	virtual Document* make (GblPilot::Document* document) = 0;

	virtual Document* make (const GCD::PID& pid, bool is_edition, const char* name) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Bookmark

class BookmarkAbstractFactory;

/// factory manager for Bookmark
class BookmarkFactoryManager {
public:
	static void register_factory (BookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	BookmarkFactoryManager ();
	
	~BookmarkFactoryManager ();
	
	void register_factory_i (BookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Bookmark* make (
		const GblPilotDef::Bookmark& bookmark
		, GblFolders::DocBookmark* doc_bookmark
		, FoldersNode* folders_node
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class BookmarkFactory;
	typedef ACE_Singleton <BookmarkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BookmarkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BookmarkAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BookmarkAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Bookmark
class BookmarkAbstractFactory : virtual public Core::IObject {
	friend class BookmarkFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Bookmark* make (
		const GblPilotDef::Bookmark& bookmark
		, GblFolders::DocBookmark* doc_bookmark
		, FoldersNode* folders_node
	) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DocumentState

class DocumentStateAbstractFactory;

/// factory manager for DocumentState
class DocumentStateFactoryManager {
public:
	static void register_factory (DocumentStateAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DocumentStateFactoryManager ();
	
	~DocumentStateFactoryManager ();
	
	void register_factory_i (DocumentStateAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DocumentState* make (Document* source_doc) /*throw (Core::Root::NoActiveFactory)*/;

	DocumentState* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class DocumentStateFactory;
	typedef ACE_Singleton <DocumentStateFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DocumentStateFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DocumentStateAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DocumentStateAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DocumentState
class DocumentStateAbstractFactory : virtual public Core::IObject {
	friend class DocumentStateFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DocumentState* make (Document* source_doc) = 0;

	virtual DocumentState* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for JournalBookmark

class JournalBookmarkAbstractFactory;

/// factory manager for JournalBookmark
class JournalBookmarkFactoryManager {
public:
	static void register_factory (JournalBookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	JournalBookmarkFactoryManager ();
	
	~JournalBookmarkFactoryManager ();
	
	void register_factory_i (JournalBookmarkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	JournalBookmark* make (ObjectId doc_id, ParaId para_id) /*throw (Core::Root::NoActiveFactory)*/;

	JournalBookmark* make (GblUserJournal::JournalBookmark* journal_bookmark) /*throw (Core::Root::NoActiveFactory)*/;

	friend class JournalBookmarkFactory;
	typedef ACE_Singleton <JournalBookmarkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <JournalBookmarkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<JournalBookmarkAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<JournalBookmarkAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for JournalBookmark
class JournalBookmarkAbstractFactory : virtual public Core::IObject {
	friend class JournalBookmarkFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual JournalBookmark* make (ObjectId doc_id, ParaId para_id) = 0;

	virtual JournalBookmark* make (GblUserJournal::JournalBookmark* journal_bookmark) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Link

class LinkAbstractFactory;

/// factory manager for Link
class LinkFactoryManager {
public:
	static void register_factory (LinkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LinkFactoryManager ();
	
	~LinkFactoryManager ();
	
	void register_factory_i (LinkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Link* make (
		unsigned long doc_id
		, const Topic& topic
		, RedactionID redaction_id
	) /*throw (Core::Root::NoActiveFactory)*/;

	Link* make (
		const Document* document
		, unsigned long doc_id
		, const Topic& topic
		, RedactionID redaction_id
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class LinkFactory;
	typedef ACE_Singleton <LinkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LinkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LinkAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LinkAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Link
class LinkAbstractFactory : virtual public Core::IObject {
	friend class LinkFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Link* make (unsigned long doc_id, const Topic& topic, RedactionID redaction_id) = 0;

	virtual Link* make (const Document* document, unsigned long doc_id, const Topic& topic, RedactionID redaction_id) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ConsultingStateStub

class ConsultingStateStubAbstractFactory;

/// factory manager for ConsultingStateStub
class ConsultingStateStubFactoryManager {
public:
	static void register_factory (ConsultingStateStubAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConsultingStateStubFactoryManager ();
	
	~ConsultingStateStubFactoryManager ();
	
	void register_factory_i (ConsultingStateStubAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ConsultingStateStub* make_stub () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConsultingStateStubFactory;
	typedef ACE_Singleton <ConsultingStateStubFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultingStateStubFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConsultingStateStubAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConsultingStateStubAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ConsultingStateStub
class ConsultingStateStubAbstractFactory : virtual public Core::IObject {
	friend class ConsultingStateStubFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ConsultingStateStub* make_stub () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ConsultingStub

class ConsultingStubAbstractFactory;

/// factory manager for ConsultingStub
class ConsultingStubFactoryManager {
public:
	static void register_factory (ConsultingStubAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConsultingStubFactoryManager ();
	
	~ConsultingStubFactoryManager ();
	
	void register_factory_i (ConsultingStubAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ConsultingStub* make_consulting_stub () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConsultingStubFactory;
	typedef ACE_Singleton <ConsultingStubFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultingStubFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConsultingStubAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConsultingStubAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ConsultingStub
class ConsultingStubAbstractFactory : virtual public Core::IObject {
	friend class ConsultingStubFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ConsultingStub* make_consulting_stub () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DiffDocDataProvider

class DiffDocDataProviderAbstractFactory;

/// factory manager for DiffDocDataProvider
class DiffDocDataProviderFactoryManager {
public:
	static void register_factory (DiffDocDataProviderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DiffDocDataProviderFactoryManager ();
	
	~DiffDocDataProviderFactoryManager ();
	
	void register_factory_i (DiffDocDataProviderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DiffDocDataProvider* make (
		const Document* left
		, const Document* right
	) /*throw (Core::Root::NoActiveFactory, AllChangesInTables)*/;

	friend class DiffDocDataProviderFactory;
	typedef ACE_Singleton <DiffDocDataProviderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DiffDocDataProviderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DiffDocDataProviderAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DiffDocDataProviderAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DiffDocDataProvider
class DiffDocDataProviderAbstractFactory : virtual public Core::IObject {
	friend class DiffDocDataProviderFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DiffDocDataProvider* make (const Document* left, const Document* right) /*throw (AllChangesInTables)*/ = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ObjectFromLink

class ObjectFromLinkAbstractFactory;

/// factory manager for ObjectFromLink
class ObjectFromLinkFactoryManager {
public:
	static void register_factory (ObjectFromLinkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static ObjectFromLinkFactory::KeySet* keys ();

protected:
	ObjectFromLinkFactoryManager ();
	
	~ObjectFromLinkFactoryManager ();
	
	void register_factory_i (ObjectFromLinkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ObjectFromLink* make (GblPilot::Link* server_link, LinkedObjectType key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class ObjectFromLinkFactory;
	typedef ACE_Singleton <ObjectFromLinkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ObjectFromLinkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ObjectFromLinkAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <LinkedObjectType, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ObjectFromLinkAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ObjectFromLink
class ObjectFromLinkAbstractFactory : virtual public Core::IObject {
	friend class ObjectFromLinkFactoryManager;
protected:
	virtual const LinkedObjectType key () const = 0;

	virtual ObjectFromLink* make (GblPilot::Link* server_link) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

