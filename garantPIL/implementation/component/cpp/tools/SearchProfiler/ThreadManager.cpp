//
// Watcher.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>

#include "boost/bind.hpp"
#include "boost/lexical_cast.hpp"

#include "garantCore/Search/Facade/Factory.h"
#include "garantCore/Search/impl/Filters_i/Filters.h"
#include "garantCore/Search_f1/Search.h"

#include "garantPIL/implementation/component/cpp/libs/gkdb/src/BaseCache.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/ContextPartsHelper.h"

#include "ThreadManager.h"
#include "Watcher.h"
#include "Config.h"

namespace SearchProfiler {

enum TimeFormat { tf_Detail, tf_Float, tf_Ms };

struct Properties {
	std::string base_path;
	std::string path;
	std::string ext;

	bool is_rt;
	bool is_data;
	bool is_short_list;

	Properties ()
		: is_rt (true)
		, is_data (true) 
		, is_short_list (false)	{
	}

	Properties& operator = (const Properties& copy) {
		base_path = copy.base_path;
		path = copy.path;
		ext = copy.ext;

		is_rt = copy.is_rt;
		is_data = copy.is_data;
		is_short_list = copy.is_short_list;

		return *this;
	}
};

///////////////////////////////////////////////////////////////////////////////////////////////////

class Helper {
public:
	static void out (const std::string& req, const std::string& path, SortedCollection* list) {
		std::ofstream ofs (path.c_str (), std::ios_base::trunc);

		if (list && list->ItemCount) {
			if (ofs) {
				ofs << req << ";" << list->ItemCount << std::endl;

				if (list->Tag () == OT_DOCCOLLECTION) {
					for (long i = 0 ; i < list->ItemCount; ++i) {
						ofs << *((long*) list->GetItem (i)) << std::endl;
					}
				} else if (list->Tag () == OT_REFCOLLECTION) {
					for (long i = 0 ; i < list->ItemCount; ++i) {
						const Ref* item = (const Ref*) list->GetItem (i);
						ofs << item->DocId << '.' << item->Sub << std::endl;
					}
				} else if (list->Tag () == OT_RELECOLLECTION) {
					for (long i = 0 ; i < list->ItemCount; ++i) {
						const RefwRele* item = (const RefwRele*) list->GetItem (i);
						ofs << item->DocId << '.' << item->Word << '.' << item->Rele << std::endl;
					}
				} else if (list->Tag () == OT_RELESUBCOLLECTION) {
					for (long i = 0 ; i < list->ItemCount; ++i) {
						const RefwRele* item = (const RefwRele*) list->GetItem (i);
						ofs << item->DocId << '.' << item->Word << '.' << item->Rele << std::endl;
					}
				} else if (list->Tag () == OT_REFWEIGHTCOLLECTION) {
					for (long i = 0 ; i < list->ItemCount; ++i) {
						const RefwWeight* item = (const RefwWeight*) list->GetItem (i);
						ofs << item->DocId << '.' << item->Sub << '.' << item->Weight << std::endl;
					}
				} else {
					GDS_ASSERT (0);
				}
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
			}
		}

		ofs.close ();
	}
};

///////////////////////////////////////////////////////////////////////////////////////////////////

class RunTimeOut {
public:
	virtual ~RunTimeOut () {
		m_ofs.close ();
	}

public:
	typedef ACE_Singleton <RunTimeOut, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <RunTimeOut, ACE_SYNCH_RECURSIVE_MUTEX>;

public:
	void init (const std::string& path, std::ios_base::openmode mode, TimeFormat format) {
		m_format = format;

		if (m_ofs.is_open ()) {
			m_ofs.close ();
			m_ofs.clear ();
		}

		m_ofs.open (path.c_str (), mode);

		if (!m_ofs) {
			LOG_W (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
			throw std::exception ();
		}
	}

	void out (const std::string& str, const WatchTime& wt) {
		GUARD (m_mutex);

		m_ofs << str << ';';

		if (m_format == tf_Detail) {
			m_ofs << wt.sec << "s " << wt.msec << "ms " << wt.usec << "us";
		} else if (m_format == tf_Float) {
			m_ofs << (double) wt.sec + (double) (wt.msec / 1000.);
		} else if (m_format == tf_Ms) {
			long val = (1000 * wt.sec + wt.msec);
			m_ofs << val;
		}

		m_ofs << std::endl;
	}

private:
	Core::Mutex m_mutex;

	std::ofstream m_ofs;

	TimeFormat m_format;
};

///////////////////////////////////////////////////////////////////////////////////////////////////

class SrcReader {
public:
	virtual ~SrcReader () {
		m_ifs.close ();
	}

public:
	typedef ACE_Singleton <SrcReader, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SrcReader, ACE_SYNCH_RECURSIVE_MUTEX>;

public:
	void init (const std::string& path) {
		m_pos = 0;

		if (m_ifs.is_open ()) {
			m_ifs.close ();
			m_ifs.clear ();
		}

		m_ifs.open (path.c_str ());

		if (!m_ifs) {
			LOG_W (("%s: can't open %s", GDS_CURRENT_FUNCTION, path.c_str ()));
			throw std::exception ();
		}
	}

