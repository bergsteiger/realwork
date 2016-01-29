#pragma once

#ifndef _IMPL_FIND_H_
#define _IMPL_FIND_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// find
	//
	template<class _InIt, class _Pr, class _IterCat>
	inline _InIt _Find_if_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::find_if(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _Pr, class _IterCat>
	inline _InIt _Find_if_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_InIt>::difference_type difference_type;

		if (_First != _Last)
		{
			auto _Size = std::distance(_First, _Last);
			cancellation_token_with_position<difference_type> _Token(_Size);

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Size, _Pred,
				[&_Token, &_First](_InIt& _Begin, size_t _Count, _Pr& _UserPred){
				auto _Dist = std::distance(_First, _Begin);

				for (size_t _Curr_pos = 0; _Curr_pos < _Count; ++_Curr_pos, ++_Begin) {
					if (_UserPred(*_Begin)) {
						_Token.cancel(_Dist + _Curr_pos);
						break;
					}
					else if (_Token.is_cancelled(_Dist))
						break;
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

	template<class _ExPolicy, class _InIt, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, _InIt>::type _Find_if_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Find_if_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template<class _InIt, class _Pr, class _IterCat>
	inline _InIt _Find_if_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Find_if_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// find_first_of
	//
	template<class _InIt, class _FwdIt, class _BinPr, class _IterCat>
	inline _InIt _Find_first_of_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _FwdIt _First2, _FwdIt _Last2, _BinPr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::find_first_of(_First, _Last, _First2, _Last2, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _FwdIt, class _BinPr, class _IterCat>
	inline _InIt _Find_first_of_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _FwdIt _First2, _FwdIt _Last2, _BinPr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_InIt>::difference_type difference_type;

		if (_First != _Last && _First2 != _Last2)
		{
			auto _Size = std::distance(_First, _Last);
			cancellation_token_with_position<difference_type> _Token(_Size);

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Size, _Pred,
				[&_Token, &_First, &_First2, &_Last2](typename _InIt& _Begin, size_t _Count, _BinPr _UserPred){
				auto _Dist = std::distance(_First, _Begin);

				for (size_t _Curr_pos = 0; _Curr_pos < _Count; ++_Curr_pos, ++_Begin) {

					for (auto _Mid = _First2; _Mid != _Last2; ++_Mid) {
						if (_UserPred(*_Begin, *_Mid)) {
							_Token.cancel(_Dist + _Curr_pos);
							return;
						}
						else if (_Token.is_cancelled(_Dist))
							break;
					}
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

	template<class _ExPolicy, class _InIt, class _FwdIt, class _BinPr>
	inline typename _enable_if_parallel<_ExPolicy, _InIt>::type _Find_first_of_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _FwdIt _First2, _FwdIt _Last2, _BinPr _Pred, std::input_iterator_tag _Cat)
	{
		return _Find_first_of_impl(seq, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}

	template<class _InIt, class _FwdIt, class _BinPr, class _IterCat>
	inline _InIt _Find_first_of_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _FwdIt _First2, _FwdIt _Last2, _BinPr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Find_first_of_impl, _Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}

	//
	// find_end
	//
	template<class _FwdIt, class _FwdIt2, class _BinPr, class _IterCat>
	inline _FwdIt _Find_end_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _BinPr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::find_end(_First, _Last, _First2, _Last2, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _FwdIt, class _FwdIt2, class _BinPr, class _IterCat>
	inline _FwdIt _Find_end_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _BinPr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_FwdIt2>::difference_type difference_type;

		auto _Count = std::distance(_First2, _Last2);
		if (_Count <= 0)
			return _Last;

		auto _Size = std::distance(_First, _Last);
		if (_Count > _Size)
			return _Last;

		cancellation_token_with_position<difference_type, std::greater_equal<difference_type>> _Token(-1);

		_Partitioner<_ExecutionPolicy>::_For_Each(_First, _Size - _Count + 1, _Pred, // No sense to run check on the _Size - _Count + 1 because the needle will never match
			[&_Token, &_First2, _Count, &_First](_FwdIt& _Begin, size_t _Partition_count, _BinPr _UserPred) {

			auto _Dist = std::distance(_First, _Begin);
			auto _Offset = _Dist;

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
						_Token.cancel(_Offset + _Curr_pos);
						_Dist = _Offset + _Curr_pos + 1;
					}
				} // _Pred

				if (_Token.is_cancelled(_Dist))
					return;
			}
		});

		// Found matching item
		auto _Pos = _Token.get_position();
		if (_Pos != -1) {
			std::advance(_First, _Pos);
			return _First;
		}

		return _Last;
	}

	template<class _FwdIt, class _FwdIt2, class _BinPr, class _IterCat>
	inline _FwdIt _Find_end_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _BinPr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Find_end_impl, _Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}
} //details

template<class _ExPolicy, class _InIt, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, _InIt>::type find(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, const _Ty& _Val)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Find_if_impl(_Policy, _First, _Last, [&_Val](typename std::iterator_traits<_InIt>::reference _El){
		return _El == _Val;
	}, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _InIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _InIt>::type find_if(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Find_if_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _InIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _InIt>::type find_if_not(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Find_if_impl(_Policy, _First, _Last, [_Pred](typename std::iterator_traits<_InIt>::reference _El){
		return !_Pred(_El);
	}, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _InIt, class _FwdIt, class _BinPr>
inline typename details::_enable_if_policy<_ExPolicy, _InIt>::type find_first_of(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _FwdIt _First2, _FwdIt _Last2, _BinPr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Find_first_of_impl(_Policy, _First, _Last, _First2, _Last2, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _InIt, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _InIt>::type find_first_of(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _FwdIt _First2, _FwdIt _Last2)
{
	return find_first_of(_Policy, _First, _Last, _First2, _Last2, std::equal_to<>());
}

template<class _ExPolicy, class _FwdIt, class _FwdIt2, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type find_end(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt2>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Find_end_impl(_Policy, _First, _Last, _First2, _Last2, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _FwdIt, class _FwdIt2>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type find_end(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _FwdIt2 _First2, _FwdIt2 _Last2)
{
	return find_end(_Policy, _First, _Last, _First2, _Last2, std::equal_to<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_FIND_H_