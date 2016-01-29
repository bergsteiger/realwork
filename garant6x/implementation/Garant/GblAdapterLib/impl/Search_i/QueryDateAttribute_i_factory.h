////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryDateAttribute_i
// Заголовк реализации фабрик интерфеса QueryDateAttribute для серванта QueryDateAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYDATEATTRIBUTE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYDATEATTRIBUTE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i.h"

/// Servant-factory implementation for QueryDateAttribute_i
namespace GblAdapterLib {
	class QueryHelper; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class QueryDateAttribute_iServantFactory {
	friend class QueryHelper;

	static QueryDateAttribute_i* make (AttributeTag_const attribute_tag);
};

/// Interface-factory implementation for QueryDateAttribute_i
class QueryDateAttribute_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public QueryDateAttributeAbstractFactory
{
	friend class QueryDateAttribute_iServantFactory;

public:
	QueryDateAttribute_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static QueryDateAttribute_i_factory* s_instance;

	const char* key () const;

	QueryDateAttribute* make (AttributeTag_const attribute_tag);

};

typedef ::Core::Var<QueryDateAttribute_i_factory> QueryDateAttribute_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::QueryDateAttribute_i> {
	typedef GblAdapterLib::QueryDateAttribute_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYDATEATTRIBUTE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

