////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "Common.h"

#ifndef __COMPILER__COMMON_H__
#define __COMPILER__COMMON_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"

namespace Compiler {

	typedef std::map <std::string, unsigned> StrIntMap;

	class TextFileParser {
		SET_OBJECT_COUNTER (TextFileParser)

	public:
		TextFileParser ();

		virtual ~TextFileParser ();

	public:
		void parse (const char* name, GCL::StrSet& out);
		void parse_belongs (const char* name, StrIntMap& out);

	private:
		Core::Aptr <char, Core::ArrayDeleteDestructor <char> > m_buffer;
	};
}

#endif //__COMPILER__COMMON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////