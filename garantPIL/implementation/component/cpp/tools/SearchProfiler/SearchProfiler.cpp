//
// SearchProfiler.cpp : implementation file
//

#include "ace/ACE.h"
#include "ace/Dirent.h"
#include "ace/Dirent_Selector.h"

#include <direct.h>
#include <fstream>

#include "boost/lexical_cast.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "garantCore/Search/Cache/Cache.h"
#include "garantCore/Search/Facade/Helper.h"

#include "garantPIL/implementation/component/cpp/tools/CSAdapter/AdapterLoader.h"

#include "DBComm.h"
#include "Config.h"
#include "SearchProfiler.h"
#include "ThreadManager.h"

namespace SearchProfiler {

struct ResultSelector {
	static int selector (const dirent* d) {
		if (!d->d_name) {
			return false;
		}

		size_t size = ACE_OS::strlen (d->d_name);

		if (size < 5) {
			return false;
		}

		const char* ext_ = d->d_name + size - 4;
		return (ctx_ext == ext_ || oth_ext == ext_);
	}
};

class DirObj {
public:
	DirObj (const std::string& path, bool is_result) : m_path (path), m_pos (0) {
		if (is_result) {
			m_ds.open (path.c_str (), ResultSelector::selector);
		} else {
			m_ds.open (path.c_str ());
		}
	}

	~DirObj () {
		m_ds.close ();
	}
public:
	std::string get_next () {
		std::string ret;

		if (m_pos < m_ds.length ()) {
			ret = m_path + m_ds [m_pos]->d_name;
			++m_pos;
		} 

		return ret;
	}

	int size () {
		return m_ds.length ();
	}

