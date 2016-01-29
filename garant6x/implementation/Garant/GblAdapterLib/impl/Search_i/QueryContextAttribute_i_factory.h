////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryContextAttribute_i
// Заголовк реализации фабрик интерфеса QueryContextAttribute для серванта QueryContextAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCONTEXTATTRIBUTE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCONTEXTATTRIBUTE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i.h"

/// Servant-factory implementation for QueryContextAttribute_i
namespace GblAdapterLib {
	class QueryHelper; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class QueryContextAttribute_iServantFactory {
	friend class QueryHelper;

	static QueryContextAttribute_i* make (AttributeTag_const attribute_tag);
};

/// Interface-factory implementation for QueryContextAttribute_i
class QueryContextAttribute_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public QueryContextAttributeAbstractFactory
{
	friend class QueryContextAttribute_iServantFactory;

public:
	QueryContextAttribute_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static QueryContextAttribute_i_factory* s_instance;

	const char* key () const;

	QueryContextAttribute* make (AttributeTag_const attribute_tag);

};

typedef ::Core::Var<QueryContextAttribute_i_factory> QueryContextAttribute_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::QueryContextAttribute_i> {
	typedef GblAdapterLib::QueryContextAttribute_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCONTEXTATTRIBUTE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

