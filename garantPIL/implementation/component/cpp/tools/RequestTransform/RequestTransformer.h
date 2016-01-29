////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "RequestTransformer.h"

#ifndef __REQUEST_TRANSFORMER_H__
#define __REQUEST_TRANSFORMER_H__

#include "shared/ContextSearch/Manage/Manage.h"

#include "SearchB.h"

namespace RequestTransform {

	using namespace ContextSearch;

	class RequestTransformer {
	public:
		RequestTransformer (const std::string& path);

		virtual ~RequestTransformer ();

	public:
		typedef std::vector <GCL::StrVector> RequestList;

	public:
		void execute (const std::string& in, const std::string& out);

	private:
		// Печать списка запросов
		void out_requests (std::ofstream& ofs, GCL::StrVector& lemmas, const std::string& str);
		// Печать синонимированного запроса
		void out_request (std::ofstream& ofs, GCL::StrVector& lemmas, const Search::SplitRequest& req, size_t& count);
		// Печать всех полученных лемм
		void out_lemmas (std::ofstream& ofs, GCL::StrVector& lemmas);
		// Нормализация
		void normalize (const std::string& word, RequestList& reqs, GCL::StrVector& lemmas);

	private:
		Manage::Env m_env;
		Manage::IQuery_var m_query;

		Core::Aptr <ToolsBase> m_base;
	};

} // namespace RequestTransform

#endif //__REQUEST_TRANSFORMER_H__