#pragma once

#ifndef _IMPL_SEARCH_H_
#define _IMPL_SEARCH_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// search_n
	//
	template <class _FwdIt, class _Diff, class _Ty, class _Pr, class _IterCat>
	_FwdIt _Search_impl_n(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Diff _Count, const _Ty& _Val, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::search_n(_First, _Last, _Count, _Val, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Diff, class _Ty, class _Pr, class _IterCat>
	_FwdIt _Search_impl_n(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Diff _Count, const _Ty& _Val, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_FwdIt>::difference_type difference_type;

		if (_Count <= 0)
			return _First;

		auto _Size = std::distance(_First, _Last);
		if (_Size < static_cast<difference_type>(_Count))
			return _Last;

		cancellation_token_with_position<difference_type> _Token(_Size);

		_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Size - _Count + 1, _Pred, // No sense to run check on the _Size - _Count + 1 because the needle will never match
			[&_Token, &_Val, _Count, &_First](_FwdIt& _Begin, size_t _Partition_count, _Pr _UserPred){

			auto _Dist = std::distance(_First, _Begin);

			for (size_t _Curr_pos = 0; _Curr_pos < _Partition_count; ++_Curr_pos, ++_Begin) {

				if (_UserPred(*_Begin, _Val)) {
					_Diff _LocalCount = 1;

					for (; _LocalCount < static_cast<difference_type>(_Count); ++_LocalCount) {
						++_Begin;

						if (!_UserPred(*_Begin, _Val)) {
							// Move to correct position
							_Curr_pos += _LocalCount;
							break;
						}
						else if (_Token.is_cancelled(_Dist))
							return;
					}

					if (_LocalCount == _Count) {
						_Token.cancel(_Dist + _Curr_pos);
						return;
					}
				} // _Pred

				if (_Token.is_cancelled(_Dist))
					return;
			}
		});

		// Found matching item
		auto _Pos = _Token.get_position();
		if (_Pos != _Size) {
			std::advance(_First, _Pos);
			return _First;
		}

		return _Last;
	}

	template <class _FwdIt, class _Diff, class _Ty, class _Pr, class _IterCat>
	_FwdIt _Search_impl_n(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Diff _Count, const _Ty& _Val, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Search_impl_n, _Policy, _First, _Last, _Count, _Val, _Pred, _Cat);
	}

	//
	// search
	//
	template <class _FwdIt, class _FwdIt2, class _Pr, class _IterCat>
	_FwdIt _Search_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::search(_First, _Last, _First2, _Last2, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _FwdIt2, class _Pr, class _IterCat>
	_FwdIt _Search_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_FwdIt>::difference_type difference_type;

		auto _Count = std::distance(_First2, _Last2);
		if (_Count <= 0)
			return _First;

		auto _Size = std::distance(_First, _Last);
		if (_Count > _Size)
			return _Last;

		cancellation_token_with_position<difference_type> _Token(_Size);

		_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Size - _Count + 1, _Pred, // No sense to run check on the _Size - _Count + 1 because the needle will never match
			[&_Token, &_First2, _Count, &_First](_FwdIt& _Begin, size_t _Partition_count, _Pr _UserPred) {

			auto _Dist = std::distance(_First, _Begin);

			for (size_t _Curr_pos = 0; _Curr_pos < _Partition_count; ++_Curr_pos, ++_Begin) {

				if (_UserPred(*_Begin, *_First2)) {
					difference_type _LocalCount = 1;
					auto _Needle = _First2;
					auto _Mid = _Begin;

					for (; _LocalCount < _Count; ++_LocalCount) {
						++_Needle;
						++_Mid;

						if (!_UserPred(*_Mid, *_Needle))
							break;
						else if (_Token.is_cancelled(_Dist))
							return;
					}

					if (_LocalCount == _Count) {
						_Token.cancel(_Dist + _Curr_pos);
						return;
					}
				} // _Pred

				if (_Token.is_cancelled(_Dist))
					return;
			}
		});

		// Found matching item
		auto _Pos = _Token.get_position();
		if (_Pos != _Size) {
			std::advance(_First, _Pos);
			return _First;
		}

		return _Last;
	}

	template <class _FwdIt, class _FwdIt2, class _Pr, class _IterCat>
	_FwdIt _Search_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Search_impl, _Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _FwdIt, class _FwdIt2, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type search(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt2>::iterator_category>::value, "Required forward iterator or stronger.");

	details::common_iterator<_FwdIt, _FwdIt2>::iterator_category _Cat;
	return details::_Search_impl(_Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
}

template<class _ExPolicy, class _FwdIt, class _FwdIt2>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type search(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2)
{
	return search(_Policy, _First, _Last, _First2, _Last2, std::equal_to<>());
}

template<class _ExPolicy, class _FwdIt, class _Diff, class _Ty, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type search_n(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Diff _Count, const _Ty& _Val, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Search_impl_n(_Policy, _First, _Last, _Count, _Val, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _FwdIt, class _Diff, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type search_n(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Diff _Count, const _Ty& _Val)
{
	return search_n(_Policy, _First, _Last, _Count, _Val, std::equal_to<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_SEARCH_H_
