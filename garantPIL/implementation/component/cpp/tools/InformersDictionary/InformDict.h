////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "InformDict.h"

#ifndef __INFORM_DICT_H__
#define __INFORM_DICT_H__

#include "shared/ContextSearch/Manage/Manage.h"

#include "SearchB.h"

namespace InformersDictionary {

	using namespace ContextSearch;

	typedef std::map <std::string, GCL::StrVector> DictMap;
	typedef std::map <std::string, std::string> SynsMap;

	struct Properties {
		std::string in;     // путь к файлу с исходными данными
		std::string out;    // путь к файлу с результатом
		std::string req_in; // путь к файлу со списком запросов

		size_t count; // количество выводимых строк

		bool remove_syn_repetition;   // выкидывать синонимичные повторы
		bool remove_syn_repetition_2; // выкидывать синонимичные повторы (альтернативный вывод результата)

		Properties () : remove_syn_repetition (false), remove_syn_repetition_2 (false), count (100000) {
		}
	};

	class InformDictBuilder {
	public:
		InformDictBuilder (const std::string& path);

		virtual ~InformDictBuilder ();

	public:
		void execute (const Properties& properties);

	private:
		void load_reqs_without_repetition (GCL::StrVector& out, const std::string& path);
		void load_reqs_without_repetition_2 (DictMap& out, const std::string& path);

		void load_req_list (const std::string& path);
		void load_inform_dict (const std::string& path);
		void load_psevdo_dict (const std::string& path);

		void out (const std::string& path);
		void out (const std::string& key, std::ofstream& ofs, size_t& count);

		void out_pair (const std::string& path);
		void out_raw_data (const std::string& path);

		void find (const std::string& req, GCL::StrSet& keys);
		void find_all (const std::string& req, GCL::StrSet& keys);
		void find_other (const std::string& req, GCL::StrSet& keys);

		void get_syns (const std::string& req, GCL::StrVector& out);

	private:
		DictMap m_reqs;
		DictMap m_def_map;
		SynsMap m_syn_map;

		size_t m_count;

		Manage::Env m_env;

		Manage::IQuery_var m_query;

		Core::Aptr <ToolsBase> m_base;
	};

} // namespace InformersDictionary

#endif //__INFORM_DICT_H__
