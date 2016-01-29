////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::PrimeQueryCard
// Заголовк реализации фабрик интерфеса  для серванта PrimeQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_PRIMEQUERYCARD_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_PRIMEQUERYCARD_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PrimeQueryCard
class PrimeQueryCard_factory: virtual public ::Core::RefCountObjectBase, virtual public QueryCardInfoAbstractFactory {
public:
	PrimeQueryCard_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	QueryCardInfo* create ();

};

typedef ::Core::Var<PrimeQueryCard_factory> PrimeQueryCard_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_PRIMEQUERYCARD_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

