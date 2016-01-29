////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/Query_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::Query_i
//
// Реализация интерфейса менеджера поисковых запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Manage_i/Query_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "shared/ContextSearch/impl/Manage_i/QueryCorrector.h"
#include "shared/ContextSearch/MorphoBase/RelevancyTuner.h"
#include "shared/ContextSearch/MorphoBase/Collector_i.h"

namespace ContextSearch {
namespace Manage_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const size_t Query_i::RESERVE_SIZE = 64; // размер для резервирования

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Query_i::Query_i (const Manage::Env& in, DBComm::IDBCommunicator* comm)
//#UC START# *4ECF7A350135_4ECF7A7502BE_4B6072EB0167_BASE_INIT*
//#UC END# *4ECF7A350135_4ECF7A7502BE_4B6072EB0167_BASE_INIT*
{
	//#UC START# *4ECF7A350135_4ECF7A7502BE_4B6072EB0167_BODY*
	GDS_ASSERT (comm);
	m_communicator = DBComm::IDBCommunicator::_duplicate (comm);

	Manage::Env* env_ = const_cast <Manage::Env*> (&in);

	m_env.normalizer = Morpho::Def::INormalizer::_duplicate (env_->normalizer.in ());
	m_env.factory  = DBComm::IStreamsFactory::_duplicate (env_->factory.in ());
	m_env.wild_mng = DBComm::IWildCard::_duplicate (env_->wild_mng.in ());
	m_env.progress = DBComm::IProgress::_duplicate (env_->progress.in ());
	//#UC END# *4ECF7A350135_4ECF7A7502BE_4B6072EB0167_BODY*
}

Query_i::~Query_i () {
	//#UC START# *4B6072EB0167_DESTR_BODY*
	//#UC END# *4B6072EB0167_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// выполнить поиск
void Query_i::execute (
	const ReqInfo& req
	, Search::IFilter* filter
	, Relevancy::IRelevancyInfo* info
	, Search::IResCollector* collector
) {
	//#UC START# *552FCECF0100*
	GDS_ASSERT (m_env.factory.is_nil () == false);
	GDS_ASSERT (m_env.normalizer.is_nil () == false);

	Search::IRequestView_var view = this->get_view (req, false);
	Search::IAlgorithm_var algorithm = this->get_alg (view.in (), req, info, true);

	algorithm->search (collector, filter);

	collector->finish (req.src);

	if (m_env.progress.is_nil () == false) {
		m_env.progress->plus ();
	}
	//#UC END# *552FCECF0100*
}

// алгоритм
Search::IAlgorithm* Query_i::get_alg (
	Search::IRequestView* view
	, const ReqInfo& info
	, Relevancy::IRelevancyInfo* collector
	, bool strong_deflate
) {
	//#UC START# *51431E7B014F*
	Search::AlgorithmProperties prop;

	prop.normalizer = m_env.normalizer.in ();
	prop.factory = m_env.factory.in ();
	prop.wild_mng = m_env.wild_mng.in ();
	prop.comm = m_communicator.in ();
	prop.max_fragment = info.max_fragment;
	prop.collector = collector;
	prop.flags = info.flags;

	Search::AlgorithmSelector selector = view->get_type ();

	if (selector == Search::as_Partial) {
		prop.flags |= Search::SP_IGNORE_CACHE;
	} 

	if (strong_deflate) {
		prop.flags |= Search::SP_STRONG_DEFLATE;
	}

	return Search::IAlgorithmFactory::make (view, m_env.progress.in (), prop, selector);
	//#UC END# *51431E7B014F*
}

// все лексемы запроса
Search::Phrase* Query_i::get_lexemes (const Search::SplitRequests& in, bool add_special) {
	//#UC START# *539701FA0364*
	Core::Aptr <Search::Phrase> ret = new Search::Phrase ();

	for (Search::SplitRequests::const_iterator it = in.begin (); it != in.end (); ++it) {
		for (Search::Phrase::const_iterator _it = it->context.begin (); _it != it->context.end (); ++_it) {
			GDS_ASSERT (_it->empty () == false);

			char last = *(_it->rbegin ());

			if (last != '!' && last != '*') {
				Core::Aptr <GCL::StrSet> res = m_env.normalizer->execute (*_it, true);
				ret->insert (ret->end (), res->begin (), res->end ());
			} else if (add_special) {
				ret->push_back (*_it);
			}
		}
	}

	return ret._retn ();
	//#UC END# *539701FA0364*
}

// представление запроса
Search::IRequestView* Query_i::get_view (const ReqInfo& info, bool is_default) {
	//#UC START# *527124B2015A*
	Search::IRequestView_var ret;

	if (info.has_syn) {
		Manage::ISynManager_var manager = Manage::ISynManagerFactory::make (
			m_env.normalizer.in (), m_communicator.in ()
		);
		ret = manager->execute (info.context, is_default);
	} 

	if (ret.is_nil ()) {
		GCL::StrVector in (1, info.context);
		ret = Search::IRequestViewFactory::make (0, 0, Search::as_Simple);
		ret->build (in, Morpho::Def::StrStrMap (), info.context);
	}

	return ret._retn ();
	//#UC END# *527124B2015A*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Manage::IQuery
// добавить запрос
void Query_i::add (const Defs::Request& req, bool uwc) {
	//#UC START# *5283A5300383_4B6072EB0167*
	QueryCorrector::Info q_info;

	QueryCorrector corrector (uwc && req.btext == false);

	ReqInfo info;

	info.src = req.context;
	info.context = corrector.execute (req.context, q_info);
	info.has_syn = q_info.has_syn;
	info.max_fragment = q_info.max_fragment;
	info.op = req.op;

	if (info.context.empty ()) {
		throw Manage::InvalidQuery ();
	}

	if (req.btext == false) {
		info.flags |= Search::SP_TITLES;
	}

	m_info.push_back (info);
	//#UC END# *5283A5300383_4B6072EB0167*
}

// implemented method from Manage::IQuery
// очистить кэш
void Query_i::clear () {
	//#UC START# *4ECF7ABA011A_4B6072EB0167*
	m_info.clear ();
	//#UC END# *4ECF7ABA011A_4B6072EB0167*
}

// implemented method from Manage::IQuery
// выполнить поиск
Defs::RelevancyDocuments* Query_i::execute (const Defs::SearchInfo& info) {
	//#UC START# *514313FB03CF_4B6072EB0167*
	Core::Var <Collector_i> collector = new Collector_i ();

	this->execute (info, collector.inout ());

	Core::Aptr <Search::RelevancyDocuments> ret = collector->_retn ();

	if (ret.is_nil () == false) {
		RelevancyTuner::execute (*(ret.inout ()), m_communicator->get_tune_data ());
	}

	return ret._retn ();
	//#UC END# *514313FB03CF_4B6072EB0167*
}

// implemented method from Manage::IQuery
// выполнить поиск
void Query_i::execute (const Defs::SearchInfo& info, Defs::IResCollector* collector) {
	//#UC START# *552FB32F0314_4B6072EB0167*
	if (m_env.factory->is_valid () == false) {
		return;
	}

	std::sort (m_info.begin (), m_info.end ());

	ReqsInfo::const_iterator it = m_info.begin (), it_end = m_info.end ();

	if (it->op == Defs::so_OR) {
		for (; it != it_end && it->op == Defs::so_OR; ++it) {
			this->execute (*it, info.filter, info.info_collector, collector);
		}

		if (collector->empty ()) {
			return; // ничего не найдено
		}
	}

	for (; it != it_end; ++it) {
		if (collector->empty ()) {
			this->execute (*it, info.filter, info.info_collector, collector);
		} else {
			this->execute (*it, collector->get_filter (Defs::so_AND), info.info_collector, collector);
		} 

		if (collector->empty ()) {
			break; // ничего не найдено
		}
	}
	//#UC END# *552FB32F0314_4B6072EB0167*
}

// implemented method from Manage::IQuery
// список синонимичных запросов
Search::SplitRequests* Query_i::get_data () {
	//#UC START# *4ECF7B160057_4B6072EB0167*
	Core::Aptr <Search::SplitRequests> ret = new Search::SplitRequests ();

	for (ReqsInfo::const_iterator it = m_info.begin (); it != m_info.end (); ++it) {
		Search::IRequestView_var view = this->get_view (*it, true);
		const Search::SplitRequests& sequence = view->get_sequence ();
		ret->insert (ret->end (), sequence.begin (), sequence.end ());
	}

	return ret._retn ();
	//#UC END# *4ECF7B160057_4B6072EB0167*
}

// implemented method from Manage::IQuery
// выполнить поиск в документе
Defs::Fragments* Query_i::get_fragments (DBComm::DocId id) {
	//#UC START# *51433129039F_4B6072EB0167*
	Core::Aptr <Relevancy::Fragments> ret = new Relevancy::Fragments ();
	ret->reserve (RESERVE_SIZE);

	const Defs::InvisibleBlocks& inv_blocks = m_communicator->get_invisible_blocks ();

	for (ReqsInfo::const_iterator it = m_info.begin (); it != m_info.end (); ++it) {
		Search::IRequestView_var view = this->get_view (*it, false);
		Search::IAlgorithm_var algorithm = this->get_alg (view.in (), *it, 0, false);

		Core::Aptr <Relevancy::Fragments> res = algorithm->get_fragments (id, inv_blocks);

		if (res.is_nil () == false) {
			ret->insert (ret->end (), res->begin (), res->end ());
		}
	}

	return ret._retn ();
	//#UC END# *51433129039F_4B6072EB0167*
}

// implemented method from Manage::IQuery
// все лексемы запроса
GCL::StrVector* Query_i::get_lexemes (bool add_special) {
	//#UC START# *52A8747B01BA_4B6072EB0167*
	if (m_info.size () == 1) {
		Search::IRequestView_var view = this->get_view (m_info [0], true);
		return this->get_lexemes (view->get_sequence (), add_special);
	}

	Core::Aptr <GCL::StrVector> ret = new GCL::StrVector ();

	for (ReqsInfo::const_iterator it = m_info.begin (); it != m_info.end (); ++it) {
		Search::IRequestView_var view = this->get_view (*it, true);
		Core::Aptr <GCL::StrVector> res = this->get_lexemes (view->get_sequence (), add_special);
		ret->insert (ret->end (), res->begin (), res->end ());
	}

	return ret._retn ();
	//#UC END# *52A8747B01BA_4B6072EB0167*
}

// implemented method from Manage::IQuery
// позиции релевантных фрагментов
Defs::Positions* Query_i::get_positions (DBComm::DocId id) {
	//#UC START# *5150471A0299_4B6072EB0167*
	Core::Aptr <Relevancy::Positions> ret = new Relevancy::Positions ();
	ret->reserve (Search::RESERVE_SIZE);

	Core::Aptr <Defs::Fragments> res = this->get_fragments (id);

	GDS_ASSERT (res.is_nil () == false);

	for (Relevancy::Fragments::const_iterator it = res->begin (); it != res->end (); ++it) {
		for (Relevancy::Positions::const_iterator _it = it->data.begin (); _it != it->data.end (); ++_it) {
			if ((*_it & POS_FLAGS) != POS_INVISIBLE && (*_it & POS_FLAGS) != POS_INVISIBLE_BLOCK) {
				ret->push_back (*_it & POS_TEXT);
			}
		}
	}

	std::sort (ret->begin (), ret->end ());
	ret->erase (std::unique (ret->begin (), ret->end ()), ret->end ());

	return ret._retn ();
	//#UC END# *5150471A0299_4B6072EB0167*
}
} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

