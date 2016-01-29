//
// Main.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include <fstream>
#include <iterator>

#include "boost/assign/std/set.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "shared/ContextSearch/impl/Manage_i/RequestTransformer_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/Query_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/SynManager_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsParts_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSequence_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSimple_i_factory.h"

#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "shared/ContextSearch/Common/ContextUtility.h"

#include "garantCore/SearchAdapterLib/Cache/Cache.h"

#include "ROCBase.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// FactoryRegistrator implementation

class FactoryRegistrator {
public:
	static void execute () {
		FactoryRegistrator::registrate <ContextSearch::Manage_i::RequestTransformer_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::Query_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::SynManager_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::ViewAsParts_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::ViewAsSimple_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::ViewAsSequence_i_factory> ();
	}

private:
	template <typename Type>
	static void registrate () {
		Core::Var <Type> obj = new Type ();
		obj->registrate_me (0);
	}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

struct _Pair {
	size_t count;
	std::string str;

	_Pair () : count (0) {
	}

	bool operator == (const std::string& val) const {
		return str == val;
	}

	inline bool operator > (const _Pair& val) const {
		if (count == val.count) {
			return str < val.str;
		}
		return count > val.count;
	}
};

typedef std::vector <_Pair> _Pairs;

std::ostream& operator << (std::ostream& out, const _Pair& data) {
	out << data.str.c_str () + 1 << ": " << data.count;
	return out;
}

std::string make_str (const ContextSearch::Search::SplitRequest& in) {
	std::string ret;

	using namespace ContextSearch;

	Search::Phrase::const_iterator it_begin = in.context.begin (), it_end = in.context.end ();

	const Relevancy::Positions& strongs = in.data.strongs;
	const Relevancy::Frames& frames = in.data.frames;

	Relevancy::Frames::const_iterator f_it = frames.begin ();

	for (Search::Phrase::const_iterator it = it_begin; it != it_end; ++it) {
		size_t i = std::distance (it_begin, it);

		if (it != it_begin) {
			if (std::find (strongs.begin (), strongs.end (), i) != strongs.end ()) {
				ret += "-";
			} else {
				ret += " ";
			}
		}

		ret += *it;

		if (f_it != frames.end () && i == f_it->pos) {
			for (size_t j = 1; j < f_it->count; ++j) {
				ret += "~";
				++it;
				GDS_ASSERT (it != it_end);
				ret += *it;
			}
			++f_it;
		} 
	}

	return ret;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Executor implementation

class Executor {
public:
	Executor (int argc, char* argv []) {
		Core::ParamManagerInitData id;
		id.application_name = "TopLexemes";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		Core::ParamManagerReg::instance ();
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);	

		if (Core::ParamManagerFactory::get ().is_exist ("-in")) {
			m_in = Core::ParamManagerFactory::get ().get_string ("-in");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-out")) {
			m_out = Core::ParamManagerFactory::get ().get_string ("-out");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-path")) {
			m_path = Core::ParamManagerFactory::get ().get_string ("-path");
		}

		m_is_nd = Core::ParamManagerFactory::get ().is_exist ("-nd");
		m_is_np = Core::ParamManagerFactory::get ().is_exist ("-np");
		m_is_nî = Core::ParamManagerFactory::get ().is_exist ("-no");
		m_is_list = Core::ParamManagerFactory::get ().is_exist ("-list");
		m_is_lite = Core::ParamManagerFactory::get ().is_exist ("-lite");
		m_top_phrases = Core::ParamManagerFactory::get ().is_exist ("-phrases");

		std::cout << std::endl << "("<< __DATE__<< ", "<< __TIME__	<< ")"<< std::endl<< std::endl;

		std::string default_path = argv [0];

		const char* slash = ACE_OS_String::strrchr (default_path.c_str (), '\\');

		if (slash) {
			size_t pos = default_path.find (slash);

			if (pos != std::string::npos) {
				default_path = default_path.substr (0, pos);
			}

			if (m_in.empty ()) {
				m_in = default_path;
			}

			if (m_out.empty ()) {
				m_out = default_path;
			}
		}

		std::cout << "in  : " << m_in   << std::endl;
		std::cout << "out : " << m_out  << std::endl;
		std::cout << "path: " << m_path << std::endl;
		std::cout << "for cache: "    << m_is_list << std::endl;
		std::cout << "without pseudo: " << m_is_np << std::endl;
		std::cout << "without digits: " << m_is_nd << std::endl;

		std::cout 
			<< std::endl 
			<< "---------------------------------------------" 
			<< std::endl 
			<< std::endl;
	}

	virtual ~Executor () {
	}

	void execute () {
		if (m_path.empty ()) {
			LOG_E (("Path to base is not initialized", GDS_CURRENT_FUNCTION));
			return;
		}

		Core::GDS::StopWatch sw ("total");

		CachedBaseRO base (m_path.c_str ());
		base.IsOk ();
		base.check_version ();

		if (m_top_phrases) {
			this->execute_for_phrases (base.abstract_base ());
		} else if (m_is_lite) {
			this->execute_lite (base.abstract_base ());
		} else {
			this->execute_std (base.abstract_base ());
		}
	}

	void execute_for_phrases (DBCore::IBase* base) {
		FactoryRegistrator::execute ();

		using namespace ContextSearch;

		SearchAdapterLib::Cache* _cache = SearchAdapterLib::Cache::instance ();
		_cache->init (base);

		Morpho::Def::ICache_var cache = Morpho::Factory::make ();
		cache->load (base, true);

		Manage::Env env;
		env.normalizer = Morpho::Factory::make (cache.in ());

		Manage::IQuery_var query = Manage::IQueryFactory::make (env, _cache->get ());

		_Pair item;
		_Pairs data;

		typedef std::map <std::string, GCL::StrVector> _Map;
		_Map dup_data;

		std::ifstream ifs (m_in.c_str ());

		if (ifs) {
			std::ofstream ofs (m_out.c_str (), std::ios_base::trunc);

			if (ofs) {
				std::string str;

				size_t i = 0;

				while (!ifs.eof ()) {
					std::getline (ifs, str);

					std::cout << str << " : " << i << std::endl;

					try {
						query->clear ();
						query->add (Defs::Request (str), false);

						Core::Aptr <Search::SplitRequests> res = query->get_data ();

						GCL::StrSet total;

						for (Search::SplitRequests::const_iterator it = res->begin (); it != res->end (); ++it) {
							std::string req = make_str (*it);

							GCL::StrVector parts;
							boost::split (parts, req, boost::is_space ());

							for (GCL::StrVector::const_iterator _it = parts.begin (); _it != parts.end (); ++_it) {
								if (std::find_if (_it->begin (), _it->end (), boost::is_any_of (" -~")) == _it->end ()) {
									continue;
								}

								if (std::find_if (_it->begin (), _it->end (), boost::is_any_of (" ~")) == _it->end ()) {
									Morpho::Def::StrStrMap pseudo;
									Core::Aptr <GCL::StrVector> norm = env.normalizer->execute_for_phrase (*_it, pseudo);
									total.insert (norm->begin (), norm->end ());
								}
							}
						}

						for (GCL::StrSet::const_iterator _it = total.begin (); _it != total.end (); ++_it) {
							_Pairs::iterator f_it = std::find (data.begin (), data.end (), *_it);

							if (f_it == data.end ()) {
								data.push_back (item);
								data.back ().count = 1;
								data.back ().str = *_it;

								if (_it->size () > 30) {
									dup_data [_it->substr (0, 31)].push_back (*_it);
								}
							} else {
								++f_it->count;
							}
						}

						++i;
					} catch (Manage::InvalidQuery&) {
						LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
					} catch (...) {
						LOG_UEX ((GDS_CURRENT_FUNCTION));
					}
				}

				std::sort (data.begin (), data.end (), std::greater <_Pair> ());
				
				for (_Pairs::const_iterator it = data.begin (); it != data.end (); ++it) {
					const std::string& _str = it->str;

					if (std::find_if (_str.begin (), _str.end (), boost::is_from_range ('0', '9')) != _str.end ()) {
						if (std::count (_str.begin (), _str.end (), '-') == 2) {
							if (_str [0] >= '0' && _str [0] <= '9' && _str [_str.size () - 1] >= '0' && _str [_str.size () - 1] <= '9') {
								continue;
							}
						}
					}

					if (it->str.size () > 30) {
						_Map::const_iterator d_it = dup_data.find (it->str.substr (0, 31));

						if (d_it != dup_data.end ()) {
							if (d_it->second.size () > 1) {
								continue;
							}
						}
					}

					ofs << it->str << ": "<< it->count << std::endl;
				}

				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, m_out.c_str ()));
			}

			ifs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, m_in.c_str ()));
		}
	}

	void execute_lite (DBCore::IBase* base) {
		Morpho::Def::ICache_var cache = Morpho::Factory::make ();
		cache->load (base, true);

		Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());

		_Pair item;
		_Pairs data;
		data.reserve (16 * 1024);

		std::ifstream ifs (m_in.c_str ());

		if (ifs) {
			std::ofstream ofs (m_out.c_str (), std::ios_base::trunc);

			if (ofs) {
				std::string str;
				std::string delim (1, (unsigned char) 160);

				size_t i = 0;

				while (!ifs.eof ()) {
					std::getline (ifs, str);

					std::cout << str << " : " << i << std::endl;

					if (str.empty ()) {
						continue;
					}

					try {
						GCL::StrVector parts;
						boost::split (parts, str
							, boost::is_punct () || boost::is_space () || boost::is_any_of (delim.c_str ())
						);

						for (size_t j = 0; j < parts.size (); ++j) {
							if (parts [j].empty ()) {
								continue;
							}

							Core::Aptr <GCL::StrSet> res = normalizer->execute (parts [j], true);

							for (GCL::StrSet::const_iterator it = res->begin (); it != res->end (); ++it) {
								_Pairs::iterator f_it = std::find (data.begin (), data.end (), *it);

								if (f_it == data.end ()) {
									data.push_back (item);
									data.back ().count = 1;
									data.back ().str = *it;
								} else {
									++f_it->count;
								}
							}
						}

						++i;
					} catch (...) {
						LOG_UEX ((GDS_CURRENT_FUNCTION));
					}
				}

				std::sort (data.begin (), data.end (), std::greater <_Pair> ());
				std::copy (data.begin (), data.end (), std::ostream_iterator <_Pair> (ofs, "\n"));

				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, m_out.c_str ()));
			}

			ifs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, m_in.c_str ()));
		}

		std::cout << std::endl;
	}

	void execute_std (DBCore::IBase* base) {
		FactoryRegistrator::execute ();

		GCL::StrSet stops;
		{
			using namespace boost::assign;

			stops += "ÎÒ", "ÎÁ", "ÍÀ", "ÄÎ", "ÏÎÑËÅ", "ÏÅÐÅÄ", "ÏÎÄ", "ÏÎ", "ÁÅÇ", "ÏÐ", "ÇÀ", "ÎÍÀ"
				, "ÈÇ", "ÑÎ", "ÇÀÒÅÌ", "ÑÓÄÍÎ", "ÑÒÐÀÕ", "ÑÒÐÀÕÎÂ", "ÇÀÐ", "ÏÏ", "ÄÎÏ", "ÍÈÆÅ", "ÐÓÁ"
				, "ÔÈÇ", "ÏÅ", "ÒÎÒ", "ÁÛÒÜ", "ÎÑÀ", "ÌÀßÒÜ", "ÁÀÍÊÀ", "×ÀÑÒÈÒÜ", "ÄÀÒÜ", "ÑÒÐÀÇÎÂÛÉ"
				, "ÌÎ×Ü", "ÄÅÒÜ", "ÏÎÒ", "ÍÓÆÍÎ", "ÌÀÒ", "ËÅÒ", "ËÅÒÀ", "ÄÅÍÜ", "ÄÅÒÜ", "ÊÎÄÀ", "ÐÀÇÄÅÒÜ"
				, "ÂÍÅ", "ÁÀÇ", "ÑÏÎÐÀ", "ÃÎÄ", "ÂÍÎÂÜ", "ÏÐÀÂÛÉ", "ÏÎÒÎÌ", "ËÅÒÎ", "ÒÅÐÅÒÜ", "ÏÅÍÈÒÜ";
		}

		using namespace ContextSearch;

		SearchAdapterLib::Cache* _cache = SearchAdapterLib::Cache::instance ();
		_cache->init (base);

		Morpho::Def::ICache_var cache = Morpho::Factory::make ();
		cache->load (base, true);

		Manage::Env env;
		env.normalizer = Morpho::Factory::make (cache.in ());

		Manage::IQuery_var query = Manage::IQueryFactory::make (env, _cache->get ());

		_Pair item;
		_Pairs data;
		data.reserve (16 * 1024);

		std::ifstream ifs (m_in.c_str ());

		if (ifs) {
			std::ofstream ofs (m_out.c_str (), std::ios_base::trunc);

			if (ofs) {
				std::string str;

				size_t i = 0;

				while (!ifs.eof ()) {
					std::getline (ifs, str);

					std::cout << str << " : " << i << std::endl;

					try {
						query->clear ();
						query->add (Defs::Request (str), false);

						Core::Aptr <GCL::StrVector> res = query->get_lexemes (false);

						for (GCL::StrVector::const_iterator it = res->begin (); it != res->end (); ++it) {
							std::string sub_str = it->substr (1);

							if (m_is_list) {
								if (std::binary_search (stops.begin (), stops.end (), sub_str)) {
									continue;
								}

								if (it->size () == 2) {
									if (it->at (1) < '0' || it->at (1) > '9') {
										continue;
									}
								}
							}

							if (m_is_nî) {
								if (it->size () == 2) {
									continue;
								}
							}

							if (m_is_np && it->size () > 5) {
								if (it->at (0) & 0x80) {
									continue;
								}
							}

							if (m_is_nd) {
								if (ContextUtility::has_digit (sub_str)) {
									continue;
								}
							}

							_Pairs::iterator f_it = std::find (data.begin (), data.end (), *it);

							if (f_it == data.end ()) {
								data.push_back (item);
								data.back ().count = 1;
								data.back ().str = *it;
							} else {
								++f_it->count;
							}
						}

						++i;
					} catch (Manage::InvalidQuery&) {
						LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
					} catch (...) {
						LOG_UEX ((GDS_CURRENT_FUNCTION));
					}
				}

				std::sort (data.begin (), data.end (), std::greater <_Pair> ());

				if (m_is_list) { 
					for (_Pairs::const_iterator it = data.begin (); it != data.end (); ++it) {
						if (it->str [0] & 0x80) {
							ofs << '#';
						} 
						ofs << it->str.c_str () + 1 << std::endl;
					}
				} else {
					std::copy (data.begin (), data.end (), std::ostream_iterator <_Pair> (ofs, "\n"));
				}

				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, m_out.c_str ()));
			}

			ifs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, m_in.c_str ()));
		}

		std::cout << std::endl;
	}

public:
	std::string m_in;
	std::string m_out;
	std::string m_path;

	bool m_is_nd;
	bool m_is_np;
	bool m_is_nî;
	bool m_is_list;
	bool m_is_lite;
	bool m_top_phrases;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

int main (int argc, char* argv []) {
	Core::AutoInit init;

	ExecuteStatus ret = es_Success;

	try {
		Executor (argc, argv).execute ();
	} catch (...) {
		std::cout << std::endl << "Abnormal canceled.." << std::endl << std::endl;
		ret = es_Error;
	}

	return (int) ret;
}

//-in "C:\in.txt" -out "C:\out.txt" -path "C:\Program Files (x86)\Garant\data2\data"