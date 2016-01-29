#pragma once

#ifndef _IMPL_IS_PARTITIONED_H_
#define _IMPL_IS_PARTITIONED_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// is_partitioned
	//
	template<class _InIt, class _Pr, class _IterTag>
	inline bool _Is_partitioned_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterTag)
	{
		_EXP_TRY
			return std::is_partitioned(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _Pr, class _IterTag>
	inline bool _Is_partitioned_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterTag)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_InIt>::difference_type difference_type;

		auto _Size = std::distance(_First, _Last);
		if (_Size > 1) {
			cancellation_token _Token;

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Size - 1, _Pred,
				[&_Token](_InIt _Begin, size_t _Count, _Pr& _UserPred) {
				_ASSERTE(_Count > 0); // Must process at least 1 element

				// To avoid warning C4800 forcing value to bool
				bool _Last_val = _UserPred(*_Begin) ? true : false;
				LoopHelper<_ExecutionPolicy, _InIt>::Loop(++_Begin, _Count,
					[&_Token, &_UserPred, &_Last_val](typename std::iterator_traits<_InIt>::reference _El){
					bool _Val = _UserPred(_El) ? true : false;

					if (_Last_val < _Val)
						_Token.cancel();

					_Last_val = _Val;
				}, _Token);
			});

			return !_Token.is_cancelled();
		}

		return true;
	}

	template<class _ExPolicy, class _InIt, class _Fn>
	inline typename _enable_if_parallel<_ExPolicy, bool>::type _Is_partitioned_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Fn _Pred, std::input_iterator_tag _Cat)
	{
		return _Is_partitioned_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template<class _InIt, class _Fn, class _IterTag>
	inline bool _Is_partitioned_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _Fn _Pred, _IterTag _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Is_partitioned_impl, _Policy, _First, _Last, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _InIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type is_partitioned(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Is_partitioned_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_IS_PARTITIONED_H_
