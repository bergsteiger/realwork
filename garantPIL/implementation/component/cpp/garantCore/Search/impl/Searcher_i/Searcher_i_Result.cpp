////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/Searcher_i_Result.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Searcher_i::Searcher_i::Result
//
// Результирующий список
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Searcher_i/Searcher_i.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collection_iterator.h"

//#UC START# *50DC3D6D03B7_CUSTOM_INCLUDES*
//#UC END# *50DC3D6D03B7_CUSTOM_INCLUDES*

namespace Search {
namespace Searcher_i {
class Searcher_i;
//#UC START# *50DC3D6D03B7*
bool truncation (SortedCollection* in, long sz) {
	if (in->Tag () == OT_RELECOLLECTION && sz > 0 && sz < in->ItemCount) {
		typedef fast_collection_iterator <SortedCollection, RefwRele, REL_COL_PAGE_SIZE> Iterator;
		std::partial_sort (Iterator (in, 0), Iterator (in, sz), Iterator (in, in->ItemCount), CompareByRel ());
		in->Cut (sz);
		return true;
	}
	return false;
}
//#UC END# *50DC3D6D03B7*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// фабрика
SearchResult* Searcher_i::Result::make (SortedCollection* in, long max_size) {
	//#UC START# *50DC3D95011F*
	Core::Aptr <SearchResult> ret = new SearchResult ();

	Core::Aptr <SortedCollection> list = in;

	if (list.is_nil () == false && list->ItemCount) {
		try {
			if (list->Tag () == OT_REFCOLLECTION) {
				((RefCollection*) (list.in ()))->InheritPress ();
			}

			if (list->Inflated ()) {
				list->Deflate ();
			}

			ret->full_size = list->ItemCount;
			ret->list = list._retn ();
			ret->is_cut = truncation (ret->list.inout (), max_size);
		} catch (...) {
			LOG_UEX ((GDS_CURRENT_FUNCTION));
		}
	}

	return ret._retn ();
	//#UC END# *50DC3D95011F*
}

// фабрика
SearchResult* Searcher_i::Result::make (bool is_interrupted) {
	//#UC START# *50DC471F0222*
	Core::Aptr <SearchResult> ret = new SearchResult ();
	ret->is_interrupted = is_interrupted;
	return ret._retn ();
	//#UC END# *50DC471F0222*
}

} // namespace Searcher_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

