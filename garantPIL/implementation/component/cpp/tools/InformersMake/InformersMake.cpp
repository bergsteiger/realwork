//
// InformersMake.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>

#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Manage/Manage.h"

#include "garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"

#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/split.hpp"

#include "DBComm.h"
#include "InformersMake.h"

namespace InformersMake {

InformersMaker::InformersMaker (const std::string& path) {
	m_base = new SearchBase (path.c_str (), ACE_OS_O_RDONLY);
}

InformersMaker::~InformersMaker () {
}

void InformersMaker::execute (const std::string& in, const std::string& out) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	DBCore::IBase_var base = DBCore::DBFactory::make (m_base.in ());

	using namespace ContextSearch;

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (base.in (), true);

	Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());

	DBComm::IDBCommunicator_var communicator = new SearchAdapterLib::DBComm_i::DBCommunicator_i (base.in ());

	Manage::IRequestTransformer_var transformer = Manage::IRequestTransformerFactory::make (normalizer.in ());

	const DBComm::PSDTemplates templates;
	const GCL::StrVector& exl_data = communicator->get_exclude_data ();

	/*
	std::string root_path = out;
	root_path.erase (root_path.find_last_of ('\\'));
	*/

	std::ifstream ifs (in.c_str ());

	if (ifs) {
		GCL::StrSet informers;

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

				GDS_ASSERT (parts.size () == 4);

				GCL::StrSet keys;

				GCL::StrVector norms;
				normalizer->execute_for_phrase (parts [0], norms);

				for (GCL::StrVector::iterator it = norms.begin (); it != norms.end (); ++it) {
					transformer->exclude (*it, exl_data, templates, false);
					keys.insert (*it);
				}

				std::string data;
				{
					for (GCL::StrVector::const_iterator it = parts.begin () + 1; it != parts.end (); ++it) {
						data += ';';
						data += *it;
					}
				}

				for (GCL::StrSet::const_iterator it = keys.begin (); it != keys.end (); ++it) {
					std::string val = *it + data;
					informers.insert (val);
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

