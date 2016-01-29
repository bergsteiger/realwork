#pragma once

#ifndef _IMPL_REPLACE_H_
#define _IMPL_REPLACE_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// replace_if
	//
	template <class _FwdIt, class _Pr, class _Ty>
	void _Replace_if_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, const _Ty& _New)
	{
		_EXP_TRY
			std::replace_if(_First, _Last, _Pred, _New);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Pr, class _Ty>
	void _Replace_if_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, const _Ty& _New)
	{
		_For_each_n_impl(_Policy, _First, std::distance(_First, _Last),
			[_Pred, &_New](typename std::iterator_traits<_FwdIt>::reference _El){
			if (_Pred(_El))
				_El = _New;
		}, std::_Iter_cat(_First));
	}

	template <class _FwdIt, class _Pr, class _Ty>
	void _Replace_if_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, const _Ty& _New)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Replace_if_impl, _Policy, _First, _Last, _Pred, _New);
	}

	//
	// replace
	//
	template <class _FwdIt, class _Ty>
	inline void _Replace_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, const _Ty& _Old, const _Ty& _New)
	{
		_EXP_TRY
			std::replace(_First, _Last, _Old, _New);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Ty>
	inline void _Replace_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Old, const _Ty& _New)
	{
		_Replace_if_impl(_Policy, _First, _Last, [&_Old](typename std::iterator_traits<_FwdIt>::reference _El){
			return _El == _Old;
		}, _New);
	}

	template <class _FwdIt, class _Ty>
	inline void _Replace_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Old, const _Ty& _New)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Replace_impl, _Policy, _First, _Last, _Old, _New);
	}

	//
	// replace_copy_if
	//
	template <class _FwdIt, class _OutIt, class _Pr, class _Ty, class _IterCat>
	_OutIt _Replace_copy_if_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _OutIt _Dest, _Pr _Pred, const _Ty& _New, _IterCat)
	{
		_EXP_TRY
			return std::replace_copy_if(_First, _Last, _Dest, _Pred, _New);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _OutIt, class _Pr, class _Ty, class _IterCat>
	_OutIt _Replace_copy_if_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, _OutIt _Dest, _Pr _Pred, const _Ty& _New, _IterCat _Cat)
	{
		return std::get<1>(*_For_each_n_impl(_Policy, make_composable_iterator(_First, _Dest), std::distance(_First, _Last),
			[_Pred, &_New](typename composable_iterator<_FwdIt, _OutIt>::reference _It){
			if (_Pred(*std::get<0>(_It)))
				*std::get<1>(_It) = _New;
			else *std::get<1>(_It) = *std::get<0>(_It);
		}, _Cat));
	}

	template <class _FwdIt, class _OutIt, class _Pr, class _Ty, class _IterCat>
	_OutIt _Replace_copy_if_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _OutIt _Dest, _Pr _Pred, const _Ty& _New, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Replace_copy_if_impl, _Policy, _First, _Last, _Dest, _Pred, _New, _Cat);
	}

	//
	// replace_copy
	//
	template <class _InIt, class _OutIt, class _Ty, class _IterCat>
	_OutIt _Replace_copy_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, const _Ty& _Old, const _Ty& _New, _IterCat)
	{
		_EXP_TRY
			return std::replace_copy(_First, _Last, _Dest, _Old, _New);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _OutIt, class _Ty, class _IterCat>
	_OutIt _Replace_copy_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, const _Ty& _Old, const _Ty& _New, _IterCat _Cat)
	{
		return _Replace_copy_if_impl(_Policy, _First, _Last, _Dest, [&_Old](typename std::iterator_traits<_InIt>::reference _El){
			return _El == _Old;
		}, _New, _Cat);
	}

	template <class _ExPolicy, class _InIt, class _OutIt, class _Ty>
	typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Replace_copy_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, const _Ty& _Old, const _Ty& _New, std::input_iterator_tag _Cat)
	{
		return _Replace_copy_impl(seq, _First, _Last, _Dest, _Old, _New, _Cat);
	}

	template <class _InIt, class _OutIt, class _Ty, class _IterCat>
	_OutIt _Replace_copy_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, const _Ty& _Old, const _Ty& _New, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Replace_copy_impl, _Policy, _First, _Last, _Dest, _Old, _New, _Cat);
	}
} //details

template <class _ExPolicy, class _FwdIt, class _Pr, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, void>::type replace_if(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, const _Ty& _New)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	details::_Replace_if_impl(_Policy, _First, _Last, _Pred, _New);
}

template <class _ExPolicy, class _FwdIt, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, void>::type replace(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Old, const _Ty& _New)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	details::_Replace_impl(_Policy, _First, _Last, _Old, _New);
}

template <class _ExPolicy, class _InIt, class _OutIt, class _Pr, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type replace_copy_if(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, const _Ty& _New)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Replace_copy_if_impl(_Policy, _First, _Last, _Dest, _Pred, _New, _Cat);
}

template <class _ExPolicy, class _InIt, class _OutIt, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type replace_copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, const _Ty& _Old, const _Ty& _New)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Replace_copy_impl(_Policy, _First, _Last, _Dest, _Old, _New, _Cat);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_REPLACE_H_
