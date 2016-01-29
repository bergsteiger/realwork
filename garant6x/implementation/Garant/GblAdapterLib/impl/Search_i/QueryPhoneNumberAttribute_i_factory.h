////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryPhoneNumberAttribute_i
// Заголовк реализации фабрик интерфеса QueryPhoneNumberAttribute для серванта QueryPhoneNumberAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYPHONENUMBERATTRIBUTE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYPHONENUMBERATTRIBUTE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i.h"

/// Servant-factory implementation for QueryPhoneNumberAttribute_i
namespace GblAdapterLib {
	class QueryHelper; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class QueryPhoneNumberAttribute_iServantFactory {
	friend class QueryHelper;

	static QueryPhoneNumberAttribute_i* make (AttributeTag_const attribute_tag);
};

/// Interface-factory implementation for QueryPhoneNumberAttribute_i
class QueryPhoneNumberAttribute_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public QueryPhoneNumberAttributeAbstractFactory
{
	friend class QueryPhoneNumberAttribute_iServantFactory;

public:
	QueryPhoneNumberAttribute_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static QueryPhoneNumberAttribute_i_factory* s_instance;

	const char* key () const;

	QueryPhoneNumberAttribute* make (AttributeTag_const attribute_tag);

};

typedef ::Core::Var<QueryPhoneNumberAttribute_i_factory> QueryPhoneNumberAttribute_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::QueryPhoneNumberAttribute_i> {
	typedef GblAdapterLib::QueryPhoneNumberAttribute_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYPHONENUMBERATTRIBUTE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

