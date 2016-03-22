////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "SynMake.h"

#ifndef __SYN_MAKE_H__
#define __SYN_MAKE_H__

#include "SearchB.h"

namespace SynMake {

	class SynMaker {
	public:
		SynMaker (const std::string& path);

	public:
		void execute (const std::string& in, const std::string& out);
		void execute (const std::string& in, const std::string& out, const std::string& stop_path, bool is_hard);

	private:
		Core::Aptr <ToolsBase> m_base;
	};

} // namespace SynMake

#endif //__SYN_MAKE_H__

