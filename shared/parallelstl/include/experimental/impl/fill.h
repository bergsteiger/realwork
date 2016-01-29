#pragma once

#ifndef _IMPL_FILL_H_
#define _IMPL_FILL_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// fill_n
	//
	template <class _OutIt, class _Diff, class _Ty, class _IterCat>
	inline _OutIt _Fill_n_impl(const sequential_execution_policy&, _OutIt _First, _Diff _Count, const _Ty& _Val, _IterCat)
	{
		_EXP_TRY
			return std::fill_n(_First, _Count, _Val);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _OutIt, class _Diff, class _Ty, class _IterCat>
	inline _OutIt _Fill_n_impl(const _ExPolicy& _Policy, _OutIt _First, _Diff _Count, const _Ty& _Val, _IterCat _Cat)
	{
		return _For_each_n_impl(_Policy, _First, _Count, [&_Val](typename std::iterator_traits<_OutIt>::reference _El){
			_El = _Val;
		}, _Cat);
	}

	template <class _ExPolicy, class _OutIt, class _Diff, class _Ty>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Fill_n_impl(const _ExPolicy&, _OutIt _First, _Diff _Count, const _Ty& _Val, std::output_iterator_tag _Cat)
	{
		return _Fill_n_impl(seq, _First, _Count, _Val, _Cat);
	}

	template <class _OutIt, class _Diff, class _Ty, class _IterCat>
	inline _OutIt _Fill_n_impl(const execution_policy& _Policy, _OutIt _First, _Diff _Count, const _Ty& _Val, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Fill_n_impl, _Policy, _First, _Count, _Val, _Cat);
	}

	//
	// fill
	//
	template <class _FwdIt, class _Ty, class _IterCat>
	inline void _Fill_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, const _Ty& _Val, _IterCat)
	{
		_EXP_TRY
			std::fill(_First, _Last, _Val);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Ty, class _IterCat>
	inline void _Fill_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Val, _IterCat _Cat)
	{
		_Fill_n_impl(_Policy, _First, std::distance(_First, _Last), _Val, _Cat);
	}

	template <class _ExPolicy, class _FwdIt, class _Ty>
	inline typename _enable_if_parallel<_ExPolicy, void>::type _Fill_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, const _Ty& _Val, std::input_iterator_tag _Cat)
	{
		_Fill_impl(seq, _First, _Last, _Val, _Cat);
	}

	template <class _FwdIt, class _Ty, class _IterCat>
	inline void _Fill_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Val, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Fill_impl, _Policy, _First, _Last, _Val, _Cat);
	}
} // details

template <class _ExPolicy, class _OutIt, class _Diff, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type fill_n(_ExPolicy&& _Policy, _OutIt _First, _Diff _Count, const _Ty& _Val)
{
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	return details::_Fill_n_impl(_Policy, _First, _Count, _Val, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, void>::type fill(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Val)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	details::_Fill_impl(_Policy, _First, _Last, _Val, std::_Iter_cat(_First));
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_FILL_H_
