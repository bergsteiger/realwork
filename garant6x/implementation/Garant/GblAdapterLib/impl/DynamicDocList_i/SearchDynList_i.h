////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::SearchDynList_i
// Заголовок реализации класса серванта для интерфеса SearchDynList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_SEARCHDYNLIST_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_SEARCHDYNLIST_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garantServer/src/Business/GblPilot/GblDocListC.h"

namespace GblAdapterLib {

class SearchDynList_i; // self forward Var
typedef ::Core::Var<SearchDynList_i> SearchDynList_i_var;
typedef ::Core::Var<const SearchDynList_i> SearchDynList_i_cvar;

class SearchDynList_i_factory;

class SearchDynList_i:
	virtual public SearchDynList
	, virtual public SearchEntity_i
{
	SET_OBJECT_COUNTER (SearchDynList_i)
	friend class SearchDynList_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SearchDynList_i (GblPilot::SearchDocList* search_doc_list);

	virtual ~SearchDynList_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblDocList::DocListTree_var m_doc_list_tree;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from SearchDynList
	virtual DynList* get_dyn_list () const;
}; // class SearchDynList_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_SEARCHDYNLIST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
