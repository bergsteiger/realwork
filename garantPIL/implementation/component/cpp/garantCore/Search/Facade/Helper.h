////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Facade/Helper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Facade::Helper
//
// Помощник
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FACADE_HELPER_H__
#define __GARANTCORE_SEARCH_FACADE_HELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/Base.h"

//#UC START# *5103B47A00C4_CUSTOM_INCLUDES*
//#UC END# *5103B47A00C4_CUSTOM_INCLUDES*

namespace Search {

// Помощник
class Helper {
	SET_OBJECT_COUNTER (Helper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// релевантные фрагменты
	static SearchAdapterLib::Adapter::IFragments* get_fragments (Base* base, const char* in, long doc_id, long para);

	// позиции релевантных фрагментов
	static SearchAdapterLib::Adapter::IPositions* get_positions (Base* base, const GCL::StrVector& reqs, long doc_id);

	// memcache
	static void load_memcache (const SearchAdapterLib::Adapter::MemCacheSettings& settings);

	// очистка кэшей
	static void reset ();


//#UC START# *5103B47A00C4*
//#UC END# *5103B47A00C4*
}; // class Helper

} // namespace Search


#endif //__GARANTCORE_SEARCH_FACADE_HELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

