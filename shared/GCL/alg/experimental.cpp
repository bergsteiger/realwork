#include "shared/Core/Params/Params.h"

namespace GCL { namespace experimental {

bool use_experimental () {
#if	(defined(_MSC_VER) && _MSC_VER >= 1900)
	return false;
#else
	static bool dont_use = Core::ParamManagerFactory::get ().is_exist ("-DontUseParallelStl");

	return !dont_use;
#endif
}


} }
