#pragma once

#ifndef _IMPL_REVERSE_H_
#define _IMPL_REVERSE_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// reverse_copy
	//
	template <class _BidIt, class _OutIt, class _IterCat>
	_OutIt _Reverse_copy_impl(const sequential_execution_policy&, _BidIt _First, _BidIt _Last, _OutIt _Dest, _IterCat)
	{
		_EXP_TRY
			return std::reverse_copy(_First, _Last, _Dest);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _BidIt, class _OutIt, class _IterCat>
	_OutIt _Reverse_copy_impl(const _ExPolicy& _Policy, _BidIt _First, _BidIt _Last, _OutIt _Dest, _IterCat _Cat)
	{
		auto _Count = std::distance(_First, _Last);
		auto _Rev_first = std::reverse_iterator<_BidIt>(_Last);

		return std::get<1>(*_For_each_n_impl(_Policy, make_composable_iterator(_Rev_first, _Dest), _Count,
			[](typename composable_iterator<std::reverse_iterator<_BidIt>, _OutIt>::reference _It){
			*std::get<1>(_It) = *std::get<0>(_It);
		}, _Cat));
	}

	template <class _ExPolicy, class _BidIt, class _OutIt>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Reverse_copy_impl(const _ExPolicy&, _BidIt _First, _BidIt _Last, _OutIt _Dest, std::input_iterator_tag _Cat)
	{
		return _Reverse_copy_impl(seq, _First, _Last, _Dest, _Cat);
	}

	template <class _BidIt, class _OutIt, class _IterTag>
	inline _OutIt _Reverse_copy_impl(const execution_policy& _Policy, _BidIt _First, _BidIt _Last, _OutIt _Dest, _IterTag _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Reverse_copy_impl, _Policy, _First, _Last, _Dest, _Cat);
	}

	//
	// reverse
	//
	template <class _BidIt>
	void _Reverse_impl(const sequential_execution_policy&, _BidIt _First, _BidIt _Last)
	{
		_EXP_TRY
			std::reverse(_First, _Last);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _BidIt>
	void _Reverse_impl(const _ExPolicy& _Policy, _BidIt _First, _BidIt _Last)
	{
		auto _Count = std::distance(_First, _Last);
		auto _Rev_last = std::reverse_iterator<_BidIt>(_Last);

		std::get<1>(*_For_each_n_impl(_Policy, make_composable_iterator(_First, _Rev_last), _Count / 2,
			[](typename composable_iterator<_BidIt, std::reverse_iterator<_BidIt> >::reference _It){
			swap(*std::get<0>(_It), *std::get<1>(_It));
		}, std::_Iter_cat(_First)));
	}

	template <class _BidIt, class _IterTag>
	void _Reverse_impl(const execution_policy& _Policy, _BidIt _First, _BidIt _Last)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Lexicographical_compare_impl, _Policy, _First, _Last, _Cat);
	}
} // details

template <class _ExPolicy, class _BidIt, class _OutIt>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type reverse_copy(_ExPolicy&& _Policy, _BidIt _First, _BidIt _Last, _OutIt _Dest)
{
	static_assert(std::is_base_of<std::bidirectional_iterator_tag, typename std::iterator_traits<_BidIt>::iterator_category>::value, "Required bidirectional iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_BidIt, _OutIt>::iterator_category _Cat;
	return details::_Reverse_copy_impl(_Policy, _First, _Last, _Dest, _Cat);
}
template <class _ExPolicy, class _BidIt>
inline typename details::_enable_if_policy<_ExPolicy, void>::type reverse(_ExPolicy&& _Policy, _BidIt _First, _BidIt _Last)
{
	static_assert(std::is_base_of<std::bidirectional_iterator_tag, typename std::iterator_traits<_BidIt>::iterator_category>::value, "Required bidirectional iterator or stronger.");

	details::_Reverse_impl(_Policy, _First, _Last);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_REVERSE_H_
