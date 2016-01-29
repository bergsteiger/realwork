////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/PartialAlgorithm_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::PartialAlgorithm_i
//
// Реализация интерфейса поискового алгоритма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Search_i/PartialAlgorithm_i.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "shared/ContextSearch/MorphoBase/RequestBuilder.h"

namespace ContextSearch {
namespace Search_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PartialAlgorithm_i::PartialAlgorithm_i (
	Search::IRequestView* view
	, DBComm::IProgress* progress
	, const Search::AlgorithmProperties& properties
)
//#UC START# *4516626F000F_451662B201C5_5203A6F3003B_BASE_INIT*
	: m_properties (properties)
//#UC END# *4516626F000F_451662B201C5_5203A6F3003B_BASE_INIT*
{
	//#UC START# *4516626F000F_451662B201C5_5203A6F3003B_BODY*
	if (progress) {
		m_progress = DBComm::IProgress::_duplicate (progress);
		m_progress->init (1, 0);
	}

	Core::Aptr <Search::Phrases> req = view->get_spans ();
	{
		for (Search::Phrases::iterator it = req->begin (); it != req->end (); ++it) {
			m_query.push_back (SpansQuery (*it, properties));
		}
	}

	QueryData::Spans spans;
	{
		for (PartialQuery::iterator it = m_query.begin (); it != m_query.end (); ++it) {
			SpansQuery::Spans& data = it->get ();

			for (size_t i = 0; i < data.size (); ++i) {
				SpanQuery* span = &(data [i]);

				size_t j = 0;

				for (; j < spans.size (); ++j) {
					if (span->get_key () == spans [j]->get_key ()) {
						break;
					}
				}

				if (j == spans.size ()) {
					spans.push_back (span);
				}
			}
		}
	}

	Core::Aptr <Search::Phrases> sequence = RequestBuilder::make_sequence (*req);

	for (Search::Phrases::const_iterator it = sequence->begin (); it != sequence->end (); ++it) {
		m_data.push_back (QueryData (*it, spans, properties));
	}
	//#UC END# *4516626F000F_451662B201C5_5203A6F3003B_BODY*
}

PartialAlgorithm_i::~PartialAlgorithm_i () {
	//#UC START# *5203A6F3003B_DESTR_BODY*
	//#UC END# *5203A6F3003B_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// расчет релевантности
bool PartialAlgorithm_i::get_relevancy (Relevancy::RelevancyDocInfo& out) {
	//#UC START# *520CD34A0104*
	out.info.relevancy_value = 0;

	// проверка
	std::for_each (m_data.begin (), m_data.end (), boost::bind (&QueryData::check, _1, out.doc_id));
	// релевантность по каждому запросу
	std::for_each (m_data.begin (), m_data.end (), boost::bind (&QueryData::get_relevancy, _1, boost::ref (out)));
	// чистка кэшей
	std::for_each (m_query.begin (), m_query.end (), boost::bind (&SpansQuery::clear, _1));

	return (out.info.relevancy_value > 0);
	//#UC END# *520CD34A0104*
}

// поиск
bool PartialAlgorithm_i::next (Search::DocIdPair& result) {
	//#UC START# *5204FAC7000C*
	DBComm::DocId border = result.max_id;

	if (result.min_id == result.max_id) {
		++border;
	}

	result.max_id = DBComm::NULL_DOC_ID;
	result.min_id = DBComm::INFINITE_DOC_ID;

	for (PartialQuery::iterator it = m_query.begin (); it != m_query.end (); ++it) {
		if (it->next (border, result) == false) {
			return false;
		}
	}

	return true;
	//#UC END# *5204FAC7000C*
}

// изменить состояние прогресс-индикатора
bool PartialAlgorithm_i::set_progress (size_t i) {
	//#UC START# *528228D60105*
	if (m_progress.ptr () && (i % Search::PROGRESS_DOCS1000 == 0)) {
		try {
			if (m_progress->canceled_by_user ()) {
				return true;
			}

			for (PartialQuery::iterator it = m_query.begin (); it != m_query.end (); ++it) {
				size_t val = it->get_prog_value ();

				if (val) {
					m_progress->set (val);
					break;
				}
			}
		} catch (...) {
			LOG_UEX ((GDS_CURRENT_FUNCTION));
		}
	}

	return false;
	//#UC END# *528228D60105*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Search::IAlgorithm
// список релевантных фрагментов
Defs::Fragments* PartialAlgorithm_i::get_fragments (DBComm::DocId doc_id, const Defs::InvisibleBlocks& blocks) {
	//#UC START# *451662F4037A_5203A6F3003B*
	for (PartialQuery::iterator it = m_query.begin (); it != m_query.end (); ++it) {
		if (it->search_doc (doc_id) == false) {
			return 0;
		}
	}

	Core::Aptr <Defs::Fragments> ret = new Defs::Fragments ();

	std::for_each (m_data.begin (), m_data.end (), boost::bind (&QueryData::check, _1, doc_id));
	std::for_each (m_data.begin (), m_data.end (), boost::bind (&QueryData::get_fragments, _1, boost::ref (*ret), doc_id));

	return ret._retn ();
	//#UC END# *451662F4037A_5203A6F3003B*
}

// implemented method from Search::IAlgorithm
// поиск
void PartialAlgorithm_i::search (Defs::IResCollector* collector, Defs::IFilter* filter) {
	//#UC START# *5322986C02E4_5203A6F3003B*
	Search::DocIdPair pair;

	pair.min_id = 0;
	pair.max_id = 0;

	Defs::RelevancyDocInfo at;

	size_t i = 0;

	while (this->next (pair)) {
		if (pair.min_id == pair.max_id) {
			if (filter) {
				if (filter->check (pair.max_id) == false) {
					if (filter->check () == false) {
						break;
					}
					continue;
				}
			}

			at.doc_id = pair.max_id;

			if (this->get_relevancy (at)) {
				collector->add (at.doc_id, at.info);
			}
		}

		if (this->set_progress (++i)) {
			break;
		}
	}

	if (filter) {
		filter->reset ();
	}

	if (m_progress.is_nil () == false) {
		if (m_progress->canceled_by_user ()) {
			throw Search::CanceledByUser ();
		}
	}
	//#UC END# *5322986C02E4_5203A6F3003B*
}
} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

