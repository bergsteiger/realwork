////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/FiltersFactory.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Filters_i::FiltersFactory
//
// Фабрика
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FILTERS_I_FILTERSFACTORY_H__
#define __GARANTCORE_SEARCH_FILTERS_I_FILTERSFACTORY_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/index.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/Base.h"

namespace Search {

// Фабрика
class FiltersFactory {
	SET_OBJECT_COUNTER (FiltersFactory)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// фабрика
	static SearchAdapterLib::Adapter::IFilter* make (SortedCollection* in, MergeOp op);

	// фабрика
	static SearchAdapterLib::Adapter::IFilter* make (Index* index, const char* key, MergeOp op);

	// фабрика
	static SearchAdapterLib::Adapter::IFilter* make (Base* base, const char* name, const char* key, MergeOp op);

	// фабрика
	static IBooleanFilter* make (MergeOp op);

	// фабрика
	static SearchAdapterLib::Adapter::IFilter* make (const SearchAdapterLib::Adapter::LongVector& in, MergeOp op);

}; // class FiltersFactory

} // namespace Search


#endif //__GARANTCORE_SEARCH_FILTERS_I_FILTERSFACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

