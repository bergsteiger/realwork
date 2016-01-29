//
// RequestTransformer.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>
#include "boost/bind.hpp"

#include "shared/GCL/str/str_conv.h"
#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Common/ContextUtility.h"

#include "garantCore/SearchAdapterLib/Cache/Cache.h"

#include "RequestTransformer.h"

namespace RequestTransform {

/////////////////////////////////////////////////////////////////////////////////////////////////////////

RequestTransformer::RequestTransformer (const std::string& path) {
	m_base = new ToolsBase (path);

	SearchAdapterLib::Cache::instance ()->init (m_base->abstract_base ());

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (m_base->abstract_base (), true);

	m_env.normalizer = Morpho::Factory::make (cache.in ());
	m_query = Manage::IQueryFactory::make (m_env, SearchAdapterLib::Cache::instance ()->get ());
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
					GCL::StrVector lemmas;

					ofs << str << ": ";
					this->out_requests (ofs, lemmas, str);
					ofs << ": ";
					this->out_lemmas (ofs, lemmas); // печать всех полученных лемм
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

// Печать списка запросов
void RequestTransformer::out_requests (std::ofstream& ofs, GCL::StrVector& lemmas, const std::string& str) {
	m_query->clear ();
	m_query->add (Defs::Request (str), false);

	size_t count = 0;

	Core::Aptr <Search::SplitRequests> requests = m_query->get_data ();

	std::for_each (requests->begin (), requests->end ()
		, boost::bind (&RequestTransformer::out_request, this
		, boost::ref (ofs)
		, boost::ref (lemmas), _1
		, boost::ref (count))
	);
}

// Нормализация
void RequestTransformer::normalize (const std::string& word, RequestList& reqs, GCL::StrVector& lemmas) {
	if (*(word.rbegin ()) == '!' || *(word.rbegin ()) == '*') {
		for (RequestList::iterator it = reqs.begin (); it != reqs.end (); ++it) {
			it->push_back (word);
		}
		lemmas.push_back (std::string (" ") + word);
	} else {
		std::string forma;

		Morpho::Def::NSettings info;
		info.as_key = false;

		{
			Core::Aptr <GCL::StrSet> normas = m_env.normalizer->execute (word, forma, info);

			if (reqs.size ()) {
				RequestList tmp;

				for (RequestList::const_iterator _it = reqs.begin (); _it != reqs.end (); ++_it) {
					for (GCL::StrSet::const_iterator it = normas->begin (); it != normas->end (); ++it) {
						tmp.push_back (*_it);
						tmp.back ().push_back (*it);
					}
				}

				reqs.swap (tmp);
			} else {
				for (GCL::StrSet::const_iterator it = normas->begin (); it != normas->end (); ++it) {
					reqs.push_back (GCL::StrVector (1, *it));
				}
			}
		}

		{
			info.is_extended = true;
			info.as_key = false;

			Core::Aptr <GCL::StrSet> normas = m_env.normalizer->execute (word, forma, info);

			lemmas.insert (lemmas.begin (), normas->begin (), normas->end ());
		}
	}
}

// Печать синонимированного нормализованного запроса
void out_norm_request (std::ofstream& ofs, const Search::Phrase& req, const Relevancy::Data& data, size_t& count) {
	if (count) {
		ofs << ";";
	}

	++count;

	Search::Phrase::const_iterator it_begin = req.begin (), it_end = req.end ();

	const Relevancy::Positions& strongs = data.strongs;
	const Relevancy::Frames& frames = data.frames;

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

// Печать синонимированного запроса
void RequestTransformer::out_request (
	std::ofstream& ofs
	, GCL::StrVector& lemmas
	, const Search::SplitRequest& req
	, size_t& count
) {
	RequestList out;

	std::for_each (req.context.begin (), req.context.end ()
		, boost::bind (&RequestTransformer::normalize, this, _1
		, boost::ref (out)
		, boost::ref (lemmas))
	);

	std::for_each (out.begin (), out.end ()
		, boost::bind (&RequestTransform::out_norm_request
		, boost::ref (ofs), _1, req.data
		, boost::ref (count))
	);
}

// Печать всех полученных лемм
void RequestTransformer::out_lemmas (std::ofstream& ofs, GCL::StrVector& lemmas) {
	std::sort (lemmas.begin (), lemmas.end ());
	lemmas.erase (std::unique (lemmas.begin (), lemmas.end ()), lemmas.end ());
	std::copy (lemmas.begin (), lemmas.end (), std::ostream_iterator <std::string> (ofs, " "));
}

}