	void clear () {
		for (int i = 0; i < m_ds.length (); ++i) {
			std::string full_name = m_path + std::string (m_ds [i]->d_name);
			if (full_name.size () > 4) {
				ACE_OS::unlink (full_name.c_str ());
			}
		}
	}
private:
	int m_pos;
	std::string m_path;
	ACE_Dirent_Selector m_ds;
};

//////////////////////////////////////////////////////////////////////////////////////////

Profiler::Profiler (const std::string& ini_file, bool is_etalon) : m_is_etalon (is_etalon) {
	ConfigManager* config = DConfigManager::instance ();
	config->init (ini_file, "Common");

	std::string path = config->get ("base");

	m_root = config->get ("root");

	if (*(m_root.rbegin ()) != '\\') {
		m_root += '\\';
	}

	config->init (ini_file, "MemCache");

	DBCore::MemCacheSettings settings;
	settings.max_size = config->get_int ("max_size");

	if (settings.max_size > 0) {
		settings.for_list = true;
		settings.type = DBCore::lt_Refs;

		std::string type_str = config->get ("type");

		if (type_str == "all") {
			settings.type = DBCore::lt_All;
		} else if (type_str == "refs") { 
			settings.type = DBCore::lt_Refs;
		} else if (type_str == "data") { 
			settings.type = DBCore::lt_Data;
		} else {
			GDS_ASSERT (0);
		}

		size_t thr_count = config->get_int ("thr_count");

		if (thr_count) {
			settings.pool = make_base_pool (4, path);
		} else {
			settings.pool = make_base_pool (thr_count, path);
		}

		Search::Helper::load_memcache (settings);
	}

	config->init (ini_file, "Common");
}

Profiler::~Profiler () {
}

void Profiler::execute () {
	SearchAdapter::instance ()->init ();  // инициализация CSAdapter

	ConfigManager* config = DConfigManager::instance ();

	std::string path = config->get ("base");

	Core::Aptr <CachedBaseRO> base = new CachedBaseRO (path.c_str ());
	GDS_ASSERT (base->IsOk () && base->check_version ());

	// предварительно прогружаем кэши

	DBCore::IBase_var _base = DBCore::DBFactory::make (base.in ());
	{
		Core::GDS::StopWatch sw ("SortAttrCache");
		SortAttrCache::instance ()->load (base.in ());
	} {
		Core::GDS::StopWatch sw ("MorphoCache");
		Morpho::load_cache (_base.in ());
	} {
		Core::GDS::StopWatch sw ("SearchCache");
		SearchAdapter::instance ()->load_cache (_base.in ());
	} {
		Core::GDS::StopWatch sw ("LoadEdis");
		AllDocsCache::instance ()->get_editions (base.in ());
	} {
		Core::GDS::StopWatch sw ("LoadInformers");
		Core::Aptr <DBCore::RelTuneData> tmp = Search::Cache::instance ()->get_informers (base.in (), "fake");
	}

	std::string work_path = m_root + config->get ((m_is_etalon) ? "etalon_folder" : "out_folder");

	if (m_is_etalon) {
		DirObj (work_path + "\\Contexts\\", false).clear ();
		DirObj (work_path + "\\Other\\", false).clear ();
	}

	::mkdir (work_path.c_str ());

	if (config->get_int ("out_data") || config->get_int ("run_time")) {
		ThreadManager::Singleton::instance ()->execute (
			m_root, config->get ("contexts_file"), work_path + "\\Contexts\\", ctx_ext
		);

		ThreadManager::Singleton::instance ()->execute (
			m_root, config->get ("other_file"), work_path + "\\Other\\", oth_ext
		);
	}

	if (m_is_etalon == false && config->get_int ("check_diff")) {
		std::string out = m_root + "\\result.dif";
		std::ofstream ofs (out.c_str (), std::ios_base::trunc);

		this->make_diff_file ("\\Contexts\\", ofs);
		this->make_diff_file ("\\Other\\", ofs);

		ofs.close ();
	}
}

bool diff (const std::string& path1, const std::string& path2, std::ofstream& ofs) {
	bool ret = true;

	std::ifstream ifs1 (path1.c_str ());
	std::ifstream ifs2 (path2.c_str ());

	if (ifs1 && ifs2) {
		std::string str1, str2;

		std::getline (ifs1, str1); // заголовок
		std::getline (ifs2, str2); // заголовок

		if (str1 != str2) {
			ofs << "Не совпадают заголовки: " << str1 << ", " << str2 << std::endl
				<< "Файлы: " << path1 << ", " << path2 << std::endl << std::endl;
			ret = false;
		} else {
			size_t pos = str1.rfind (";");

			if (pos != std::string::npos) {
				size_t _sz  = boost::lexical_cast <size_t> (str1.substr (pos + 1));

				for (size_t i = 0; i < _sz; ++i) {
					std::getline (ifs1, str1);
					std::getline (ifs2, str2);

					if (str1 != str2) {
						ofs << "Несовпадение в строке " << i + 2 << std::endl
							<< "Файлы: " << path1 << ", " << path2 << std::endl << std::endl;
						ret = false;
						break;
					}
				}
			} else {
				ofs << "Отсутствует количество найденных, в файле " << path1 << std::endl << std::endl;
			}
		}

		ifs1.close ();
		ifs2.close ();
	} else if (!ifs1) {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path1.c_str ()));
		ofs << "can't open " << path1 << std::endl << std::endl;
		ret = false;
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path2.c_str ()));
		ofs << "can't open " << path2 << std::endl << std::endl;
		ret = false;
	}

	return ret;
}

void Profiler::make_diff_file (const std::string& folder, std::ofstream& ofs) {
	ConfigManager* config = DConfigManager::instance ();

	DirObj obj1 (m_root + config->get ("etalon_folder") + folder, true);
	DirObj obj2 (m_root + config->get ("out_folder") + folder, true);

	if (obj1.size () == obj2.size ()) {
		for (int i = 0; i < obj1.size (); ++i) {
			diff (obj1.get_next (), obj2.get_next (), ofs);
		}
	} else {
		ofs << "Не совпадает количество файлов\n";
	}
}

}
