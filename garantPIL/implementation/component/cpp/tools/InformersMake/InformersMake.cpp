//
// InformersMake.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>

#include "shared/GCL/str/str_conv.h"
#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Manage/Manage.h"

#include "garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"

#include "boost/lexical_cast.hpp"
#include "boost/algorithm/string/join.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/split.hpp"

#include "DBComm.h"
#include "InformersMake.h"

namespace InformersMake {

InformersMaker::InformersMaker (const std::string& path) {
	m_base = new SearchBase (path.c_str (), ACE_OS_O_RDONLY);
}

void InformersMaker::execute (const std::string& in, const std::string& out) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	DBCore::IBase_var base = DBCore::DBFactory::make (m_base.in ());

	using namespace ContextSearch;

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (base.in ());

	DBComm::IDBCommunicator_var communicator = new SearchAdapterLib::DBComm_i::DBCommunicator_i (base.in ());

	Manage::Env env;
	env.normalizer = Morpho::Factory::make (cache.in ());

	Manage::IQuery_var query = Manage::IQueryFactory::make (env, communicator.in ());

	size_t counter = 1;

	std::ifstream ifs (in.c_str ());

	if (ifs) {
		GCL::StrVector informers;
		informers.reserve (200000);

		GCL::StrSet unique_data;

		std::string str;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false) {
				GCL::StrVector parts;
				{
					std::string str_copy = str;

					boost::trim_if (str_copy, boost::is_any_of (";"));
					boost::split (parts, str_copy, boost::is_any_of (";"));
				}

				GDS_ASSERT (parts.size () == 3);

				query->clear ();
				query->add (Defs::Request (parts [0]), false);

				Core::Aptr <Search::SplitRequests> res = query->get_data ();

				GCL::StrSet keys;

				for (Search::SplitRequests::const_iterator it = res->begin (); it != res->end (); ++it) {
					keys.insert (boost::join (it->context, " ")); // ключи сначала в set (возможны дубликаты)
				}

				for (GCL::StrSet::const_iterator it = keys.begin (); it != keys.end (); ++it) {
					Core::Aptr <GCL::StrVector> norms = env.normalizer->execute_for_phrase (*it);

					for (GCL::StrVector::iterator _it = norms->begin (); _it != norms->end (); ++_it) {
						std::string _str = *_it + parts [1];

						if (unique_data.find (_str) == unique_data.end ()) {
							std::string data = ";middle\\"+ boost::lexical_cast <std::string> (counter); 
							data += ";" + parts [1];
							data += ";" + parts [2];

							informers.push_back (*_it);
							informers.back () += data;

							GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*informers.back ().begin ()), 0);

							unique_data.insert (_str);
							++counter;
						}
					}
				}
			}
		}

		{
			std::ofstream ofs (out.c_str (), std::ios_base::trunc);

			if (ofs) {
				std::copy (informers.begin (), informers.end (), std::ostream_iterator <std::string> (ofs, "\n"));
				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, out.c_str ()));
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, in.c_str ()));
	}
}

}

