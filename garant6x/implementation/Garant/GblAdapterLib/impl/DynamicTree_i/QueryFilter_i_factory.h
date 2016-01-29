////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::QueryFilter_i
// Заголовк реализации фабрик интерфеса QueryFilter для серванта QueryFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_QUERYFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_QUERYFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterfaceFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i.h"

/// Servant-factory implementation for QueryFilter_i
namespace GblAdapterLib {
	class TreeBase; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class QueryFilter_iServantFactory {
	friend class TreeBase;

	static QueryFilter_i* make (FilterFromQuery* data);

	static QueryFilter_i* make (FiltersFromQuery& data);

	static QueryFilter_i* make ();
};

/// Interface-factory implementation for QueryFilter_i
class QueryFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public QueryFilterAbstractFactory {
	friend class QueryFilter_iServantFactory;

public:
	QueryFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static QueryFilter_i_factory* s_instance;

	const char* key () const;

	QueryFilter* make (FilterFromQuery* data);

	QueryFilter* make (FiltersFromQuery& data);

	QueryFilter* make ();

};

typedef ::Core::Var<QueryFilter_i_factory> QueryFilter_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::QueryFilter_i> {
	typedef GblAdapterLib::QueryFilter_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_QUERYFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

