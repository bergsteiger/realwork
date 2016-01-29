////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryNodeAttribute_i
// Заголовк реализации фабрик интерфеса QueryNodeAttribute для серванта QueryNodeAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYNODEATTRIBUTE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYNODEATTRIBUTE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i.h"

/// Servant-factory implementation for QueryNodeAttribute_i
namespace GblAdapterLib {
	class QueryHelper; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class QueryNodeAttribute_iServantFactory {
	friend class QueryHelper;

	static QueryNodeAttribute_i* make (AttributeTag_const attribute_tag);
};

/// Interface-factory implementation for QueryNodeAttribute_i
class QueryNodeAttribute_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public QueryNodeAttributeAbstractFactory
{
	friend class QueryNodeAttribute_iServantFactory;

public:
	QueryNodeAttribute_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static QueryNodeAttribute_i_factory* s_instance;

	const char* key () const;

	QueryNodeAttribute* make (AttributeTag_const attribute_tag);

};

typedef ::Core::Var<QueryNodeAttribute_i_factory> QueryNodeAttribute_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::QueryNodeAttribute_i> {
	typedef GblAdapterLib::QueryNodeAttribute_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYNODEATTRIBUTE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

