////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// Типы элементов Журнала работы
enum JournalObjectType {
	JOT_BOOKMARK // Закладка
	, JOT_QUERY // Запрос
	, JOT_FOLDER // Папка
};

enum BookmarkJournalType {
	BJT_BOOKMARK // Закладки
	, BJT_PHARM_BOOKMARK // Закладки Инфарма
};

class UserJournal;
typedef ::Core::Var<UserJournal> UserJournal_var;
typedef ::Core::Var<const UserJournal> UserJournal_cvar;
// Интерфейс журанла работы
class UserJournal
	: virtual public ::Core::IObject
{
public:
	// Сохранить объект в журнал работы
	virtual void save (const Core::IObject* obj, JournalObjectType object_type) const = 0;

	// Удалить объект из журнала работы
	virtual void remove (const NodeBase* obj) const = 0;

	// Очистить Журнал работы (аналогичен вызову remove (рут дерева журнала работы)
	virtual void clear () const = 0;

	// Получить дерево Журнала работы
	virtual NodeBase* get_user_jornal_tree () const = 0;

	// список закладок заданного типа
	virtual JournalBookmarkList* get_bookmark_history (
		BookmarkJournalType type
		, long max_count
	) const /*throw (
		CanNotFindData
	)*/ = 0;

	// Получит список запросов заданного типа из Журнала
	virtual QueryList* get_query_history (QueryType query_type, long max_count) const /*throw (CanNotFindData)*/ = 0;
};

/// factory interface for UserJournal
class UserJournalFactory {
public:
	static UserJournal* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::UserJournal> {
	typedef GblAdapterLib::UserJournalFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
