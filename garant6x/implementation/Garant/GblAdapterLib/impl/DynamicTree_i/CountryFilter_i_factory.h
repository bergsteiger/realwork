////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CountryFilter_i
// Заголовк реализации фабрик интерфеса CountryFilter для серванта CountryFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_COUNTRYFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_COUNTRYFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i.h"

/// Servant-factory implementation for CountryFilter_i
namespace GblAdapterLib {
	class TreeBase; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class CountryFilter_iServantFactory {
	friend class TreeBase;

	static CountryFilter_i* make (const NodeBase* country);

	static CountryFilter_i* make ();
};

/// Interface-factory implementation for CountryFilter_i
class CountryFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public CountryFilterAbstractFactory {
	friend class CountryFilter_iServantFactory;

public:
	CountryFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static CountryFilter_i_factory* s_instance;

	const char* key () const;

	CountryFilter* make (const NodeBase* country);

	CountryFilter* make ();

};

typedef ::Core::Var<CountryFilter_i_factory> CountryFilter_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::CountryFilter_i> {
	typedef GblAdapterLib::CountryFilter_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_COUNTRYFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

