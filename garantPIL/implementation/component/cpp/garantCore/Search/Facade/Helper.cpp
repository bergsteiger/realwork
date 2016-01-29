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
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/BaseCache.h"
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/AdapterLoader.h"
#include "garantCore/Search/Cache/Cache.h"
#include "garantCore/Search/ContextSearch/RequestSplit.h"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// релевантные фрагменты
SearchAdapterLib::Adapter::IFragments* Helper::get_fragments (SearchBase* base, const char* in, long doc_id, long para) {
	//#UC START# *5103B6ED0254*
	GDS_ASSERT (para >= 0);

	unsigned long word = 0, first_word = 0;
	base->get_words (para, doc_id, word, first_word);

	SearchAdapterLib::Adapter::ISearcher_var searcher = get_searcher (base, doc_id);
	GDS_ASSERT (searcher.is_nil () == false);

	return (searcher.is_nil ())? 0 : searcher->get_fragments (in, doc_id, word, first_word);
	//#UC END# *5103B6ED0254*
}

// позиции релевантных фрагментов
SearchAdapterLib::Adapter::IPositions* Helper::get_positions (SearchBase* base, const GCL::StrVector& reqs, long doc_id) {
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

// searcher
SearchAdapterLib::Adapter::ISearcher* Helper::get_searcher (SearchBase* base, long id) {
	//#UC START# *515D9A96038F*
	GDS_ASSERT (base);

	Morpho::Def::ICache* cache = BaseCache::instance ()->get_morpho_cache_ptr ();
	cache->load (base->abstract_base (), true);

	std::string src = ContextPartsHelper::get_context_index_name (id);
	return SearchAdapter::instance ()->get (base->abstract_base (), cache, src);
	//#UC END# *515D9A96038F*
}

// загрузка memcache
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
	//#UC END# *5103C15E00CC*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

