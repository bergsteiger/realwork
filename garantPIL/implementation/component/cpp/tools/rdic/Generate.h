////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "Generate.h"

#ifndef __RDIC__GENERATE_H__
#define __RDIC__GENERATE_H__

#include "shared/Adapters/mlmaru/MLMARUAdapter.h"
#include "shared/GCL/data/std_defs.h"

namespace DictGenerator {

	class Generator {
	public:
		Generator (const std::string& src, const std::string& dst, bool is_instrumentalis);

		virtual ~Generator ();

		void execute ();

		void execute (const char* name);

	private:
		void modify_str (std::string& str);

		short insert_forms (unsigned char form, unsigned long lid, GCL::StrSet& forms);

	private:
		bool m_is_instrumentalis;

		std::string m_src;
		std::string m_dst;

		Core::Aptr <char, Core::ArrayDeleteDestructor <char> > m_buf;

		Adapters::MLMA32RUAdapter* m_adapter;
	};

} // namespace DictGenerator

#endif //__RDIC__GENERATE_H__