////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::SearchProgressIndicator
//
// Прогрессиндикаторы для поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator {

class CancelSearch;
typedef ::Core::Var<CancelSearch> CancelSearch_var;
typedef ::Core::Var<const CancelSearch> CancelSearch_cvar;
class CancelSearch
	: virtual public CancelLongProcess
{
};

/// factory interface for CancelSearch
class CancelSearchFactory {
public:
	static CancelSearch* make (GblPilot::SearchManager* search_manager)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ProgressIndicatorForSearch;
typedef ::Core::Var<ProgressIndicatorForSearch> ProgressIndicatorForSearch_var;
typedef ::Core::Var<const ProgressIndicatorForSearch> ProgressIndicatorForSearch_cvar;
class ProgressIndicatorForSearch
	: virtual public ProgressIndicator
{
public:
	virtual void finish_process (const SearchEntity* entity) const = 0;
};

} // namespace SearchProgressIndicator
} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SearchProgressIndicator::CancelSearch> {
	typedef GblAdapterLib::SearchProgressIndicator::CancelSearchFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
