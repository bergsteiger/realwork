#pragma once

#ifndef _IMPL_UNINITIALIZED_FILL_H_
#define _IMPL_UNINITIALIZED_FILL_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// uninitialized_fill_n
	//
	template<class _FwdIt, class _Diff, class _Ty, class _IterCat>
	inline _FwdIt _Uninitialized_fill_n_impl(const sequential_execution_policy&, _FwdIt _First, _Diff _Count, const _Ty& _Init, _IterCat)
	{
		_EXP_TRY
			return std::uninitialized_fill_n(_First, _Count, _Init);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _FwdIt, class _Diff, class _Ty, class _IterCat>
	inline _FwdIt _Uninitialized_fill_n_impl(const _ExPolicy&, _FwdIt _First, _Diff _Count, const _Ty& _Init, _IterCat)
	{
		typedef std::iterator_traits<_FwdIt>::value_type value_type;

		return _Partitioner<static_partitioner_tag>::_For_each_with_cleanup(_First, _Count, std::tuple<>(),
			[&_Init](_FwdIt _Begin, size_t _Partition_size, std::tuple<>) {
			std::uninitialized_fill_n(_Begin, _Partition_size, _Init);
		},
			[](_FwdIt _Begin, size_t _Partition_size, std::exception_ptr& _Ex) { // cleanup callback - assuming each chunk has either fully completed or has rolled back due to an exception.
			if (_Ex == nullptr) { // destroy the objects that were already initialized on other threads
				for (; _Partition_size > 0; --_Partition_size, ++_Begin)
					(&*_Begin)->~value_type();
			}
		});
	}

	template<class _FwdIt, class _Diff, class _Ty, class _IterCat>
	inline _FwdIt _Uninitialized_fill_n_impl(const execution_policy& _Policy, _FwdIt _First, _Diff _Count, const _Ty& _Init, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Uninitialized_fill_n_impl, _Policy, _First, _Count, _Init, _Cat);
	}

	//
	// uninitialized_fill
	//
	template<class _FwdIt, class _Ty, class _IterCat>
	inline void _Uninitialized_fill_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, const _Ty& _Init, _IterCat)
	{
		_EXP_TRY
			std::uninitialized_fill(_First, _Last, _Init);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _FwdIt, class _Ty, class _IterCat>
	inline void _Uninitialized_fill_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Init, _IterCat _Cat)
	{
		_Uninitialized_fill_n_impl(_Policy, _First, std::distance(_First, _Last), _Init, _Cat);
	}

	template<class _FwdIt, class _Ty, class _IterCat>
	inline void _Uninitialized_fill_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Init, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Uninitialized_fill_impl, _Policy, _First, _Last, _Init, _Cat);
	}
} // details

template<class _ExPolicy, class _FwdIt, class _Diff, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type uninitialized_fill_n(_ExPolicy&& _Policy, _FwdIt _First, _Diff _Count, const _Ty& _Init)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Uninitialized_fill_n_impl(_Policy, _First, _Count, _Init, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _FwdIt, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, void>::type uninitialized_fill(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, const _Ty& _Init)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	details::_Uninitialized_fill_impl(_Policy, _First, _Last, _Init, std::_Iter_cat(_First));
}
_PSTL_NS1_END// std::experimental::parallel

#endif // _IMPL_UNINITIALIZED_FILL_H_
