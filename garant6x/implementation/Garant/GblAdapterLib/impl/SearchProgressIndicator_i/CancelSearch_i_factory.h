////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::SearchProgressIndicator_i::CancelSearch_i
// Заголовк реализации фабрик интерфеса CancelSearch для серванта CancelSearch_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_I_CANCELSEARCH_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_I_CANCELSEARCH_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicatorFactories.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator_i {

/// Interface-factory implementation for CancelSearch_i
class CancelSearch_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public SearchProgressIndicator::CancelSearchAbstractFactory
{
public:
	CancelSearch_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	SearchProgressIndicator::CancelSearch* make (GblPilot::SearchManager* search_manager);

};

typedef ::Core::Var<CancelSearch_i_factory> CancelSearch_i_factory_var;

} // namespace SearchProgressIndicator_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_I_CANCELSEARCH_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

