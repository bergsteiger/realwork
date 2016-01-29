#pragma once

#ifndef _IMPL_MOVE_H_
#define _IMPL_MOVE_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// move
	//
	template <class _InIt, class _OutIt, class _IterCat>
	_OutIt _Move_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _IterCat)
	{
		_EXP_TRY
			return std::move(_First, _Last, _Dest);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _OutIt, class _IterCat>
	_OutIt _Move_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _IterCat _Cat)
	{
		return std::get<1>(*_For_each_n_impl(_Policy, make_composable_iterator(_First, _Dest), std::distance(_First, _Last),
			[](typename composable_iterator<_InIt, _OutIt>::reference _It){
			*std::get<1>(_It) = std::move(*std::get<0>(_It));
		}, _Cat));
	}

	template <class _ExPolicy, class _InIt, class _OutIt>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Move_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, std::input_iterator_tag _Cat)
	{
		return _Move_impl(seq, _First, _Last, _Dest, _Cat);
	}

	template <class _InIt, class _OutIt, class _IterCat>
	inline _OutIt _Move_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Move_impl, _Policy, _First, _Last, _Dest, _Cat);
	}
} //details

template <class _ExPolicy, class _InIt, class _OutIt>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type move(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Move_impl(_Policy, _First, _Last, _Dest, _Cat);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_MOVE_H_
