////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/experimental.h"
//
// параллельный stl
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __SHARED_GCL_ALG_EXPERIMENTAL_H__
#define __SHARED_GCL_ALG_EXPERIMENTAL_H__

#include <experimental/algorithm>

namespace GCL { namespace experimental {

bool use_experimental ();

template<class It, class Functor>
void sort (It begin, It end, Functor functor) {
	static bool experimental = use_experimental ();
	if (experimental) {
		std::experimental::parallel::sort (std::experimental::parallel::par, begin, end, functor);
	} else {
		std::experimental::parallel::sort (std::experimental::parallel::seq, begin, end, functor);
	}
}

template<class Container, class Functor>
void sort (Container& container, Functor functor) {
	GCL::experimental::sort (container.begin (), container.end (), functor);
}

} }

#endif
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
