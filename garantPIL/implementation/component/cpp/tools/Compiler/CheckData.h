////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "CheckData.h"

#ifndef __COMPILER__CHECK_DATA_H__
#define __COMPILER__CHECK_DATA_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"

#include "Common.h"
#include "CompileConfig.h"

namespace Compiler {

	class CompileInfo {
		SET_OBJECT_COUNTER (CompileInfo)

	public:
		CompileInfo ();

		virtual ~CompileInfo ();

		void init (const ConfigData& data);

	public:
		const GCL::StrSet& get_sources () const {
			return m_source;
		}

		const StrIntMap& get_belongs () const {
			return m_belongs;
		}

	public:
		GCL::StrSet m_source;

		StrIntMap m_belongs;
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////////

	class Checker {
		SET_OBJECT_COUNTER (Checker)

	public:
		Checker ();

		virtual ~Checker ();

	public:
		void execute (const CompileInfo& data);

	private:
		void check_doc (const char* file_name);
		void check_doc (const char* buffer, size_t size);
	};
}

#endif //__COMPILER__CHECK_DATA_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////
