//
// NormDef.cpp : implementation file
//

#include "ace/ACE.h"

#include <iterator>
#include <fstream>

#include "boost/lexical_cast.hpp"

#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

#include "NormDef.h"

namespace NormativeDefinitions {

NormDef::NormDef (const std::string& path) {
	m_base = new YBase (path.c_str (), O_RDONLY);
}

NormDef::~NormDef () {
}

void NormDef::execute (const Properties& properties) {
	if (m_base.is_nil () || m_base->IsOk () == false) {
		LOG_E (("%s: invalid base", GDS_CURRENT_FUNCTION));
	} else {
		std::ifstream ifs (properties.in.c_str ());

		if (ifs) {
			DocIds ids;

			std::string str;

			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () == false && str [0] != ';') {
					ids.push_back (boost::lexical_cast <long> (str));
				}
			}

			//std::copy (ids.begin (), ids.end (), std::ostream_iterator <unsigned long> (std::cout, "\n"));

			try {
				this->execute (ids, properties.out);
			} catch (...) {
				LOG_UEX (("%s: canceled", GDS_CURRENT_FUNCTION));
			}

			ifs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.in.c_str ()));
		}
	}
}

void NormDef::execute (const DocIds& ids, const std::string& out_path) {
	std::ofstream ofs (out_path.c_str (), std::ios_base::trunc);

	if (ofs) {
		EndtTools::EndtParser parser (m_base.in ());

		EndtTools::ProcessIndicator indicator (GDS_CURRENT_FUNCTION);
		indicator.init (ids.size ());

		GCL::StrVector out;
		out.reserve (1024);

		for (DocIds::const_iterator it = ids.begin (); it != ids.end (); ++it) {
			indicator.update (std::distance (ids.begin (), it), *it);
			parser.get_norm_definitions (*it, out);
			std::copy (out.begin (), out.end (), std::ostream_iterator <std::string> (ofs, "\n"));
			out.clear ();
		}

		ofs.close ();
	}
}

}
