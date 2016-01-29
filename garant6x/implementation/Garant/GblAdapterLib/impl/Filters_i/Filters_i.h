////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/Filters_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Filters_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_I_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <vector>
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseTypes_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"
#include "garantServer/src/Business/GblFilters/GblFiltersDefC.h"


namespace GblAdapterLib {

struct FilterInfo {
	long count;
	unsigned long flags;

	FilterInfo (unsigned long my_flags);
};

typedef std::vector < unsigned long > ErasedIds;

typedef std::map < unsigned long, FilterInfo > Counter;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

