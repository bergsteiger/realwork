//
// InformDict.cpp : implementation file
//

#include "ace/ACE.h"

#include "boost/bind.hpp"
#include "boost/lambda/lambda.hpp"
#include "boost/algorithm/string/join.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "shared/GCL/str/str_conv.h"
#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Common/ContextUtility.h"

#include "garantCore/SearchAdapterLib/Cache/Cache.h"

#include <fstream>

#include "InformDict.h"
#include "DBComm.h"

namespace InformersDictionary {

class ExceededLimit : public std::exception {
public:
	virtual const char* what () {
		return "ExceededLimit";
	}
};

// ѕредикат сравнени€ строк по их размеру
struct CompareBySize : public std::binary_function<std::string, std::string, bool> {
	bool operator () (const std::string& first_param_, const std::string& second_param_) const {
		size_t first_count = ContextUtility::get_words_count (first_param_);
		size_t second_count = ContextUtility::get_words_count (second_param_);

		if (first_count == second_count) {
			return first_param_.size () > second_param_.size ();
		} else {
			return first_count > second_count;
		}
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////////

class Helper {
public:
	static void validate (std::string& str) {
		boost::trim_if (str, boost::is_space ());
		GCL::to_upper (str);
	}

	static void norma_trim (std::string& str) {
		str = str.substr (1);
	}

	static void add (SynsMap& map, const std::string& key, const std::string& data) {
		map [key] = data;
	}

	static void out (const DictMap& map, const std::string& key, const std::string& first, std::ofstream& ofs) {
		DictMap::const_iterator it = map.find (key);

		if (it != map.end () && first != it->second.at (0)) {
			ofs << first << "\t" << it->second.at (0) << std::endl;
		}
	}

	static void out_ (const DictMap& map, const char* delim, const char* delim2, std::ofstream& ofs) {
		for (DictMap::const_iterator it = map.begin (); it != map.end (); ++it) {
			ofs << it->first << delim;
			std::copy (it->second.begin (), it->second.end (), std::ostream_iterator <std::string> (ofs, delim2));
			ofs << std::endl;
		}
	}

	static void out_ (const SynsMap& map, const char* delim, std::ofstream& ofs) {
		for (SynsMap::const_iterator it = map.begin (); it != map.end (); ++it) {
			ofs << it->first << delim << it->second << std::endl;
		}
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////////

InformDictBuilder::InformDictBuilder (const std::string& path) : m_count (0) {
	m_base = new ToolsBase (path);

	DBCore::IBase_var _base = DBCore::DBFactory::make (m_base.in ());

	SearchAdapterLib::Cache::instance ()->init (_base.in ());

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (_base.in ());

	m_env.normalizer = Morpho::Factory::make (cache.in ());
	m_query = Manage::IQueryFactory::make (m_env, SearchAdapterLib::Cache::instance ()->get ());
}

InformDictBuilder::~InformDictBuilder () {
}

void InformDictBuilder::execute (const Properties& properties) {
	if (properties.remove_syn_repetition) {
		// ¬ыкидываем из исходного списка запросов синонимичные повторы
		//
		GCL::StrVector out;
		this->load_reqs_without_repetition (out, properties.req_in);

		std::ofstream ofs (properties.out.c_str (), std::ios_base::trunc);

		if (ofs) {
			std::copy (out.begin (), out.end (), std::ostream_iterator <std::string> (ofs, "\n"));
			ofs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.out.c_str ()));
		}
	} else if (properties.remove_syn_repetition_2) {
		// ¬ыкидываем из исходного списка запросов синонимичные повторы (альтернативный вариант)
		//
		DictMap out;
		this->load_reqs_without_repetition_2 (out, properties.req_in);

		std::ofstream ofs (properties.out.c_str (), std::ios_base::trunc);

		if (ofs) {
			Helper::out_ (out, ":", ";", ofs);
			ofs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.out.c_str ()));
		}
	} else {
		if (properties.req_in.empty () == false) {
			this->load_req_list (properties.req_in); // загрузка списка запросов/пон€тий
		}

		if (properties.in.empty ()) {
			// ѕостроение пар св€занных пон€тий
			//
			this->load_psevdo_dict (properties.req_in);  // загрузка псевдо-словар€
			this->out_pair (properties.out);
		} else {
			// ‘ормирование панели информеров
			//
			this->load_inform_dict (properties.in);  // загрузка словар€ информеров

			if (properties.req_in.empty ()) {
				this->out_raw_data (properties.out);
			} else if (properties.count) {
				m_count = properties.count;
				this->out (properties.out);
			} else {
				ACE_OS::unlink (properties.out.c_str ());
			}
		}
	}
}

void InformDictBuilder::load_reqs_without_repetition (GCL::StrVector& out, const std::string& path) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	std::ifstream ifs (path.c_str ());

