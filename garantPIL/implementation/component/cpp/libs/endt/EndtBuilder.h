//
// EndtBuilder.h : header file
//

#ifndef __ENDT_BUILDER_H
#define __ENDT_BUILDER_H

#include "stdbase.h"

namespace EndtTools {

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Интерфейс алгоритма генерации данных в формате ENDT

	class IEndtBuilder
		: virtual public ::Core::IObject {
	public:
		virtual void build_all (const std::string& dir) = 0;
		virtual void build (const char* file_name) = 0;
	};

	typedef ::Core::Var <IEndtBuilder> IEndtBuilder_var;
	typedef ::Core::Var <const IEndtBuilder> IEndtBuilder_cvar;

	struct EndtBuilderFactory {
		static IEndtBuilder* make (Base* base);
	};

} // namespace 

#endif // __ENDT_BUILDER_H
