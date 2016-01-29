#pragma once

#ifndef _IMPL_MISMATCH_H_
#define _IMPL_MISMATCH_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {

	template<class _ExPolicy, class _InIt, class _Diff, class _InIt2, class _Pr>
	inline typename std::iterator_traits<_InIt>::difference_type _Mismatch_impl_helper(const _ExPolicy&, _InIt _First, _Diff _Size, _InIt2 _First2, _Pr _Pred)
	{
		typedef std::iterator_traits<_InIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		cancellation_token_with_position<difference_type> _Token(_Size);

		_Partitioner<_ExecutionPolicy>::_For_Each(make_composable_iterator(_First, _First2), _Size, _Pred,
			[&_Token, &_First](composable_iterator<_InIt, _InIt2> _Begin, size_t _Partition_count, _Pr& _UserPred) {
			auto _Dist = std::distance(_First, std::get<0>(*_Begin));

			for (size_t _Curr_pos = 0; _Curr_pos < _Partition_count; ++_Curr_pos, ++_Begin) {
				if (!_UserPred(*std::get<0>(*_Begin), *std::get<1>(*_Begin))) {
					_Token.cancel(_Dist + _Curr_pos);
					return;
				}

				if (_Token.is_cancelled(_Dist + _Curr_pos))
					break;
			}
		});

		return _Token.get_position();
	}

	//
	// mismatch
	//
	template<class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline std::pair<_InIt, _InIt2> _Mismatch_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _InIt2 _First2, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::mismatch(_First, _Last, _First2, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline std::pair<_InIt, _InIt2> _Mismatch_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _Pr _Pred, _IterCat)
	{
		// The assertion logic should be moved into partitioner
		static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value &&
			std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");

		auto _Size = std::distance(_First, _Last);
		if (_Size > 0) {
			auto _Pos = _Mismatch_impl_helper(_Policy, _First, _Size, _First2, _Pred);

			if (_Pos != _Size)
				std::advance(_First, _Pos);
			else _First = _Last;

			std::advance(_First2, _Pos);
		}

		return pair<_InIt, _InIt2>(_First, _First2);
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, std::pair<_InIt, _InIt2>>::type _Mismatch_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _InIt2 _First2, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Mismatch_impl(seq, _First, _Last, _First2, _Pred, _Cat);
	}

	template<class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline std::pair<_InIt, _InIt2> _Mismatch_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Mismatch_impl, _Policy, _First, _Last, _First2, _Pred, _Cat);
	}

	//
	// mismatch with 4 iterators
	//
	template<class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline std::pair<_InIt, _InIt2> _Mismatch_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			auto _Count = std::distance(_First, _Last);
		auto _Size = (std::min)(_Count, std::distance(_First2, _Last2));
		if (_Size > 0) {
			if (_Count != _Size) {
				_Last = _First;
				std::advance(_Last, _Count);
			}

			return std::mismatch(_First, _Last, _First2, _Pred);
		}

		return pair<_InIt, _InIt2>(_First, _First2);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline std::pair<_InIt, _InIt2> _Mismatch_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat)
	{
		static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value &&
			std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");

		auto _Size = (std::min)(std::distance(_First, _Last), std::distance(_First2, _Last2));
		if (_Size > 0) {
			auto _Pos = _Mismatch_impl_helper(_Policy, _First, _Size, _First2, _Pred);

			std::advance(_First, _Pos);
			std::advance(_First2, _Pos);
		}

		return pair<_InIt, _InIt2>(_First, _First2);
	}

	template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, std::pair<_InIt, _InIt2>>::type _Mismatch_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Mismatch_impl(seq, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}

	template<class _InIt, class _InIt2, class _Pr, class _IterCat>
	inline std::pair<_InIt, _InIt2> _Mismatch_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Mismatch_impl, _Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, std::pair<_InIt, _InIt2>>::type mismatch(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");

	details::common_iterator<_InIt, _InIt2>::iterator_category _Cat;
	return details::_Mismatch_impl(_Policy, _First, _Last, _First2, _Pred, _Cat);
}

template<class _ExPolicy, class _InIt, class _InIt2>
inline typename details::_enable_if_policy<_ExPolicy, std::pair<_InIt, _InIt2>>::type mismatch(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2)
{
	return mismatch(_Policy, _First, _Last, _First2, std::equal_to<>());
}

template<class _ExPolicy, class _InIt, class _InIt2, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, std::pair<_InIt, _InIt2>>::type mismatch(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");

	details::common_iterator<_InIt, _InIt2>::iterator_category _Cat;
	return details::_Mismatch_impl(_Policy, _First, _Last, _First2, _Last2, _Pred, _Cat);
}

template<class _ExPolicy, class _InIt, class _InIt2>
inline typename details::_enable_if_policy<_ExPolicy, std::pair<_InIt, _InIt2>>::type mismatch(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _InIt2 _Last2)
{
	return mismatch(_Policy, _First, _Last, _First2, _Last2, std::equal_to<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_MISMATCH_H_
