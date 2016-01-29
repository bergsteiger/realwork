////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::QueryFilter_i
// Заголовок реализации класса серванта для интерфеса QueryFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_QUERYFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_QUERYFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterface.h"

namespace GblAdapterLib {

class QueryFilter_i; // self forward Var
typedef ::Core::Var<QueryFilter_i> QueryFilter_i_var;
typedef ::Core::Var<const QueryFilter_i> QueryFilter_i_cvar;

class QueryFilter_i_factory;

class QueryFilter_i:
	virtual public QueryFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (QueryFilter_i)
	friend class QueryFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryFilter_i (FilterFromQuery* data);

	QueryFilter_i (FiltersFromQuery& data);

	QueryFilter_i ();

	virtual ~QueryFilter_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void insert_data (size_t index, FilterFromQuery* data);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblPilotQueryDef::FilterList m_list;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryFilter
	// список подзапросов для построения запроса
	virtual const GblPilotQueryDef::FilterList& query_list () const;
}; // class QueryFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_QUERYFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
