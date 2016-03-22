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
		void execute (const std::string& in, const std::string& out);

	private:
		Manage::IQuery_var m_query;

		Core::Aptr <ToolsBase> m_base;
	};

} // namespace RequestTransform

#endif //__REQUEST_TRANSFORMER_H__