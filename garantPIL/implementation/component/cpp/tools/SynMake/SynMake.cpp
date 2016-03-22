//
// SynMake.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>

#include "shared/GCL/str/str_conv.h"
#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Manage/Manage.h"

#include "garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"

#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/split.hpp"

#include "SynMake.h"
#include "DBComm.h"

namespace SynMake {

SynMaker::SynMaker (const std::string& path) {
	m_base = new ToolsBase (path);
}

void SynMaker::execute (const std::string& in, const std::string& out) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	using namespace ContextSearch;

	DBCore::IBase_var _base = DBCore::DBFactory::make (m_base.in ());

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (_base.in ());

	Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());
	DBComm::IDBCommunicator_var communicator = new SearchAdapterLib::DBComm_i::DBCommunicator_i (_base.in ());

	Manage::IRequestTransformer_var transformer = Manage::IRequestTransformerFactory::make (normalizer.in ());

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

						Core::Aptr <GCL::StrVector> res = normalizer->execute_for_phrase (key);
						std::sort (res->begin (), res->end ());

						if (res.is_nil ()) {
							GDS_ASSERT (0);
						} else {
							str.assign (str.begin () + pos, str.end ());
							GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*str.begin ()), 0);

							for (GCL::StrVector::const_iterator it = res->begin (); it != res->end (); ++it) {
								mod_key = *it;
								transformer->exclude (mod_key, exl_data);

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

void SynMaker::execute (const std::string& in, const std::string& out, const std::string& stop_path, bool is_hard) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	using namespace ContextSearch;

	DBCore::IBase_var _base = DBCore::DBFactory::make (m_base.in ());

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (_base.in ());

	Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());

	DBComm::IDBCommunicator_var communicator = new SearchAdapterLib::DBComm_i::DBCommunicator_i (_base.in ());

	Manage::IRequestTransformer_var transformer = Manage::IRequestTransformerFactory::make (normalizer.in ());

	const GCL::StrVector& exl_data = communicator->get_exclude_data ();
	const GCL::StrVector& hard_data = communicator->get_hard_phrases ();

	std::string root_path = out;
	root_path.erase (root_path.find_last_of ('\\'));

	GCL::StrSet stop_phr;
	{
		std::ifstream ifs;

		if (stop_path.empty ()) {
			std::string _path = root_path + "\\syns_stop.txt";
			ifs.open (_path.c_str ());
		} else {
			ifs.open (stop_path.c_str ());
		}

		if (ifs) {
			std::string str;

			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () == false) {
					boost::trim_if (str, boost::is_any_of (" ;"));
					stop_phr.insert (str);
				}
			}

			ifs.close ();
		}
	}

	std::ifstream ifs (in.c_str ());

	if (ifs) {
		GCL::StrSet polysemy, syns, hard;

		std::string str, key, mod_key;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false) {
				GCL::StrVector parts;
				boost::trim_if (str, boost::is_any_of (";"));
				boost::split (parts, str, boost::is_any_of (";"));

				GCL::StrSet keys, data;
				{
					for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); ++it) {
						Core::Aptr <GCL::StrVector> norms = transformer->execute (
							*it, exl_data, (is_hard)? hard_data : GCL::StrVector ()
						);

						GCL::StrSet tmp;
						{
							for (GCL::StrVector::iterator _it = norms->begin (); _it != norms->end (); ++_it) {
								if (it == parts.begin ()) {
									keys.insert (*_it);

									if (is_hard == false) {
										size_t count1 = std::count_if (parts [0].begin (), parts [0].end (), boost::is_any_of (" -~"));
										size_t count2 = std::count_if (_it->begin (), _it->end (), boost::is_any_of (" -~"));

										if (count1 != count2) {
											std::string h_str = parts [0];
											h_str += ';';
											h_str += *_it;
											hard.insert (h_str);
										}
									}
								} else if (stop_phr.find (*_it) == stop_phr.end ()) {
									data.insert (*_it);
									tmp.insert (*_it);
								}
							}
						}

						if (tmp.size () > 1) {
							std::string p_str;

							for (GCL::StrSet::iterator _it = tmp.begin (); _it != tmp.end (); ++_it) {
								if (_it != tmp.begin ()) {
									p_str += ";";
								}
								p_str += *_it;
							}

							polysemy.insert (p_str);
						}
					}
				}

				if (data.empty () == false) {
					for (GCL::StrSet::const_iterator it = keys.begin (); it != keys.end (); ++it) {
						std::string val = *it;

						for (GCL::StrSet::iterator _it = data.begin (); _it != data.end (); ++_it) {
							val += ';';
							val += *_it;
						}

						syns.insert (val);
					}
				}
			}
		}

		typedef std::map <std::string, size_t> DMap;

		DMap d_map;

		for (GCL::StrSet::const_iterator it = syns.begin (); it != syns.end (); ++it) {
			GCL::StrVector parts;
			boost::split (parts, *it, boost::is_any_of (";"));

			DMap::iterator f_it = d_map.find (parts [0]);

			if (f_it == d_map.end ()) {
				f_it = d_map.insert (DMap::value_type (parts [0], 1)).first;
			} else {
				++(f_it->second);
			}
		}

		{
			std::ofstream ofs (out.c_str (), std::ios_base::trunc);

			if (ofs) {
				for (GCL::StrSet::const_iterator it = syns.begin (); it != syns.end (); ++it) {
					std::string _str = *it;
					GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*_str.begin ()), 0);
					ofs << _str << std::endl;
				}
				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, out.c_str ()));
			}
		}

		{
			std::string _path = root_path + "\\dup_keys.txt";
			std::ofstream ofs (_path.c_str (), std::ios_base::trunc);

			if (ofs) {
				for (DMap::const_iterator it = d_map.begin (); it != d_map.end (); ++it) {
					if (it->second > 1) {
						ofs << it->first << " : " << it->second << std::endl;
					}
				}
				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, _path.c_str ()));
			}
		}

		{
			std::string _path = root_path + "\\4hard.txt";
			std::ofstream ofs (_path.c_str (), std::ios_base::trunc);

			if (ofs) {
				std::copy (hard.begin (), hard.end (), std::ostream_iterator <std::string> (ofs, "\n"));
				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, _path.c_str ()));
			}
		}

		{
			std::string _path = root_path + "\\polysemy.txt";
			std::ofstream ofs (_path.c_str (), std::ios_base::trunc);

			if (ofs) {
				std::copy (polysemy.begin (), polysemy.end (), std::ostream_iterator <std::string> (ofs, "\n"));
				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, _path.c_str ()));
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, in.c_str ()));
	}
}

}

