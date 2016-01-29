#pragma once

#ifndef _IMPL_ALL_ANY_NONE_OF_H_
#define _IMPL_ALL_ANY_NONE_OF_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// any_of
	//
	template <class _InIt, class _Pr, class _IterCat>
	bool _Any_of_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::any_of(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _Pr, class _IterCat>
	bool _Any_of_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First != _Last)
		{
			cancellation_token _Token;

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, std::distance(_First, _Last), _Pred,
				[&_Token](_InIt _Begin, size_t _Count, _Pr& _UserPred){

				LoopHelper<_ExecutionPolicy, _InIt>::Loop(_Begin, _Count, [&_Token, &_UserPred](const std::iterator_traits<_InIt>::reference _El){
					if (_UserPred(_El))
						_Token.cancel();
				}, _Token);

			});

			return _Token.is_cancelled();
		}

		return false;
	}

	template <class _ExPolicy, class _InIt, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, bool>::type _Any_of_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Any_of_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template <class _InIt, class _Pr, class _IterCat>
	inline bool _Any_of_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Any_of_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// all_of
	//
	template <class _InIt, class _Pr, class _IterCat>
	bool _All_of_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::all_of(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _Pr, class _IterCat>
	bool _All_of_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		if (_First != _Last) {
			return _Any_of_impl(_Policy, _First, _Last, [_Pred](const typename std::iterator_traits<_InIt>::reference _El){
				return !_Pred(_El);
			}, std::_Iter_cat(_First)) == false;

		}

		return true;
	}

	template <class _ExPolicy, class _InIt, class _Pr, class _IterCat>
	bool _All_of_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _All_of_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template <class _InIt, class _Pr, class _IterCat>
	bool _All_of_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_All_of_impl, _Policy, _First, _Last, _Pred, _Cat);
	}
} // details

template <class _ExPolicy, class _InIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type any_of(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Any_of_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _InIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type none_of(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Any_of_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First)) == false;
}

template <class _ExPolicy, class _InIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type all_of(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_All_of_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_ALL_ANY_NONE_OF_H_
