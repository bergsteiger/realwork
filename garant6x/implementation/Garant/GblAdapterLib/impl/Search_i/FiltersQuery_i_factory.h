////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FiltersQuery_i
// Заголовк реализации фабрик интерфеса FiltersQuery для серванта FiltersQuery_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERY_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERY_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for FiltersQuery_i
class FiltersQuery_i_factory: virtual public ::Core::RefCountObjectBase, virtual public FiltersQueryAbstractFactory {
public:
	FiltersQuery_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	FiltersQuery* make (FilterFromQuery* filter);

};

typedef ::Core::Var<FiltersQuery_i_factory> FiltersQuery_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERY_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

