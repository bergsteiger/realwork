////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterFromQuery_i
// Заголовк реализации фабрик интерфеса FilterFromQuery для серванта FilterFromQuery_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERFROMQUERY_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERFROMQUERY_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/FiltersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/Filters_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for FilterFromQuery_i
class FilterFromQuery_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public FilterFromQueryAbstractFactory
{
public:
	FilterFromQuery_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	FilterFromQuery* make (const GblFilters::Filter& filter);

};

typedef ::Core::Var<FilterFromQuery_i_factory> FilterFromQuery_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERFROMQUERY_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

