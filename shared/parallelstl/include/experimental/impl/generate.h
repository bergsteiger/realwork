#pragma once

#ifndef _IMPL_GENERATE_H_
#define _IMPL_GENERATE_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// generate_n
	//
	template <class _OutIt, class _Diff, class _Fn, class _IterCat>
	inline _OutIt _Generate_n_impl(const sequential_execution_policy&, _OutIt _First, _Diff _Count, _Fn _Func, _IterCat)
	{
		_EXP_TRY
			return std::generate_n(_First, _Count, _Func);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _OutIt, class _Diff, class _Fn, class _IterCat>
	inline _OutIt _Generate_n_impl(const _ExPolicy& _Policy, _OutIt _First, _Diff _Count, _Fn _Func, _IterCat _Cat)
	{
		return _For_each_n_impl(_Policy, _First, _Count, [_Func](typename std::iterator_traits<_OutIt>::reference _El){
			_El = _Func();
		}, _Cat);
	}

	template <class _ExPolicy, class _OutIt, class _Diff, class _Fn>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Generate_n_impl(const _ExPolicy&, _OutIt _First, _Diff _Count, _Fn _Func, std::output_iterator_tag _Cat)
	{
		return _Generate_n_impl(seq, _First, _Count, _Func, _Cat);
	}

	template <class _OutIt, class _Diff, class _Fn, class _IterCat>
	inline _OutIt _Generate_n_impl(const execution_policy& _Policy, _OutIt _First, _Diff _Count, _Fn _Func, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Generate_n_impl, _Policy, _First, _Count, _Func, _Cat);
	}

	//
	//  generate
	//
	template <class _FwdIt, class _Fn, class _IterCat>
	inline void _Generate_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Fn _Func, _IterCat)
	{
		_EXP_TRY
			std::generate(_First, _Last, _Func);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Fn, class _IterCat>
	inline void _Generate_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, _Fn _Func, _IterCat _Cat)
	{
		_Generate_n_impl(_Policy, _First, std::distance(_First, _Last), _Func, _Cat);
	}

	template <class _ExPolicy, class _FwdIt, class _Fn, class _IterCat>
	inline void _Generate_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, _Fn _Func, std::input_iterator_tag _Cat)
	{
		_Generate_impl(seq, _First, _Last, _Func, _Cat);
	}

	template <class _FwdIt, class _Fn, class _IterCat>
	inline void _Generate_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Fn _Func, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Generate_impl, _Policy, _First, _Last, _Func, _Cat);
	}
} // details

template <class _ExPolicy, class _FwdIt, class _Fn>
inline typename details::_enable_if_policy<_ExPolicy, void>::type generate(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Fn _Func)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	details::_Generate_impl(_Policy, _First, _Last, _Func, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _OutIt, class _Diff, class _Fn>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type generate_n(_ExPolicy&& _Policy, _OutIt _First, _Diff _Count, _Fn _Func)
{
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	return details::_Generate_n_impl(_Policy, _First, _Count, _Func, std::_Iter_cat(_First));
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_GENERATE_H_
