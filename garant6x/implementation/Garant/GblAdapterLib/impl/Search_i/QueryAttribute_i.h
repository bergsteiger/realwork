////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryAttribute_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryAttribute_i
// Заголовок реализации класса серванта для интерфеса QueryAttribute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYATTRIBUTE_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYATTRIBUTE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"

namespace GblAdapterLib {

class QueryAttribute_i; // self forward Var
typedef ::Core::Var<QueryAttribute_i> QueryAttribute_i_var;
typedef ::Core::Var<const QueryAttribute_i> QueryAttribute_i_cvar;

class QueryAttribute_i:
	virtual public QueryAttribute
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (QueryAttribute_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:

	QueryAttribute_i (QueryTagType tag_type, AttributeTag_const attribute_tag);

	virtual ~QueryAttribute_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_attribute_tag;

	QueryTagType m_tag_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryAttribute
	virtual AttributeTag_const get_tag () const;

	// implemented method from QueryAttribute
	virtual QueryTagType get_type () const;
}; // class QueryAttribute_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYATTRIBUTE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
