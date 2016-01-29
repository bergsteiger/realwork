////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "TypingErrorAnalyzer.h"

#ifndef __TYPING_ERROR_ANALYZER_H__
#define __TYPING_ERROR_ANALYZER_H__

#include "SearchB.h"

namespace TypingErrorAnalyze {

	class TypingErrorAnalyzer {
	public:
		TypingErrorAnalyzer (const std::string& path);

		virtual ~TypingErrorAnalyzer ();

	public:
		void execute (const std::string& out);

	private:
		Core::Aptr <ToolsBase> m_base;
	};

} // namespace TypingErrorAnalyze

#endif //__TYPING_ERROR_ANALYZER_H__
