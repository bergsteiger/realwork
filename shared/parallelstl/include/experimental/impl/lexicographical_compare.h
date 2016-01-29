#pragma once

#ifndef _IMPL_LEXICOGRAPHICAL_COMPARE_H_
#define _IMPL_LEXICOGRAPHICAL_COMPARE_H_ 1

#include "algorithm_impl.h"
#include "mismatch.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// lexicographical_compare
	//
	template<class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline bool _Lexicographical_compare_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::lexicographical_compare(_First, _Last, _First2, _Last2, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline bool _Lexicographical_compare_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat _Cat)
	{
		typedef std::iterator_traits<_InIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First != _Last && _First2 != _Last2) {

			auto _Pair = _Mismatch_impl(_Policy, _First, _Last, _First2, _Last2,
				[_Pred](std::iterator_traits<_InIt>::reference _Val, std::iterator_traits<_InIt2>::reference _Val2) {
				return !(_Pred(_Val, _Val2) || _Pred(_Val2, _Val));
			}, _Cat);

			if (_Pair.first != _Last && _Pair.second != _Last2)
				return _Pred(*_Pair.first, *_Pair.second);
			else return _Pair.second != _Last2;
		}

		return _First == _Last && _First2 != _Last2;
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, bool>::type _Lexicographical_compare_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Lexicographical_compare_impl(seq, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}

	template<class _InIt, class _InIt2, class _Pr, class _IterTag>
	inline bool _Lexicographical_compare_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterTag _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Lexicographical_compare_impl, _Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type lexicographical_compare(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");

	details::common_iterator<_InIt, _InIt2>::iterator_category _Cat;
	return details::_Lexicographical_compare_impl(_Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
}

template<class _ExPolicy, class _InIt, class _InIt2>
inline typename details::_enable_if_policy<_ExPolicy, bool>::type lexicographical_compare(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2)
{
	return lexicographical_compare(_Policy, _First, _Last, _First2, _Last2, std::less<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_LEXICOGRAPHICAL_COMPARE_H_
