//
// RequestTransformer.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>
#include "boost/bind.hpp"

#include "shared/Morpho/Facade/Factory.h"

#include "garantCore/SearchAdapterLib/Cache/Cache.h"

#include "RequestTransformer.h"
#include "DBComm.h"

namespace RequestTransform {

/////////////////////////////////////////////////////////////////////////////////////////////////////////

static void add_word (const std::string& word, GCL::StrVector& lemmas) {
	lemmas.push_back (word);

	const DBComm::Synonyms& syns = SearchAdapterLib::Cache::instance ()->get ()->get_ssyns ();

	DBComm::SynPair pair;
	pair.key = word;

	DBComm::Synonyms::const_iterator it = std::lower_bound (syns.begin (), syns.end (), pair, DBComm::SynCompare ());

	if (it != syns.end () && it->key == word) {
		lemmas.insert (lemmas.end (), it->data.begin (), it->data.end ());
	}
}

static void out_req (std::ofstream& ofs, GCL::StrVector& lemmas, const Search::SplitRequest& req, size_t& count) {
	std::for_each (req.context.begin (), req.context.end (), boost::bind (&add_word, _1, boost::ref (lemmas)));

	if (count) {
		ofs << ";";
	}

	++count;

	Search::Phrase::const_iterator it_begin = req.context.begin (), it_end = req.context.end ();

	const Relevancy::Positions& strongs = req.data.strongs;
	const Relevancy::Frames& frames = req.data.frames;

	Relevancy::Frames::const_iterator f_it = frames.begin ();

	for (Search::Phrase::const_iterator it = it_begin; it != it_end; ++it) {
		size_t i = std::distance (it_begin, it);

		if (it != it_begin) {
			if (std::find (strongs.begin (), strongs.end (), i) != strongs.end ()) {
				ofs << "-";
			} else {
				ofs << " ";
			}
		}

		ofs << *it;

		if (f_it != frames.end () && i == f_it->pos) {
			for (size_t j = 1; j < f_it->count; ++j) {
				ofs << "~";
				++it;
				GDS_ASSERT (it != it_end);
				ofs << *it;
			}
			++f_it;
		} 
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

RequestTransformer::RequestTransformer (const std::string& path) {
	m_base = new ToolsBase (path);

	DBCore::IBase_var base = DBCore::DBFactory::make (m_base.in ());

	SearchAdapterLib::Cache::instance ()->init (base.in ());

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (base.in ());

	Manage::Env env;
	env.normalizer = Morpho::Factory::make (cache.in ());
	m_query = Manage::IQueryFactory::make (env, SearchAdapterLib::Cache::instance ()->get ());
}

RequestTransformer::~RequestTransformer () {
}

void RequestTransformer::execute (const std::string& in, const std::string& out) {
	std::ifstream ifs (in.c_str ());

	if (ifs) {
		std::ofstream ofs (out.c_str (), std::ios_base::trunc);

		if (ofs) {
			std::string str;

			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () == false && str [0] != ';') {
					ofs << str << ": ";

					m_query->clear ();
					m_query->add (Defs::Request (str), false);

					Core::Aptr <Search::SplitRequests> requests = m_query->get_data ();

					size_t count = 0;

					GCL::StrVector lemmas;

					std::for_each (requests->begin (), requests->end ()
						, boost::bind (&out_req, boost::ref (ofs), boost::ref (lemmas), _1, boost::ref (count))
					);

					ofs << ": ";

					std::sort (lemmas.begin (), lemmas.end ());
					lemmas.erase (std::unique (lemmas.begin (), lemmas.end ()), lemmas.end ());
					std::copy (lemmas.begin (), lemmas.end (), std::ostream_iterator <std::string> (ofs, " "));

					ofs << std::endl;
				}
			}

			ofs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, out.c_str ()));
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, in.c_str ()));
	}
}

}
