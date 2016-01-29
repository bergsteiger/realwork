////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "BaseCreate.h"

#ifndef __COMPILER__BASE_CREATE_H__
#define __COMPILER__BASE_CREATE_H__

#include "shared/Core/sys/std_inc.h"

#include "stdbase.h"

namespace Compiler {

	class BaseCreateError : public ::Core::Exception {
	public:
		const char* what () const throw () {
			return "Base create error";
		}
	private:
		const char* uid () const /*throw ()*/ {
			return 0;
		}
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	class BaseCreate : public YBase {
	public:
		BaseCreate (const char* name, int mode, int key_cpages, int str_cpages, int ndt_cache, FILE* stat_file);

		virtual ~BaseCreate ();

	public:
		void begin_transaction ();
		void end_transaction ();
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	struct BaseFactory {
		static Base* make (const char* name);
	};

} // namespace Compiler

#endif //__COMPILER__COMPILE_CONFIG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////
