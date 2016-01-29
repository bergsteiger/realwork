////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::UserJournal_i
// Заголовок реализации класса серванта для интерфеса UserJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_USERJOURNAL_I_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_USERJOURNAL_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal.h"

namespace GblAdapterLib {

class UserJournal_i; // self forward Var
typedef ::Core::Var<UserJournal_i> UserJournal_i_var;
typedef ::Core::Var<const UserJournal_i> UserJournal_i_cvar;

class UserJournal_i_factory;

class UserJournal_i:
	virtual public UserJournal
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (UserJournal_i)
	friend class UserJournal_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <UserJournal_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UserJournal_i, ACE_SYNCH_RECURSIVE_MUTEX>;


//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:

	class BookmarkJournalTypeTranslator : 
		public Core::UnsortedTypeConverter<BookmarkJournalType, GblUserJournalDef::JournalObjectType> {
		protected:
			void fill_array () {
				//#UC START# *4A82B8B80206_FILL_ARRAY_IMPLEMENTATION*
				this->add (BJT_BOOKMARK, GblUserJournalDef::JOT_DOCUMENT);
				this->add (BJT_PHARM_BOOKMARK, GblUserJournalDef::JOT_PHARM_DOCUMENT);
				//#UC END# *4A82B8B80206_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class BookmarkJournalTypeTranslator

	typedef ACE_Singleton<BookmarkJournalTypeTranslator, ACE_SYNCH_NULL_MUTEX> BookmarkJournalTypeTranslatorSingleton;


	class QueryJournalTypeTranslator : 
		public Core::UnsortedTypeConverter<QueryType, GblUserJournalDef::JournalObjectType> {
		protected:
			void fill_array () {
				//#UC START# *4A839F050167_FILL_ARRAY_IMPLEMENTATION*
				this->add (QT_ATTRIBUTE, GblUserJournalDef::JOT_ATTRIBUTE);
				this->add (QT_KEYWORD, GblUserJournalDef::JOT_KW);
				this->add (QT_PUBLISHED_SOURCE, GblUserJournalDef::JOT_PUBLISHED_SOURCE);
				this->add (QT_REVIEW, GblUserJournalDef::JOT_REVIEW);
				this->add (QT_BASE_SEARCH, GblUserJournalDef::JOT_BASE_SEARCH);
				this->add (QT_PHARM_SEARCH, GblUserJournalDef::JOT_PHARM_SEARCH);
				//#UC END# *4A839F050167_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class QueryJournalTypeTranslator

	typedef ACE_Singleton<QueryJournalTypeTranslator, ACE_SYNCH_NULL_MUTEX> QueryJournalTypeTranslatorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UserJournal_i ();

	virtual ~UserJournal_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Рут дерева журнала
	mutable RealNodeRoot_var m_root;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UserJournal
	// Очистить Журнал работы (аналогичен вызову remove (рут дерева журнала работы)
	virtual void clear () const;

	// implemented method from UserJournal
	// список закладок заданного типа
	virtual JournalBookmarkList* get_bookmark_history (
		BookmarkJournalType type
		, long max_count
	) const /*throw (
		CanNotFindData
	)*/;

	// implemented method from UserJournal
	// Получит список запросов заданного типа из Журнала
	virtual QueryList* get_query_history (QueryType query_type, long max_count) const /*throw (CanNotFindData)*/;

	// implemented method from UserJournal
	// Получить дерево Журнала работы
	virtual NodeBase* get_user_jornal_tree () const;

	// implemented method from UserJournal
	// Удалить объект из журнала работы
	virtual void remove (const NodeBase* obj) const;

	// implemented method from UserJournal
	// Сохранить объект в журнал работы
	virtual void save (const Core::IObject* obj, JournalObjectType object_type) const;
}; // class UserJournal_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_USERJOURNAL_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
