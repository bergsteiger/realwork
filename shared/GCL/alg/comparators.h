#pragma once

#include <functional>

namespace GCL {

struct PairComparatorByFirstElement {
	template <typename First, typename Second>
	bool operator () (const std::pair<First, Second>& lhs, const std::pair<First, Second>& rhs) {
		return std::less<First> () (lhs.first, rhs.first);
	}
};

}


