////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/Algorithm_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Algorithm_i
//
// Реализация интерфейса поискового алгоритма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Search_i/Algorithm_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/MorphoBase/Logger.h"
#include "shared/ContextSearch/MorphoBase/RequestBuilder.h"
#include "shared/ContextSearch/impl/Search_i/RequestAnalyzer.h"

namespace ContextSearch {
namespace Search_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Algorithm_i::Algorithm_i (
	Search::IRequestView* view
	, DBComm::IProgress* progress
	, const Search::AlgorithmProperties& properties
)
//#UC START# *4516626F000F_451662B201C5_451666340213_BASE_INIT*
	: m_properties (properties)
//#UC END# *4516626F000F_451662B201C5_451666340213_BASE_INIT*
{
	//#UC START# *4516626F000F_451662B201C5_451666340213_BODY*
	if (progress) {
		m_progress = DBComm::IProgress::_duplicate (progress);
	}

	m_max_fragment = properties.max_fragment;

	GDS_ASSERT (view);

	m_view = Search::IRequestView::_duplicate (view);
	//#UC END# *4516626F000F_451662B201C5_451666340213_BODY*
}

Algorithm_i::~Algorithm_i () {
	//#UC START# *451666340213_DESTR_BODY*
	//#UC END# *451666340213_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// выполнить для синонимичного запроса
void Algorithm_i::execute (
	const Search::RequestEx& request
	, Search::IFilter* filter
	, Search::IResCollector* collector
) {
	//#UC START# *532867F00302*
	GDS_ASSERT (request.context.size ());

	Logger::out (request, m_properties.collector);

	this->set_max_fragment (request.context.size ());

	RequestAnalyzer analyzer (request, m_properties, true);

	Searcher* searcher = analyzer.get_searcher ();

	InvbSearcher* invb_searcher = analyzer.get_invb_searcher ();

	Relevancy::IAlgorithm* algorithm = analyzer.get_algorithm ();

	Relevancy::IBlocksAlgorithm* invb_algorithm = analyzer.get_invb_algorithm ();

	size_t progress_inc = 0;

	Defs::RelevancyInfo info, invb_info;

	const Defs::PositionsRel rel_def;
	const Defs::InvisibleRel& r_data = m_properties.comm->get_invisible_rel ();

	const Defs::InvisibleData def;
	const Defs::InvisibleBlocks& b_data = m_properties.comm->get_invisible_blocks ();

	Relevancy::DataVector vect;

	for (DBComm::DocId id = 1; id = searcher->get_next (id); ++id) {
		//Core::Aptr <DebugInfo> di = (DebugInfo*) DebugInfo::make (id == 70105986, algorithm.in ());

		if (filter) {
			if (filter->check (id) == false) {
				if (filter->check () == false) {
					break;
				}
				continue;
			}
		}

		bool has_block = false;

		if (searcher->get_data (vect, id, has_block)) {
			Defs::InvisibleRel::const_iterator r_it = r_data.find (id);
			Defs::InvisibleBlocks::const_iterator b_it = b_data.find (id);

			const Defs::PositionsRel& rel_data = (r_it != r_data.end ())? r_it->second : rel_def;

			algorithm->get_relevancy_info (
				info
				, vect
				, (b_it != b_data.end ())? b_it->second : def
				, rel_data
				, has_block
			);

			if (has_block && invb_searcher) {
				Core::Aptr <Relevancy::BlockEntries> entries = invb_searcher->get (id);

				if (entries.is_nil () == false) {
					invb_algorithm->get_relevancy_info (invb_info, vect, rel_data, *entries);

					if (invb_info.relevancy_value > info.relevancy_value) {
						info = invb_info;
					}
				}
			}

			if (info.relevancy_value > 0) {
				if (m_properties.collector) {
					m_properties.collector->add (id, info);
				}
				collector->add (id, info);
			}
		}

		if (this->set_progress (++progress_inc, *searcher)) {
			break;
		}
	}
	//#UC END# *532867F00302*
}

// выполнить (mt)
Search::RelevancyDocuments* Algorithm_i::execute_mt (Search::IWorker* worker) {
	//#UC START# *5203B0B701DF*
	/*
	worker->init (m_algorithm.in (), m_searcher.in ());

	Search::DocIdPair pair;
	pair.max_id = DBComm::NULL_DOC_ID;

	size_t progress_inc = 0;

	do {
		if (m_searcher->search (pair)) {
			if (pair.min_id == pair.max_id) {
				if (docs.empty () == false) {
					if (std::binary_search (docs.begin (), docs.end (), pair.max_id) == false) {
						continue;
					}
				}

				worker->add (pair.max_id);
			}
		} else {
			break;
		}

		if (this->set_progress (++progress_inc)) { // canceled by user
			break;
		}
	} while (pair.min_id != DBComm::NULL_DOC_ID);
	*/

	return worker->_retn ();
	//#UC END# *5203B0B701DF*
}

// релевантные фрагменты
Search::FragmentsPair* Algorithm_i::get_fragments (
	const Search::RequestEx& request
	, DBComm::DocId doc_id
	, const Search::InvisibleBlocks& blocks
) {
	//#UC START# *527B8514034A*
	Core::Aptr <Search::FragmentsPair> ret;

	Logger::out (request, 0);

	bool has_block = false;

	this->set_max_fragment (request.context.size ());

	RequestAnalyzer analyzer (request, m_properties, false);

	Searcher* searcher = analyzer.get_searcher ();

	Relevancy::DataVector vect;

	if (searcher->search (doc_id) && searcher->get_data (vect, doc_id, has_block)) {
		Relevancy::IAlgorithm* algorithm = analyzer.get_algorithm ();

		//DebugInfo di (algorithm.in ());

		ret = new Search::FragmentsPair;
		ret->data = algorithm->get_fragments (vect);

		/*
		Defs::InvisibleBlocks::const_iterator it = blocks.find (doc_id);

		if (it != blocks.end ()) {
			ret->block_data = algorithm->get_block_fragments (vect, it->second);
		}
		*/

		InvbSearcher* invb_searcher = analyzer.get_invb_searcher ();

		if (has_block && invb_searcher) {
			Core::Aptr <Relevancy::BlockEntries> entries = invb_searcher->get (doc_id);

			if (entries.is_nil () == false && entries->empty () == false) {
				ret->block_data = analyzer.get_invb_algorithm ()->get_fragments (*entries, vect);
			}
		}
	}

	return ret._retn ();
	//#UC END# *527B8514034A*
}

// очко
void Algorithm_i::set_max_fragment (size_t req_size) {
	//#UC START# *54BE741002AF*
	if (m_max_fragment == 0) {
		size_t sz = std::min <size_t> (req_size, Search::WORDS_LIMIT);
		m_properties.max_fragment = sz * Relevancy::BASE_FACTOR;
	} else {
		m_properties.max_fragment = m_max_fragment;
	}
	//#UC END# *54BE741002AF*
}

// изменить состояние прогресс-индикатора
bool Algorithm_i::set_progress (size_t i, Searcher& searcher) {
	//#UC START# *4F60A17F03B0*
	if (m_progress.ptr () && (i % 500 == 0)) {
		try {
			if (m_progress->canceled_by_user ()) {
				return true;
			}
			m_progress->set (searcher.get_prog_value ());
		} catch (...) {
			LOG_UEX ((GDS_CURRENT_FUNCTION));
		}
	}

	return false;
	//#UC END# *4F60A17F03B0*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Search::IAlgorithm
// список релевантных фрагментов
Defs::Fragments* Algorithm_i::get_fragments (DBComm::DocId doc_id, const Defs::InvisibleBlocks& blocks) {
	//#UC START# *451662F4037A_451666340213*
	Core::Aptr <Relevancy::Fragments> ret = new Relevancy::Fragments ();

	Relevancy::Fragments res;

	Core::Aptr <Search::RequestsEx> sequence = RequestBuilder::make_deflate (m_view->get_sequence ());

	for (Search::RequestsEx::const_iterator it = sequence->begin (); it != sequence->end (); ++it) {
		Core::Aptr <Search::FragmentsPair> pair = this->get_fragments (*it, doc_id, blocks);

		if (pair.is_nil () == false) {
			// Oбычные фрагменты
			if (pair->data.is_nil () == false) {
				ret->insert (ret->end (), pair->data->begin (), pair->data->end ());
			}
			// Блочные фрагменты
			if (pair->block_data.is_nil () == false) {
				res.insert (res.end (), pair->block_data->begin (), pair->block_data->end ());
			}
		}
	}

	if (res.empty () == false) {
		ret->insert (ret->end (), res.begin (), res.end ()); // cливаем в результирующий контейнер
	}

	return ret._retn ();
	//#UC END# *451662F4037A_451666340213*
}

// implemented method from Search::IAlgorithm
// поиск
void Algorithm_i::search (Defs::IResCollector* collector, Defs::IFilter* filter) {
	//#UC START# *5322986C02E4_451666340213*
	Core::Aptr <Search::RequestsEx> sequence = RequestBuilder::make_deflate (m_view->get_sequence ());

	size_t i = 0, div = sequence->size ();

	for (Search::RequestsEx::const_iterator it = sequence->begin (); it != sequence->end (); ++it, ++i) {
		if (m_progress.is_nil () == false) {
			m_progress->init (div, i);
		}

		try {
			this->execute (*it, filter, collector);

			if (filter) {
				filter->reset ();
			}
		} catch (std::exception&) {
			LOG_E (("%s: search is canceled", GDS_CURRENT_FUNCTION));
		} catch (...) {
			LOG_UEX (("%s: search is canceled", GDS_CURRENT_FUNCTION));
		}

		if (m_progress.is_nil () == false) {
			if (m_progress->canceled_by_user ()) {
				throw Search::CanceledByUser ();
			}
		}
	}
	//#UC END# *5322986C02E4_451666340213*
}
} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

