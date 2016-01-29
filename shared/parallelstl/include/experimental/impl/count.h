#pragma once

#ifndef _IMPL_COUNT_H_
#define _IMPL_COUNT_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// count_if
	//
	template <class _InIt, class _Pr, class _IterCat>
	typename std::iterator_traits<_InIt>::difference_type _Count_if_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::count_if(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _Pr, class _IterCat>
	typename std::iterator_traits<_InIt>::difference_type _Count_if_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef typename std::iterator_traits<_InIt>::difference_type difference_type;

		if (_First != _Last) {
			combinable<difference_type> _Combine;

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, std::distance(_First, _Last), _Pred,
				[&_Combine](_InIt _Begin, size_t _Count, _Pr& _UserPred){

				auto &_CountEl = _Combine.local();

				LoopHelper<_ExecutionPolicy, _InIt>::Loop(_Begin, _Count, [&_CountEl, &_UserPred](const typename std::iterator_traits<_InIt>::reference _El){
					if (_UserPred(_El))
						_CountEl++;
				});

			});

			return _Combine.combine([](difference_type _Sum, difference_type _Val){
				return _Sum + _Val;
			});
		}

		return 0;
	}

	template <class _ExPolicy, class _InIt, class _Pr>
	typename _enable_if_parallel<_ExPolicy, typename std::iterator_traits<_InIt>::difference_type>::type _Count_if_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Count_if_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template <class _InIt, class _Pr, class _IterCat>
	typename std::iterator_traits<_InIt>::difference_type _Count_if_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Count_if_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// count
	//
	template <class _InIt, class _Ty, class _IterCat>
	typename std::iterator_traits<_InIt>::difference_type _Count_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, const _Ty& _Val, _IterCat)
	{
		_EXP_TRY
			return std::count(_First, _Last, _Val);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _Ty, class _IterCat>
	typename std::iterator_traits<_InIt>::difference_type _Count_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, const _Ty& _Val, _IterCat _Cat)
	{
		return _Count_if_impl(_Policy, _First, _Last, [&_Val](const typename std::iterator_traits<_InIt>::reference _El){
			return _Val == _El;
		}, _Cat);
	}

	template <class _ExPolicy, class _InIt, class _Ty, class _IterCat>
	typename _enable_if_parallel<_ExPolicy, typename std::iterator_traits<_InIt>::difference_type>::type _Count_impl(const _ExPolicy&, _InIt _First, _InIt _Last, const _Ty& _Val, std::input_iterator_tag _Cat)
	{
		return _Count_impl(seq, _First, _Last, _Val, _Cat);
	}

	template <class _InIt, class _Ty, class _IterCat>
	typename std::iterator_traits<_InIt>::difference_type _Count_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, const _Ty& _Val, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Count_impl, _Policy, _First, _Last, _Val, _Cat);
	}
} // details

template <class _ExPolicy, class _InIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, typename std::iterator_traits<_InIt>::difference_type>::type count_if(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Count_if_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _InIt, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, typename std::iterator_traits<_InIt>::difference_type>::type count(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, const _Ty& _Val)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Count_impl(_Policy, _First, _Last, _Val, std::_Iter_cat(_First));
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_COUNT_H_
