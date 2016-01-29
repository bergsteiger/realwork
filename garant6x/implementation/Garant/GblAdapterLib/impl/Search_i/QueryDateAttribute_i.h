////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryDateAttribute_i
// Заголовок реализации класса серванта для интерфеса QueryDateAttribute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYDATEATTRIBUTE_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYDATEATTRIBUTE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryAttribute_i.h"

namespace GblAdapterLib {

class QueryDateAttribute_i; // self forward Var
typedef ::Core::Var<QueryDateAttribute_i> QueryDateAttribute_i_var;
typedef ::Core::Var<const QueryDateAttribute_i> QueryDateAttribute_i_cvar;

class QueryDateAttribute_i_factory;

class QueryDateAttribute_i:
	virtual public QueryDateAttribute
	, virtual public QueryAttribute_i
{
	SET_OBJECT_COUNTER (QueryDateAttribute_i)
	friend class QueryDateAttribute_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryDateAttribute_i (AttributeTag_const attribute_tag);

	virtual ~QueryDateAttribute_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DateValueList m_values;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryAttribute
	virtual void clear ();

	// implemented method from QueryDateAttribute
	virtual void add_value (QueryLogicOperation operation, const Date& from, const Date& to);

	// implemented method from QueryDateAttribute
	virtual const DateValueList& get_values () const;
}; // class QueryDateAttribute_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYDATEATTRIBUTE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
