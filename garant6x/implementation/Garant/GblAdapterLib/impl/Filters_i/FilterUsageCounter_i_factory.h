////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterUsageCounter_i
// Заголовк реализации фабрик интерфеса FiltersUsageCounter для серванта FilterUsageCounter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERUSAGECOUNTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERUSAGECOUNTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/FiltersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/Filters_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for FilterUsageCounter_i
class FilterUsageCounter_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public FiltersUsageCounterAbstractFactory
{
public:
	FilterUsageCounter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	FiltersUsageCounter* make ();

};

typedef ::Core::Var<FilterUsageCounter_i_factory> FilterUsageCounter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERUSAGECOUNTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

