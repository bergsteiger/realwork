#pragma once

#ifndef _IMPL_IS_SORTED_H_
#define _IMPL_IS_SORTED_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// is_sorted
	//
	template <class _FwdIt, class _Pr, class _IterCat>
	inline bool _Is_sorted_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::is_sorted(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Pr, class _IterCat>
	inline bool _Is_sorted_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		auto _Diff = std::distance(_First, _Last);
		if (_Diff > 1)
		{
			cancellation_token _Token;

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Diff - 1, _Pred,
				[&_Token](_FwdIt& _Begin, size_t _Count, _Pr& _UserPred){
				_ASSERTE(_Count > 0); // Must process at least 1 element

				auto _Curr = _Begin;
				LoopHelper<_ExecutionPolicy, composable_iterator<_FwdIt> >::Loop(make_composable_iterator<_FwdIt>(++_Begin), _Count,
					[&_Token, &_UserPred, &_Curr](typename composable_iterator<_FwdIt>::reference _El){
					auto _It = std::get<0>(_El);

					if (_UserPred(*_It, *_Curr))
						_Token.cancel();

					_Curr = _It;
				}, _Token);
			});

			return !_Token.is_cancelled();
		}

		return true;
	}

	template <class _FwdIt, class _Pr, class _IterCat>
	inline bool _Is_sorted_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Is_sorted_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// is_sorted_until
	//
	template <class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Is_sorted_until_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::is_sorted_until(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Is_sorted_until_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_FwdIt>::difference_type difference_type;

		auto _Diff = std::distance(_First, _Last);
		if (_Diff > 1)
		{
			cancellation_token_with_position<difference_type> _Token(_Diff);

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Diff - 1, _Pred,
				[&_First, &_Token](_FwdIt& _Begin, size_t _Count, _Pr _UserPred){
				_ASSERTE(_Count > 0); // Must process at least 1 element

				auto _Dist = std::distance(_First, _Begin);
				auto _Curr = _Begin;
				auto _Begin_pos = size_t{ 1 };

				// Start loop form the next element
				++_Begin;

				// Compare the whole range and one element from outside the range
				for (; _Begin_pos < _Count + 1; ++_Begin_pos, ++_Begin) {
					if (_UserPred(*_Begin, *_Curr)) {
						_Token.cancel(_Dist + _Begin_pos);
						return;
					}

					if (_Token.is_cancelled(_Dist))
						return;

					_Curr = _Begin;
				}
			});

			auto _Pos = _Token.get_position();
			if (_Pos != _Diff) { // Found matching item, avoid using advance if return _Last
				std::advance(_First, _Pos);
				return _First;
			}
		}

		return _Last;
	}

	template <class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Is_sorted_until_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Is_sorted_until_impl, _Policy, _First, _Last, _Pred, _Cat);
	}
} // namespace

template <class _ExPolicy, class _FwdIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type is_sorted(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Is_sorted_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type is_sorted(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Is_sorted_impl(_Policy, _First, _Last, std::less<>(), std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type is_sorted_until(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Is_sorted_until_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type is_sorted_until(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return is_sorted_until(_Policy, _First, _Last, std::less<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_IS_SORTED_H_
