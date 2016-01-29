////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "InformersMake.h"

#ifndef __INFORMERS_MAKE_H__
#define __INFORMERS_MAKE_H__

#include "SearchB.h"

namespace InformersMake {

	class InformersMaker {
	public:
		InformersMaker (const std::string& path);

		virtual ~InformersMaker ();

	public:
		void execute (const std::string& in, const std::string& out);

	private:
		Core::Aptr <SearchBase> m_base;
	};

} // namespace InformersMake

#endif //__INFORMERS_MAKE_H__

