////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCreator_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryCreator_i
// Заголовок реализации класса серванта для интерфеса QueryCreator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCREATOR_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCREATOR_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

class QueryCreator_i; // self forward Var
typedef ::Core::Var<QueryCreator_i> QueryCreator_i_var;
typedef ::Core::Var<const QueryCreator_i> QueryCreator_i_cvar;

class QueryCreator_i_factory;

class QueryCreator_i:
	virtual public QueryCreator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (QueryCreator_i)
	friend class QueryCreator_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <QueryCreator_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryCreator_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryCreator_i ();

	virtual ~QueryCreator_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryCreator
	virtual Query* make_query (const GblPilotQueryDef::Query& query) const;

	// implemented method from QueryCreator
	virtual Query* make_query (
		GblFolders::SavedQuery* saved_query
		, bool load_on_demand
		, FoldersNode* folders_node
	) const;

	// implemented method from QueryCreator
	virtual Query* make_query (GblUserJournal::JournalQuery* journal_query) const;
}; // class QueryCreator_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCREATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
