////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/Collector_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::Collector_i
//
// Коллектор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/ContextSearch/Collector_i.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collection_iterator.h"
#include "garantCore/Search/impl/Filters_i/Filters.h"
#include "garantCore/Search/ContextSearch/RelevancyTuner.h"

//#UC START# *533EB45103D2_CUSTOM_INCLUDES*
//#UC END# *533EB45103D2_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *533EB45103D2*
typedef fast_collection_iterator <SortedCollection, RefwRele, REL_COL_PAGE_SIZE> Iterator_;

class RefRelCompare : public std::binary_function <RefwRele, RefwRele, bool> {
public:
	bool operator () (const RefwRele& x, const RefwRele& y) const {
		return (x.DocId < y.DocId);
	}
};
//#UC END# *533EB45103D2*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Collector_i::Collector_i (SearchAdapterLib::Adapter::IRelevancyInfo* info, const RequestData& in)
//#UC START# *533EB69C025B_BASE_INIT*
	: m_mid (0)
	, m_last (0)
	, m_request_data (&in)
	, m_info_collector (info)
//#UC END# *533EB69C025B_BASE_INIT*
{
	//#UC START# *533EB69C025B_BODY*
	m_data = new RefwReleCollection (REL_COL_PAGE_SIZE);
	//#UC END# *533EB69C025B_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// _retn
RefwReleCollection* Collector_i::_retn () {
	//#UC START# *5346DB16030E*
	using namespace ContextSearch;

	if (m_tmp.is_nil () == false && m_tmp->ItemCount) {
		Iterator_ it (m_data.in (), 0);
		Iterator_ it_end (m_data.in (), m_data->ItemCount);

		Iterator_ beg (m_tmp.in (), 0);
		Iterator_ end (m_tmp.in (), m_tmp->ItemCount);

		for (; it != it_end; ++it) {
			beg = std::lower_bound (beg, end, *it, RefRelCompare ());

			if (beg != end && it->DocId == beg->DocId) {
				it->Rele += beg->Rele;

				if ((it->Word & POS_TEXT) <= DOC_BEGIN_WORD) {
					it->Word = beg->Word;
				} else if ((beg->Word & POS_TEXT) > DOC_BEGIN_WORD) {
					it->Word = std::min <long> (it->Word, beg->Word);
				} 
			}
		}
	}

	return (m_data->ItemCount == 0)? 0 : m_data._retn ();
	//#UC END# *5346DB16030E*
}

// merge
void Collector_i::merge () {
	//#UC START# *533EB75A0372*
	if (m_mid && m_mid < (size_t) m_data->ItemCount) {
		Iterator_ beg (m_data.in (), 0);
		Iterator_ mid (m_data.in (), m_mid);
		Iterator_ end (m_data.in (), m_data->ItemCount);
		std::inplace_merge (beg, mid, end, RefRelCompare ());
	}
	m_mid = m_data->ItemCount;
	//#UC END# *533EB75A0372*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContextSearch::Defs::IResCollector
// add
void Collector_i::add (ContextSearch::Defs::DocId id, const ContextSearch::Defs::RelevancyInfo& info) {
	//#UC START# *532294C70019_533EB45103D2*
	using namespace ContextSearch;

	RefwRele at;
	at.DocId = (long) id;
	at.Word  = (long) info.position;
	at.Rele  = (short) (info.relevancy_value & 0xFFFF);

	if (m_last >= at.DocId) {
		this->merge ();
	}

	if (m_mid) {
		Iterator_ end (m_data.in (), m_mid);
		Iterator_ it = std::lower_bound (Iterator_ (m_data.in (), 0), end, at, RefRelCompare ());

		if (it != end && it->DocId == at.DocId) {
			if (it->Rele < at.Rele) {
				it->Rele = at.Rele;
				it->Word = at.Word;
			} else if (it->Rele == at.Rele && ((it->Word & POS_TEXT) > (at.Word & POS_TEXT))) {
				it->Rele = at.Rele;
				it->Word = at.Word;
			}
			return;
		}
	}

	m_last = at.DocId;
	m_data->Collection::Add (&at);
	//#UC END# *532294C70019_533EB45103D2*
}

// implemented method from ContextSearch::Defs::IResCollector
// empty
bool Collector_i::empty () const {
	//#UC START# *552FE9010247_533EB45103D2*
	return (m_data.is_nil () || m_data->ItemCount == 0);
	//#UC END# *552FE9010247_533EB45103D2*
}

// implemented method from ContextSearch::Defs::IResCollector
// finish
void Collector_i::finish (const std::string& req) {
	//#UC START# *5551DFC3011D_533EB45103D2*
	if (m_data->ItemCount == 0) {
		return;
	}

	this->merge ();
	m_last = 0;

	if (m_request_data) {
		RequestData::const_iterator it = m_request_data->find (req);

		if (it != m_request_data->end ()) {
			RelevancyTuner tuner (m_info_collector);
			tuner.execute (m_data.inout (), it->second.type, ContextSearch::Defs::dt_TYPE);
			tuner.execute (m_data.inout (), it->second.code, ContextSearch::Defs::dt_CODE);
		}
	}
	//#UC END# *5551DFC3011D_533EB45103D2*
}

// implemented method from ContextSearch::Defs::IResCollector
// filter
ContextSearch::Defs::IFilter* Collector_i::get_filter (char op) {
	//#UC START# *552FE8D503DF_533EB45103D2*
	m_tmp = this->_retn ();
	m_data = new RefwReleCollection (REL_COL_PAGE_SIZE);
	m_mid = 0;
	m_last = 0;
	m_filter = FiltersFactory::make (m_tmp.in (), op); 
	return m_filter.in ();
	//#UC END# *552FE8D503DF_533EB45103D2*
}

// implemented method from ContextSearch::Defs::IResCollector
// start
void Collector_i::start (const std::string& req) {
	//#UC START# *5551DFA100F7_533EB45103D2*
	//#UC END# *5551DFA100F7_533EB45103D2*
}
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

