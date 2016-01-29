////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "RequestRateAnalyzer.h"

#ifndef __REQUEST_RATE_ANALYZER_H__
#define __REQUEST_RATE_ANALYZER_H__

#include "shared/ContextSearch/Manage/Manage.h"
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/AdapterLoader.h"

#include "SearchB.h"

namespace RequestRateAnalyze {

	using namespace ContextSearch;

	struct Properties {
		std::string in;   // путь к файлу с исходными данными
		std::string out;  // путь к файлу с результатом

		Defs::RelevancyType rel_value;

		Properties () : rel_value (Relevancy::BASE_FACTOR + 3) {
		}
	};

	//////////////////////////////////////////////////////////////////////////////////////////////

	class RequestRateAnalyzer {
	public:
		RequestRateAnalyzer (const std::string& path);

		virtual ~RequestRateAnalyzer ();

	public:
		void execute (const Properties& properties);

	private:
		void convert_to_string (const Search::SplitRequest& req, std::string& out);

		size_t get_rate (const std::string& req_str);

	private:
		Core::Aptr <ToolsBase> m_base;
		Core::Aptr <ContextSearch::Defs::SearchInfo> m_info;

		Manage::Env m_env;
		Manage::IQuery_var m_query;

		SearchAdapterLib::Adapter::ISearcher_var m_searcher;

		Defs::RelevancyType m_max_value;
	};

} // namespace RequestRateAnalyze

#endif //__REQUEST_RATE_ANALYZER_H__