	if (ifs) {
		SynsMap map;
		GCL::StrSet stop_reqs;

		out.reserve (1024);

		std::string str;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false && str [0] != ';') {
				GCL::StrVector tmp;
				this->get_syns (str, tmp);

				GCL::StrSet data (tmp.begin (), tmp.end ());

				for (GCL::StrSet::const_iterator it = data.begin (); it != data.end (); ++it) {
					if (map.find (*it) == map.end ()) {
						map.insert (SynsMap::value_type (*it, str));
					} else {
						stop_reqs.insert (str);
					}
				}

				out.push_back (str);
			}
		}

		if (out.empty () == false && stop_reqs.empty () == false) {
			for (GCL::StrSet::const_iterator it = stop_reqs.begin (); it != stop_reqs.end (); ++it) {
				GCL::StrVector::iterator f_it = std::find (out.begin (), out.end (), *it);
				if (f_it != out.end ()) {
					out.erase (f_it);
				}
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void InformDictBuilder::load_reqs_without_repetition_2 (DictMap& out, const std::string& path) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	std::ifstream ifs (path.c_str ());

	if (ifs) {
		SynsMap map;

		std::string str;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false && str [0] != ';') {
				GCL::StrVector tmp;
				this->get_syns (str, tmp);

				GCL::StrSet data (tmp.begin (), tmp.end ());

				for (GCL::StrSet::const_iterator it = data.begin (); it != data.end (); ++it) {
					SynsMap::const_iterator f_it = map.find (*it);

					if (f_it == map.end ()) {
						map.insert (SynsMap::value_type (*it, str));
					} else {
						DictMap::iterator it_ = out.insert (DictMap::value_type (f_it->second, GCL::StrVector ())).first;

						if (std::find (it_->second.begin (), it_->second.end (), str) == it_->second.end ()) {
							it_->second.push_back (str);
						}

						break;
					}
				}
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void InformDictBuilder::load_req_list (const std::string& path) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	std::ifstream ifs (path.c_str ());

	if (ifs) {
		std::string str;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false && str [0] != ';') {
				DictMap::iterator it = m_reqs.insert (DictMap::value_type (str, GCL::StrVector ())).first;
				this->get_syns (str, it->second);
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void InformDictBuilder::load_inform_dict (const std::string& path) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	std::ifstream ifs (path.c_str ());

	if (ifs) {
		std::string str;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false && str [0] != ';') {
				GCL::StrVector data, keys;

				// –азбиваем на отдельные запросы
				boost::split (data, str, boost::is_any_of (":;"));

				GDS_ASSERT (data.size () > 1);

				// ¬алидируем контекст
				std::for_each (data.begin (), data.end (), boost::bind (&Helper::validate, _1));

				this->get_syns (data [0], keys);

				data.erase (
					std::remove_if (data.begin (), data.end (), boost::bind (&std::string::empty, _1))
					, data.end ()
				);

				// ћапа с исходными данными
				m_def_map [data [0]].assign (data.begin () + 1, data.end ());

				// ћапа в которой ключ - это синонимированный и нормализованный запрос, данные - ключ из первой мапы
				std::for_each (keys.begin (), keys.end ()
					, boost::bind (&Helper::add, boost::ref (m_syn_map), _1, data [0])
				);
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void InformDictBuilder::load_psevdo_dict (const std::string& path) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	for (DictMap::const_iterator it = m_reqs.begin (); it != m_reqs.end (); ++it) {
		GCL::StrVector keys;
		this->get_syns (it->first, keys);

		std::string key = it->first;
		GCL::to_upper (key);

		// ћапа с исходными данными
		m_def_map [key].resize (1, it->first);

		// ћапа в которой ключ - это синонимированный и нормализованный запрос, данные - ключ из первой мапы
		std::for_each (keys.begin (), keys.end (), boost::bind (&Helper::add, boost::ref (m_syn_map), _1, key));
	}
}

void InformDictBuilder::out (const std::string& key, std::ofstream& ofs, size_t& count) {
		DictMap::const_iterator it = m_def_map.find (key);

		if (it != m_def_map.end ()) {
			std::string str = key;
			GCL::to_lower (str);

			ofs << str << "\n\t";

			++count;

			GCL::StrVector::const_iterator _it = it->second.begin ();

			for (; _it != it->second.end (); ++_it, ++count) {
				if (count >= m_count) {
					throw ExceededLimit ();
				}

				str = *_it;
				GCL::to_lower (str);
				ofs << str << "\n\t";
			}

			ofs << std::endl;
		}
	}

void InformDictBuilder::out (const std::string& path) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	std::ofstream ofs (path.c_str (), std::ios_base::trunc);

	if (ofs) {
		for (DictMap::const_iterator it = m_reqs.begin (); it != m_reqs.end (); ++it) {
			GCL::StrSet keys;

			std::for_each (it->second.begin (), it->second.end ()
				, boost::bind (&InformDictBuilder::find, this, _1, boost::ref (keys))
			);

			if (keys.empty () == false) {
				ofs << it->first << ":" << std::endl << std::endl;

				if (m_count == 1) {
					break;
				}

				size_t count = 1;

				GCL::StrVector _keys (keys.begin (), keys.end ());

				// сортируем запросы в зависимости от их длин (по убыванию)
				std::sort (_keys.begin (), _keys.end (), CompareBySize ());

				try {
					// вывод результата
					std::for_each (_keys.begin (), _keys.end ()
						, boost::bind (&InformDictBuilder::out, this, _1
						, boost::ref (ofs)
						, boost::ref (count))
					);
				} catch (ExceededLimit&) {
				}
			}
		}

		ofs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void InformDictBuilder::out_raw_data (const std::string& path) {
	std::ofstream ofs (path.c_str (), std::ios_base::trunc);

	if (ofs) {
		Helper::out_ (m_syn_map, ":", ofs);
		ofs << "--*--\n";
		Helper::out_ (m_def_map, ":", ";", ofs);
		ofs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void InformDictBuilder::out_pair (const std::string& path) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	std::ofstream ofs (path.c_str (), std::ios_base::trunc);

	if (ofs) {
		for (DictMap::const_iterator it = m_reqs.begin (); it != m_reqs.end (); ++it) {
			GCL::StrSet keys;

			std::for_each (it->second.begin (), it->second.end ()
				, boost::bind (&InformDictBuilder::find_all, this, _1, boost::ref (keys))
			);

			if (keys.empty () == false) {
				GCL::StrVector _keys (keys.begin (), keys.end ());

				// сортируем запросы в зависимости от их длин (по убыванию)
				std::sort (_keys.begin (), _keys.end (), CompareBySize ());

				// выводим результат
				std::for_each (_keys.begin (), _keys.end ()
					, boost::bind (&Helper::out, m_def_map, _1, it->first, boost::ref (ofs))
				);
			}
		}

		ofs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
	}
}

void InformDictBuilder::find (const std::string& req, GCL::StrSet& keys) {
	SynsMap::const_iterator it = m_syn_map.find (req);

	if (it != m_syn_map.end ()) {
		keys.insert (it->second);
	} else {
		this->find_other (req, keys);
	}
}

void InformDictBuilder::find_all (const std::string& req, GCL::StrSet& keys) {
	SynsMap::const_iterator it = m_syn_map.find (req);

	if (it != m_syn_map.end ()) {
		keys.insert (it->second);
	} 

	this->find_other (req, keys);
}

void InformDictBuilder::find_other (const std::string& req, GCL::StrSet& keys) {
	GCL::StrVector data;

	boost::split (data, req, boost::is_space ());

	size_t pos = 0;

	for (size_t i = 0; i < data.size () - 1; ++i) {
		for (size_t j = 0; j < data.size () - i; ++j) {
			std::string part;

			for (size_t k = 0; k < data.size (); ++k) {
				if (j + pos == k && pos <= i) {
					++pos;
				} else {
					if (part.empty () == false) {
						part += ' ';
					}
					part += data [k];
				}
			}

			pos = 0;

			SynsMap::const_iterator it = m_syn_map.find (part);

			if (it != m_syn_map.end ()) {
				keys.insert (it->second);
			}
		}
	}
}

void InformDictBuilder::get_syns (const std::string& req, GCL::StrVector& out) {
	Core::Aptr <GCL::StrVector> res = m_env.normalizer->execute_for_phrase (req);

	m_query->clear ();

	for (GCL::StrVector::const_iterator it = res->begin (); it != res->end (); ++it) {
		m_query->add (Defs::Request (*it), false);
	}

	Core::Aptr <Search::SplitRequests> requests = m_query->get_data ();

	out.resize (requests->size ());

	for (size_t i = 0; i < out.size (); ++i) {
		out [i] = boost::join (requests->at (i).context, " ");
	}
}

}
