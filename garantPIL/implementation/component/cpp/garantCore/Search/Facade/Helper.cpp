////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Facade/Helper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Facade::Helper
//
// Помощник
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Facade/Helper.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/AdapterLoader.h"
#include "garantCore/Search/Cache/Cache.h"
#include "garantCore/Search/ContextSearch/RequestSplit.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/DBComm.h"

//#UC START# *5103B47A00C4_CUSTOM_INCLUDES*
#include <boost/scoped_ptr.hpp>
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/ContextPartsHelper.h"
//#UC END# *5103B47A00C4_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *5103B47A00C4*
SearchAdapterLib::Adapter::ISearcher* get_searcher (Base* base, long id) {
	DBCore::IBase_var _base = DBCore::DBFactory::make (base);
	return SearchAdapter::instance ()->get (_base.in (), ContextPartsHelper::get_context_index_name (id));
}

static ContextSearch::Defs::PosPair* get_pos_pair (Base* base, long id, long para) {
	GDS_ASSERT (para >= 0);

	Core::Aptr <ContextSearch::Defs::PosPair> ret = new ContextSearch::Defs::PosPair ();

	long ids_size = 0, size = 0;

	Core::Aptr <long, DataDestructor> para_ids;
	para_ids = reinterpret_cast <long*> (base->LoadAttrEx (id, IDD2_PARAIDS, ids_size));

	if (para_ids.is_nil () == false) {
		std::string src = ContextPartsHelper::get_swords_index_name (id);
		Core::Aptr <char, Core::ArrayDeleteDestructor <char> > buffer = base->get_swords_data (src, id, size);

		if (size) {
			const char* buf = buffer.in ();
			::memcpy (&(ret->first), buf, 3);

			const long* beg = para_ids.in ();
			const long* end = beg + (ids_size / sizeof (long));
			const long* loc = std::find (beg, end, para);

			if (loc != end) {
				::memcpy (&(ret->second), buf + 3 * std::min <size_t> (std::distance (beg, loc), size / 3), 3);
			}
		}
	}

	return ret._retn ();
}
//#UC END# *5103B47A00C4*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// релевантные фрагменты
SearchAdapterLib::Adapter::IFragments* Helper::get_fragments (Base* base, const char* in, long doc_id, long para) {
	//#UC START# *5103B6ED0254*
	SearchAdapterLib::Adapter::ISearcher_var searcher = get_searcher (base, doc_id);
	GDS_ASSERT (searcher.is_nil () == false);

	boost::scoped_ptr <ContextSearch::Defs::PosPair> pair (get_pos_pair (base, doc_id, para));
	return (searcher.is_nil ())? 0 : searcher->get_fragments (in, doc_id, *pair);
	//#UC END# *5103B6ED0254*
}

// позиции релевантных фрагментов
SearchAdapterLib::Adapter::IPositions* Helper::get_positions (Base* base, const GCL::StrVector& reqs, long doc_id) {
	//#UC START# *5103B6460034*
	SearchAdapterLib::Adapter::ISearcher_var searcher = get_searcher (base, doc_id);
	GDS_ASSERT (searcher.is_nil () == false);

	SearchAdapterLib::Adapter::IPositions_var ret = searcher->get_positions (reqs, doc_id);

	if ((ret.is_nil () || ret->data ().empty ()) && reqs.size () == 1) {
		std::string name_part, text_part;

		if (RequestSplit (base).execute (reqs [0], name_part, text_part)) {
			ret = searcher->get_positions (GCL::StrVector (1, text_part), doc_id);
		}
	}

	return ret._retn ();
	//#UC END# *5103B6460034*
}

// memcache
void Helper::load_memcache (const SearchAdapterLib::Adapter::MemCacheSettings& settings) {
	//#UC START# *52BAF12602BA*
	SearchAdapter::instance ()->load_memcache (settings);
	//#UC END# *52BAF12602BA*
}

// очистка кэшей
void Helper::reset () {
	//#UC START# *5103C15E00CC*
	SearchAdapter::instance ()->reset ();
	Cache::instance ()->reset ();
	Morpho::release_cache ();
	ContextPartsHelper::fini ();
	//#UC END# *5103C15E00CC*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

