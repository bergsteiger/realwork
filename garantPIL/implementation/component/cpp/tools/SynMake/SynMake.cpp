//
// SynMake.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>

#include "shared/GCL/str/str_conv.h"
#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Manage/Manage.h"

#include "garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"

#include "SynMake.h"

namespace SynMake {

SynMaker::SynMaker (const std::string& path) {
	m_base = new ToolsBase (path);
}

SynMaker::~SynMaker () {
}

void SynMaker::execute (const std::string& in, const std::string& out) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	using namespace ContextSearch;

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (m_base->abstract_base (), true);

	Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());
	DBComm::IDBCommunicator_var communicator = new SearchAdapterLib::DBComm_i::DBCommunicator_i (
		m_base->abstract_base ()
	);

	Manage::IRequestTransformer_var transformer = Manage::IRequestTransformerFactory::make (normalizer.in ());

	const DBComm::PSDTemplates templates;
	const GCL::StrVector& exl_data = communicator->get_exclude_data ();

	std::ifstream ifs (in.c_str ());

	if (ifs) {
		std::ofstream ofs (out.c_str (), std::ios_base::trunc);

		std::string path_4hard = out;

		path_4hard.erase (path_4hard.find_last_of ('\\'));
		path_4hard += "\\4hard.txt";

		std::ofstream ofs_4hard (path_4hard.c_str (), std::ios_base::trunc);

		if (ofs && ofs_4hard) {
			std::string str, key, mod_key;

			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () == false) {
					size_t pos = str.find (';'); // ищем вхождение

					GDS_ASSERT (pos != std::string::npos);

					if (pos != std::string::npos) {
						key = str.substr (0, pos);

						GDS_ASSERT (key.empty () == false);

						Core::Aptr <GCL::StrSet> res;
						{
							GCL::StrVector data;
							normalizer->execute_for_phrase (key, data);
							res = new GCL::StrSet (data.begin (), data.end ());
						}

						if (res.is_nil ()) {
							GDS_ASSERT (0);
						} else {
							str.assign (str.begin () + pos, str.end ());
							GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*str.begin ()), 0);

							for (GCL::StrSet::const_iterator it = res->begin (); it != res->end (); ++it) {
								mod_key = *it;
								transformer->exclude (mod_key, exl_data, templates, false);

								if (mod_key.size () != it->size ()) {
									ofs_4hard << key << ";" << mod_key << std::endl;
								}

								GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*mod_key.begin ()), 0);
								ofs << mod_key << str << std::endl;
							}
						}
					} else {
						LOG_W (("invalid string: %s", str.c_str ()));
						GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*str.begin ()), 0);
						ofs << str << std::endl;
					}
				}
			}

			ofs.close ();
			ofs_4hard.close ();
		} else {
			LOG_E (("%s: can't open %s or %s", GDS_CURRENT_FUNCTION, out.c_str (), path_4hard.c_str ()));
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, in.c_str ()));
	}
}

}