	bool next (std::string& str, size_t& pos) {
		GUARD (m_mutex);

		if (m_ifs.eof ()) {
			return false;
		}

		std::getline (m_ifs, str);
		++m_pos;
		pos = m_pos;
		return true;
	}

private:
	Core::Mutex m_mutex;

	std::ifstream m_ifs;

	size_t m_pos;
};

///////////////////////////////////////////////////////////////////////////////////////////////////

class Searcher {
public:
	Searcher ();

	void execute (const std::string& str, size_t pos);
	void init (const Properties& prop);

private:
	Properties m_prop;
	IWatcher_var m_watcher;
};

Searcher::Searcher () { 
	m_watcher = WatcherFactory::make ();
}

void Searcher::execute (const std::string& str, size_t pos) {
	if (str.empty () == false && str [0] != ';') {
		Core::Aptr <Search::SearchResult> res;

		CachedBaseRO base (m_prop.base_path.c_str ());

		m_watcher->start ();

		if (m_prop.ext == ctx_ext) {
			Search::SearchProp search_prop;

			if (m_prop.is_short_list) {
				search_prop.max_res_size = BaseCache::instance ()->get_short_list_size (&base);
			}

			Search::BooleanFilter filter;

			if (ContextPartsHelper::is_parts ()) {
				ContextPartsHelper::get_context_parts_names (search_prop.ctx_src, false);
			} else {
				const DocCollection& data = AllDocsCache::instance ()->get_med_docs (&base);
				filter << Search::Filter (const_cast <DocCollection*> (&data), Search::so_NOT);

				const DocCollection& edis = AllDocsCache::instance ()->get_editions (&base);
				filter << Search::Filter (const_cast <DocCollection*> (&edis), Search::so_NOT);

				search_prop.filter = filter.in ();
			}

			Search::IQuery_var query = Search::Factory::make_query (Search::BODY_TYPE, str);
			Search::ISearcher_var searcher = Search::Factory::make_searcher (&base);
			res = searcher->execute (query.in (), search_prop);
		} else {
			res = Search::execute (&base, str, Search::Segments (), 0, m_prop.is_short_list, false);
		}

		m_watcher->finish ();

		if (m_prop.is_rt) {
			RunTimeOut::Singleton::instance ()->out (str, m_watcher->get_data ());
		}

		if (m_prop.is_data) {
			Helper::out (str, m_prop.path + boost::lexical_cast <std::string> (pos) + m_prop.ext, res->list.in ());
		}
	}
}

void Searcher::init (const Properties& prop) {
	m_prop = prop;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

int thr_func (void* arg) {
	Searcher* searcher = reinterpret_cast <Searcher*> (arg);
	SrcReader* reader = SrcReader::Singleton::instance ();

	std::string str;
	size_t pos;

	while (reader->next (str, pos)) {
		searcher->execute (str, pos);
	}

	return 0;
}

void ThreadManager::execute (
	const std::string& root, const std::string& rt_file, const std::string& path, const std::string& ext
) {
	::mkdir (path.c_str ());

	ConfigManager* config = DConfigManager::instance ();

	SrcReader::Singleton::instance ()->init (root + rt_file);

	{
		std::string tf = config->get ("format");

		TimeFormat format = tf_Detail;

		if (tf == "float") {
			format = tf_Float;
		} else if (tf == "ms") {
			format = tf_Ms;
		} 

		std::string rt_path = path + rt_file.substr (0, rt_file.rfind (".")) + ".rt";

		if (config->get_int ("rewrite_rt")) {
			RunTimeOut::Singleton::instance ()->init (rt_path, std::ios_base::trunc, format);
		} else {
			RunTimeOut::Singleton::instance ()->init (rt_path, std::ios_base::app, format);
		}
	}

	Properties prop;
	prop.path = path;
	prop.ext = ext;
	prop.base_path = config->get ("base");
	prop.is_rt = (config->get_int ("run_time") == 1);
	prop.is_data = (config->get_int ("out_data") == 1);
	prop.is_short_list = (config->get_int ("short_list") == 1);

	size_t count = config->get_int ("thr_count");

	if (count == 0) {
		count = 1;
	}

	std::vector <Searcher> searchers (count);
	std::for_each (searchers.begin (), searchers.end (), boost::bind (&Searcher::init, _1, prop));

	ACE_Thread_Manager* manager = ACE_Thread_Manager::instance ();

	std::vector <ACE_thread_t> tids (count);

	for (size_t i = 0; i < count; ++i) {
		if (manager->spawn ((ACE_THR_FUNC) thr_func, &searchers [i], THR_NEW_LWP | THR_JOINABLE, &tids [i]) < 0) {
			throw std::exception ();
		}
	}

	std::for_each (tids.begin (), tids.end ()
		, boost::bind (&ACE_Thread_Manager::join, manager, _1, (ACE_THR_FUNC_RETURN*) 0)
	);
}

}

