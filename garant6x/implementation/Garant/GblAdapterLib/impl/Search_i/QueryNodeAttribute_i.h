////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryNodeAttribute_i
// Заголовок реализации класса серванта для интерфеса QueryNodeAttribute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYNODEATTRIBUTE_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYNODEATTRIBUTE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryAttribute_i.h"

namespace GblAdapterLib {

class QueryNodeAttribute_i; // self forward Var
typedef ::Core::Var<QueryNodeAttribute_i> QueryNodeAttribute_i_var;
typedef ::Core::Var<const QueryNodeAttribute_i> QueryNodeAttribute_i_cvar;

class QueryNodeAttribute_i_factory;

class QueryNodeAttribute_i:
	virtual public QueryNodeAttribute
	, virtual public QueryAttribute_i
{
	SET_OBJECT_COUNTER (QueryNodeAttribute_i)
	friend class QueryNodeAttribute_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryNodeAttribute_i (AttributeTag_const attribute_tag);

	virtual ~QueryNodeAttribute_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodeValueList m_values;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryAttribute
	virtual void clear ();

	// implemented method from QueryNodeAttribute
	virtual void add_value (QueryLogicOperation operation, NodeBase* node);

	// implemented method from QueryNodeAttribute
	virtual const NodeValueList& get_values () const;
}; // class QueryNodeAttribute_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYNODEATTRIBUTE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
