//
// RequestRateAnalyzer.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>
#include <functional>

#include "boost/tokenizer.hpp"
#include "boost/lambda/lambda.hpp"

#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Common/Constants.h"

#include "garantCore/SearchAdapterLib/Cache/Cache.h"

#include "RequestRateAnalyzer.h"
#include "DBComm.h"

namespace RequestRateAnalyze {

typedef ContextSearch::Defs::RelevancyDocInfo RelevancyDocInfo;
typedef ContextSearch::Defs::RelevancyDocuments RelevancyDocuments;

struct CompareRelDocs
	: public std::binary_function <RelevancyDocInfo, RelevancyDocInfo, bool> 
{
	bool operator () (const RelevancyDocInfo& x, const RelevancyDocInfo& y) const {
		return x.info.relevancy_value > y.info.relevancy_value;
	}
};

class MinRelFinder : public std::unary_function <RelevancyDocInfo, bool> {
public:
	MinRelFinder (Defs::RelevancyType max_value) : rel_value (max_value) {
	}

	bool operator () (const RelevancyDocInfo& x) const {
		return x.info.relevancy_value < rel_value;
	}
private:
	Defs::RelevancyType rel_value;
};

// Функтор вычисления количества вхождений
struct EntryPointCounter : public std::unary_function <RelevancyDocInfo, void> {
	EntryPointCounter (
		SearchAdapterLib::Adapter::ISearcher* searcher
		, const std::string& str
		, Defs::RelevancyType max_value
		, size_t& out
	)
		: counter (out) 
		, m_str (str)
		, rel_value (max_value)
	{
		m_searcher = SearchAdapterLib::Adapter::ISearcher::_duplicate (searcher);
	}

	virtual ~EntryPointCounter () {
	}

	void operator () (const RelevancyDocInfo& info) {
		SearchAdapterLib::Adapter::IFragments_var fragments = m_searcher->get_fragments (m_str, info.doc_id);

		GDS_ASSERT (fragments.is_nil () == false);

		const Relevancy::Fragments& data = fragments->data ();

		Defs::Fragment fragment (rel_value);
		counter += std::count_if (data.begin (), data.end (), boost::lambda::_1 >= fragment);
	}

private:
	size_t& counter;

	std::string m_str;

	Defs::RelevancyType rel_value;

	SearchAdapterLib::Adapter::ISearcher_var m_searcher;
};

//////////////////////////////////////////////////////////////////////////////////////////

static void dump (const RelevancyDocuments& data) {
	std::ofstream ofs ("C:\\dump1.t", std::ios_base::trunc);

	if (ofs) {
		for (RelevancyDocuments::const_iterator it = data.begin (); it != data.end (); ++it) {
			ofs << std::distance (data.begin (), it) 
				<< ".\t" 
				<< "\tdoc: " << it->doc_id 
				<< "\trel: " << it->info.relevancy_value 
				<< "\tpos: " << it->info.position
				<< std::endl;
		}

		ofs.close ();
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

RequestRateAnalyzer::RequestRateAnalyzer (const std::string& path) : m_max_value (0) {
	Core::GDS::StopWatch sw ("construct");

	m_base = new ToolsBase (path);

	DBCore::IBase_var _base = DBCore::DBFactory::make (m_base.in ());

	SearchAdapterLib::Cache::instance ()->init (_base.in ());

	m_searcher = SearchAdapterLib::Adapter::ISearcherFactory::make (_base.in (), 0, "NWCntxt.str");

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (_base.in ());

	m_env.normalizer = Morpho::Factory::make (cache.in ());
	m_query = Manage::IQueryFactory::make (m_env, SearchAdapterLib::Cache::instance ()->get ());

	m_info = new ContextSearch::Defs::SearchInfo ();
}

RequestRateAnalyzer::~RequestRateAnalyzer () {
}

void RequestRateAnalyzer::execute (const Properties& properties) {
	std::cout << "start.." << std::endl << std::endl;

	m_max_value = properties.rel_value;

	std::ifstream ifs (properties.in.c_str ());

	if (ifs) {
		ifs >> std::noskipws;

		std::string str;

		std::copy (
			std::istream_iterator <char> (ifs)
			, std::istream_iterator <char> ()
			, std::back_inserter (str)
		);

		typedef boost::tokenizer <boost::char_separator <char> > tokenizer;
		boost::char_separator <char> sep ("\n");
		tokenizer tok (str, sep);

		std::ofstream ofs (properties.out.c_str (), std::ios_base::trunc);

		if (ofs) {
			std::string req_str;

			for (tokenizer::iterator it = tok.begin (); it != tok.end (); ++it) {
				if (it.current_token ().at (0) == ';') {
					continue;
				}

				m_query->clear ();
				m_query->add (Defs::Request (*it), false);

				std::cout << *it << std::endl;

				ofs << *it << ": ";

				Core::Aptr <Search::SplitRequests> requests = m_query->get_data ();

				for (Search::SplitRequests::const_iterator _it = requests->begin (); _it != requests->end (); ++_it) {
					this->convert_to_string (*_it, req_str);
					ofs << req_str;

					if (_it + 1 != requests->end ()) {
						ofs << ";";
					}
				}

				ofs << ":" << this->get_rate (*it) << std::endl;
			}
			ofs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.out.c_str ()));
		}
		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.in.c_str ()));
	}
}

void RequestRateAnalyzer::convert_to_string (const Search::SplitRequest& req, std::string& out) {
	out.clear ();

	Search::Phrase::const_iterator it_begin = req.context.begin (), it_end = req.context.end ();

	for (Search::Phrase::const_iterator it = it_begin; it != it_end; ++it) {
		size_t i = std::distance (it_begin, it);

		if (std::binary_search (req.data.strongs.begin (), req.data.strongs.end (), i)) {
			out += "-";
		} else if (i) {
			out += " ";
		}

		Core::Aptr <GCL::StrSet> res = m_env.normalizer->execute (*it, false);
		out += *(res->begin ());
	}
}

size_t RequestRateAnalyzer::get_rate (const std::string& req_str) {
	size_t ret = 0;

	ContextSearch::Defs::Requests reqs (1, ContextSearch::Defs::Request ());
	reqs [0].context = req_str;

	GDS_ASSERT (m_searcher.is_nil () == false);

	try {
		SearchAdapterLib::Adapter::IDocuments_var res = m_searcher->get_documents (reqs, *(m_info.in ()));

		if (res.is_nil () == false) {
			RelevancyDocuments data = res->data ();
			// Удалим элементы с релевантностью меньше заданной
			data.erase (
				std::remove_if (data.begin (), data.end (), MinRelFinder (m_max_value)), data.end ()
			);
			// Расчет количества вхождений по каждому найденному документу
			std::for_each (
				data.begin (), data.end (), EntryPointCounter (m_searcher.in (), req_str, m_max_value, ret)
			);
			//dump (data);
		}
	} catch (Search::CanceledByUser&) {
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
	}

	return ret;
}

}
