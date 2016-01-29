#pragma once

#ifndef _IMPL_ADJACENT_FIND_H_
#define _IMPL_ADJACENT_FIND_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// adjacent_find
	//
	template<class _FwdIt, class _BinPr, class _IterCat>
	inline _FwdIt _Adjacent_find_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _BinPr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::adjacent_find(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _FwdIt, class _BinPr, class _IterCat>
	inline _FwdIt _Adjacent_find_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _BinPr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_FwdIt>::difference_type difference_type;

		if (_First != _Last)
		{
			auto _Size = std::distance(_First, _Last);
			if (_Size < 2)
				return _Last;

			cancellation_token_with_position<difference_type> _Token(_Size);

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Size - 1, _Pred,
				[&_Token, &_First](_FwdIt _Begin, size_t _Count, _BinPr& _UserFunc){
				auto _Dist = std::distance(_First, _Begin);

				auto _Prev = _Begin;
				++_Begin;

				for (size_t _Curr_pos = 0; _Curr_pos < _Count; ++_Curr_pos, ++_Begin) {
					if (_UserFunc(*_Prev, *_Begin)) {
						_Token.cancel(_Dist + _Curr_pos);
						break;
					}
					else if (_Token.is_cancelled(_Dist))
						break;

					_Prev = _Begin;
				}
			});

			auto _Pos = _Token.get_position();
			if (_Pos != _Size) {
				std::advance(_First, _Pos);
				return _First;
			}
		}

		return _Last;
	}

	template<class _FwdIt, class _BinPr, class _IterCat>
	inline _FwdIt _Adjacent_find_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _BinPr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Adjacent_find_impl, _Policy, _First, _Last, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _FwdIt, class _BinPr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type adjacent_find(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _BinPr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Adjacent_find_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type adjacent_find(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Adjacent_find_impl(_Policy, _First, _Last, std::equal_to<>(), std::_Iter_cat(_First));
}
_PSTL_NS1_END// std::experimental::parallel

#endif // _IMPL_ADJACENT_FIND_H_
