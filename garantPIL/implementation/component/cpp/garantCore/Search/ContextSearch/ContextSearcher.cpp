////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/ContextSearcher.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::ContextSearcher
//
// Контекстный поиск
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/ContextSearch/ContextSearcher.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_conv.h"
#include "garantCore/Search/impl/Filters_i/Filters.h"
#include "garantCore/Search/Cache/Cache.h"
#include "garantCore/Search/ContextSearch/RelevancyTuner.h"
#include "garantCore/Search/ContextSearch/RequestSplit.h"
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/AdapterLoader.h"
#include "garantCore/Search/ContextSearch/Progress_i.h"

//#UC START# *50ACE4D50116_CUSTOM_INCLUDES*
#include "boost/thread.hpp"

#include "DBComm.h"
#include "ContextPartsHelper.h"
//#UC END# *50ACE4D50116_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *50ACE4D50116*
SearchAdapterLib::Adapter::ISearcher* make_searcher (Base* base, const std::string& src) {
	DBCore::IBase_var _base = DBCore::DBFactory::make (base);
	return SearchAdapter::instance ()->get (_base.in (), src);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ThreadSearch {
public:
	ThreadSearch (const Collector_i::RequestData& data) {
		m_collector = new Collector_i (0, data);
	}

	typedef ContextSearch::Defs::Requests Requests;
	typedef ContextSearch::Defs::IFilter IFilter;

public:
	void execute (Base* base, const std::string& src, const Requests& reqs, IFilter* filter) {
		m_thread = boost::thread (boost::bind (&ThreadSearch::execute_, this, base, src, reqs, filter));
	}

	RefwReleCollection* _retn () {
		m_thread.join ();
		return m_collector->_retn ();
	}

private:
	ContextSearch::Defs::IFilter* make_filter (const std::string& src, IFilter* filter) {
		ContextSearch::Defs::IFilter_var _filter = (filter)? filter->duplicate () : 0;

		const std::vector <long>& data = ContextPartsHelper::get_changed_docs ();

		if (src != CONTEXT_INDEX_NAME && data.empty () == false) {
			BooleanFilter bool_filter;
			bool_filter << Filter (data, so_NOT) << _filter.in ();
			return bool_filter._retn ();
		} 

		return _filter._retn ();
	}

	void execute_ (Base* base, const std::string& src, const Requests& reqs, IFilter* filter) {
		ContextSearch::Defs::IFilter_var _filter = this->make_filter (src, filter);
		SearchAdapterLib::Adapter::ISearcher_var searcher = make_searcher (base, src);
		searcher->search (reqs, ContextSearch::Defs::SearchInfo (0, _filter.in ()), 0, m_collector.inout ());
	}

private:
	boost::thread m_thread;

	Core::Var <Collector_i> m_collector;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

RefwReleCollection* ContextSearcher::search (
	const std::string& src, const ContextSearch::Defs::Requests& reqs, ContextSearch::Defs::IFilter* filter
) {
	ContextSearch::Defs::SearchInfo info (m_info_collector, filter);

	BooleanFilter bool_filter;

	const std::vector <long>& data = ContextPartsHelper::get_changed_docs ();

	if (src != SIDE_INDEX_NAME && data.empty () == false) {
		bool_filter << Filter (data, so_NOT) << filter;
		info.filter = bool_filter.in ();
	}

	Core::Var <Collector_i> collector = new Collector_i (m_info_collector, m_request_data);

	SearchAdapterLib::Adapter::ISearcher_var searcher = make_searcher (m_base, src);
	searcher->search (reqs, info, m_progress.in (), collector.inout ());
	return collector->_retn ();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

RefwReleCollection* ContextSearcher::search (
	const ContextSearch::Defs::Requests& reqs, ContextSearch::Defs::IFilter* filter
) {
	Core::Aptr <RefwReleCollection> ret;

	if (ContextPartsHelper::is_parts () && m_src.size () > 1) {
		std::vector <ThreadSearch*> pool (m_src.size ());

		for (size_t i = 0; i < m_src.size (); ++i) {
			pool [i] = new ThreadSearch (m_request_data);
			pool [i]->execute (m_base, m_src [i], reqs, filter);
		}

		for (std::vector <ThreadSearch*>::const_iterator it = pool.begin (); it != pool.end (); ++it) {
			Core::Aptr <RefwReleCollection> res = (*it)->_retn ();

			if (ret.is_nil ()) {
				ret = res._retn ();
			} else if (res.is_nil () == false) {
				ret->Merge (*res.in ());
			}

			delete *it;
		}
	} else {
		for (GCL::StrVector::const_iterator it = m_src.begin (); it != m_src.end (); ++it) {
			Core::Aptr <RefwReleCollection> res = this->search (*it, reqs, filter);

			if (ret.is_nil ()) {
				ret = res._retn ();
			} else if (res.is_nil () == false) {
				ret->Merge (*res.in ());
			} 
		}
	}

	return ret._retn ();
}
//#UC END# *50ACE4D50116*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ContextSearcher::ContextSearcher (
	Base* base
	, SearchAdapterLib::Adapter::IRelevancyInfo* info
	, const GCL::StrVector& src
)
//#UC START# *50ED842E00B5_BASE_INIT*
	: m_base (base)
	, m_info_collector (info)
	, m_src (src)
//#UC END# *50ED842E00B5_BASE_INIT*
{
	//#UC START# *50ED842E00B5_BODY*
	m_progress = new Progress_i (base);

	if (m_src.empty ()) {
		ContextPartsHelper::get_context_parts_names (m_src, false);
	}
	//#UC END# *50ED842E00B5_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить контекст
void ContextSearcher::add (const QueryTag& tag) {
	//#UC START# *50AD0BD4000E*
	GDS_ASSERT (tag.key == BODY_TYPE || tag.key == TITLE_TYPE);

	ContextSearch::Defs::Request item;
	item.op = tag.op;
	item.btext = (tag.key == BODY_TYPE);
	item.context = tag.val;

	GCL::to_upper (item.context);
	m_requests.push_back (item);

	Collector_i::RequestData::iterator it;
	it = m_request_data.insert (Collector_i::RequestData::value_type (item.context, Collector_i::Data ())).first;

	Cache::instance ()->get_type_data (m_base, item.context, it->second.type);
	Cache::instance ()->get_code_data (m_base, item.context, it->second.code);
	//#UC END# *50AD0BD4000E*
}

// выполнить
SortedCollection* ContextSearcher::execute (SearchAdapterLib::Adapter::IFilter* filter) {
	//#UC START# *50ED5AD00196*
	if (m_requests.empty ()) {
		GDS_ASSERT (0);
		return 0;
	}

	size_t max_val = 100;

	Index* index = m_base->FindIndex (SIDE_INDEX_NAME.c_str ());

	if (index && index->KeyCount) {
		max_val = max_val >> 1;
	}

	SearchAdapterLib::Adapter::IFilter* _filter = (filter && filter->get_size ())? filter : 0;

	Core::Aptr <RefwReleCollection> res;

	if (m_requests.size () == 1 && m_info_collector == 0 && m_requests [0].btext) {
		ContextSearch::Defs::Requests requests (2);
		requests [0].btext = false;

		if (RequestSplit (m_base).execute (m_requests [0].context, requests [0].context, requests [1].context)) {
			m_progress->set_border (max_val / 3);
			res = this->search (requests, _filter);
		}
	}

	if (res.is_nil ()) {
		m_progress->set_border (max_val / m_requests.size ());
	}

	Core::Aptr <RefwReleCollection> ret = this->search (m_requests, _filter);

	if (ret.is_nil () || ret->ItemCount == 0) {
		ret = res._retn ();
	} else if (res.ptr () && res->ItemCount) {
		ret->Merge (*res);
	}

	if (ret.is_nil () == false) {
		Core::Aptr <DBCore::RelTuneData> informers = Cache::instance ()->get_informers (m_base, m_requests [0].context);

		RelevancyTuner tuner (m_info_collector);
		tuner.execute (ret.inout (), *informers, ContextSearch::Defs::dt_INFORM);
		tuner.execute (ret.inout (), SearchAdapter::instance ()->get_tune_data (), ContextSearch::Defs::dt_RCH);
	}

	return ret._retn ();
	//#UC END# *50ED5AD00196*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

