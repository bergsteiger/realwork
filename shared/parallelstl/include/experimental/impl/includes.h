#pragma once

#ifndef _IMPL_INCLUDES_H_
#define _IMPL_INCLUDES_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// includes
	//
	template<class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline bool _Includes_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::includes(_First, _Last, _First2, _Last2, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline bool _Includes_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First2 == _Last2)
			return true;

		if (_First != _Last) {
			auto _Size = std::distance(_First2, _Last2);
			cancellation_token _Token;

			_Partitioner<_ExecutionPolicy>::_For_Each(_First2, _Size, _Pred,
				[_First, _Last, _First2, _Last2, &_Token](_InIt2 _Begin, size_t _Partition_count, _Pr& _UserPred) {
				_ASSERTE(_Partition_count > 0);

				auto _End_val = _Begin;
				std::advance(_End_val, _Partition_count - 1);
				auto _End = _End_val;
				++_End;

				if (_First2 != _Begin) {
					_Begin = std::upper_bound(_Begin, _End, *_Begin, _UserPred); // Find the next element only in the chunk

					if (_Begin == _End)
						return;
				}

				auto _LoBound = std::lower_bound(_First, _Last, *_Begin, _UserPred);
				if (_LoBound == _Last || _UserPred(*_Begin, *_LoBound)) {
					_Token.cancel();
					return;
				}

				_InIt2 _HiBound;

				if (_End != _Last2) {
					_HiBound = std::upper_bound(_LoBound, _Last, *_End, _UserPred);
					_End = std::upper_bound(_End, _Last2, *_End, _UserPred);
				}
				else _HiBound = _Last;

				if (!std::includes(_LoBound, _HiBound, _Begin, _End, _UserPred))
					_Token.cancel();
			});

			return !_Token.is_cancelled();
		}

		return false;
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, bool>::type _Includes_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Includes_impl(seq, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}

	template<class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline bool _Includes_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Includes_impl, _Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type includes(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");

	details::common_iterator<_InIt, _InIt2>::iterator_category _Cat;
	return details::_Includes_impl(_Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
}

template<class _ExPolicy, class _InIt, class _InIt2>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type includes(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2)
{
	return includes(_Policy, _First, _Last, _First2, _Last2, std::less<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_INCLUDES_H_
