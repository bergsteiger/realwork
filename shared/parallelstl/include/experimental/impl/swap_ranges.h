#pragma once

#ifndef _IMPL_SWAP_RANGES_H_
#define _IMPL_SWAP_RANGES_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// swap_ranges
	//
	template <class _FwdIt, class _FwdIt2, class _IterCat>
	_FwdIt2 _Swap_ranges_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _IterCat)
	{
		_EXP_TRY
			return std::swap_ranges(_First, _Last, _First2);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _FwdIt2, class _IterCat>
	_FwdIt2 _Swap_ranges_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _IterCat _Cat)
	{
		return std::get<1>(*_For_each_n_impl(_Policy, make_composable_iterator(_First, _First2), std::distance(_First, _Last),
			[](typename composable_iterator<_FwdIt, _FwdIt2>::reference _It){
			swap(*std::get<0>(_It), *std::get<1>(_It));
		}, _Cat));
	}

	template <class _FwdIt, class _FwdIt2, class _IterCat>
	_FwdIt2 _Swap_ranges_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Swap_ranges_impl, _Policy, _First, _Last, _First2, _Cat);
	}
} // details

template <class _ExPolicy, class _FwdIt, class _FwdIt2>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt2>::type swap_ranges(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt2>::iterator_category>::value, "Required forward iterator or stronger.");

	details::common_iterator<_FwdIt, _FwdIt2>::iterator_category _Cat;
	return details::_Swap_ranges_impl(_Policy, _First, _Last, _First2, _Cat);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_SWAP_RANGES_H_
