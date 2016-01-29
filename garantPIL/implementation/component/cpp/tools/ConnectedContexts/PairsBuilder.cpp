//
// PairsBuilder.cpp : implementation file
//

#include "ace/ACE.h"

#include "boost/bind.hpp"
#include "boost/algorithm/string/join.hpp"

#include <fstream>

#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Manage/Manage.h"

#include "garantCore/SearchAdapterLib/Cache/Cache.h"

#include "PairsBuilder.h"

namespace ConnectedContexts {

static const size_t RESERVE_SIZE = 2048;

struct Helper {
	static void add (Dict& res, const std::string& first, const std::string& second) {
		res.push_back (SynPair (first, second));
	}

	static void out (const ConContexts::value_type& data, std::ofstream& ofs) {
		for (GCL::StrSet::const_iterator it = data.second.begin (); it != data.second.end (); ++it) {
			ofs << data.first << ";" << *it << std::endl;
		}
	}

	static void out (const Dict& data, const char* delim, std::ofstream& ofs) {
		for (Dict::const_iterator it = data.begin (); it != data.end (); ++it) {
			ofs << it->first << delim << it->second << std::endl;
		}
	}
};

bool operator == (const SynPair& x, const SynPair& y) {
	if (x.first == y.first) {
		return true;
	} else if (y.first.size () > x.first.size ()) {
		const std::string& str  = y.first;

		size_t pos = str.find (x.first);

		if (pos != std::string::npos) {
			if (pos == 0 || str [pos - 1] == ' ' || str [pos - 1] == '~' || str [pos - 1] == '-') {
				size_t last = pos + x.first.size ();

				if (last == str.size () || str [last] == ' ' || str [last] == '~' || str [last] == '-') {
					return true;
				}
			}
		}
	}

	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////

PairsBuilder::PairsBuilder (const std::string& path) /*: m_count (0)*/ {
	Core::GDS::StopWatch sw ("construct");

	m_base = new ToolsBase (path);

	SearchAdapterLib::Cache::instance ()->init (m_base->abstract_base ());

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (m_base->abstract_base (), true);

	m_env.normalizer = Morpho::Factory::make (cache.in ());
}

PairsBuilder::~PairsBuilder () {
}

void PairsBuilder::execute (const Properties& properties) {
	std::ofstream ofs (properties.out.c_str (), std::ios_base::trunc);

	if (ofs) {
		try {
			Core::GDS::StopWatch sw ("build dict");

			PairsBuilder::build_dict (properties.in);
		} catch (...) {
			LOG_UEX (("%s: build dict", GDS_CURRENT_FUNCTION));
		}

		ConContexts data;

		try {
			Core::GDS::StopWatch sw ("find connected contexts");

			std::for_each (m_dict.begin (), m_dict.end ()
				, boost::bind (&PairsBuilder::find_contexts, this, _1, boost::ref (data))
			);
		} catch (...) {
			LOG_UEX (("%s: find connected contexts", GDS_CURRENT_FUNCTION));
		}

		try {
			std::for_each (data.begin (), data.end (), boost::bind (&Helper::out, _1, boost::ref (ofs)));
		} catch (...) {
			LOG_UEX (("%s: write to file", GDS_CURRENT_FUNCTION));
		}

		ofs.close ();

	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.out.c_str ()));
	}
}

void PairsBuilder::get_syns (const std::string& req, GCL::StrVector& out, Manage::IQuery* query) {
	m_normalizer->execute_for_phrase (req, out);

	query->clear ();

	for (GCL::StrVector::const_iterator it = out.begin (); it != out.end (); ++it) {
		query->add (Defs::Request (*it), false);
	}

	Core::Aptr <Search::SplitRequests> requests = query->get_data ();

	out.resize (requests->size ());

	for (size_t i = 0; i < out.size (); ++i) {
		out [i] = boost::join (requests->at (i).context, " ");
	}
}

void PairsBuilder::build_dict (const std::string& path) {
	std::ifstream ifs (path.c_str ());

	if (ifs) {
		m_dict.reserve (RESERVE_SIZE);

		std::string str;

		Manage::IQuery_var query = Manage::IQueryFactory::make (
			m_env, SearchAdapterLib::Cache::instance ()->get ()
		);

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false && str [0] != ';') {
				GCL::StrVector data;
				this->get_syns (str, data, query.in ());

				std::for_each (data.begin (), data.end ()
					, boost::bind (&Helper::add, boost::ref (m_dict), _1, str)
				);
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void PairsBuilder::find_contexts (const SynPair& val, ConContexts& out) {
	for (Dict::const_iterator it = m_dict.begin (); it != m_dict.end (); ++it) {
		if (val.second != it->second) {
			if (val == *it) {
				out [val.second].insert (it->second);
			}
		}
	}
}

}