////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryContextAttribute_i
// Заголовок реализации класса серванта для интерфеса QueryContextAttribute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCONTEXTATTRIBUTE_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCONTEXTATTRIBUTE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryAttribute_i.h"

namespace GblAdapterLib {

class QueryContextAttribute_i; // self forward Var
typedef ::Core::Var<QueryContextAttribute_i> QueryContextAttribute_i_var;
typedef ::Core::Var<const QueryContextAttribute_i> QueryContextAttribute_i_cvar;

class QueryContextAttribute_i_factory;

class QueryContextAttribute_i:
	virtual public QueryContextAttribute
	, virtual public QueryAttribute_i
{
	SET_OBJECT_COUNTER (QueryContextAttribute_i)
	friend class QueryContextAttribute_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryContextAttribute_i (AttributeTag_const attribute_tag);

	virtual ~QueryContextAttribute_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ContextValueList m_values;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryAttribute
	virtual void clear ();

	// implemented method from QueryContextAttribute
	virtual void add_value (QueryLogicOperation operation, GCI::IO::String* context);

	// implemented method from QueryContextAttribute
	virtual const ContextValueList& get_values () const;
}; // class QueryContextAttribute_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCONTEXTATTRIBUTE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
