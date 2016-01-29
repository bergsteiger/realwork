#pragma once

#ifndef _IMPL_UNINITIALIZED_COPY_H_
#define _IMPL_UNINITIALIZED_COPY_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// uninitialized_copy_n
	//
	template<class _InIt, class _Diff, class _FwdIt, class _IterCat>
	inline _FwdIt _Uninitialized_copy_n_impl(const sequential_execution_policy&, _InIt _First, _Diff _Count, _FwdIt _Dest, _IterCat)
	{
		_EXP_TRY
			return std::uninitialized_copy_n(_First, _Count, _Dest);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _Diff, class _FwdIt, class _IterCat>
	inline _FwdIt _Uninitialized_copy_n_impl(const _ExPolicy&, _InIt _First, _Diff _Count, _FwdIt _Dest, _IterCat)
	{
		typedef std::iterator_traits<_FwdIt>::value_type value_type;

		return std::get<1>(*_Partitioner<static_partitioner_tag>::_For_each_with_cleanup(make_composable_iterator(_First, _Dest), _Count, std::tuple<>(),
			[](composable_iterator<_InIt, _FwdIt> _Begin, size_t _Partition_size, std::tuple<>) {
			std::uninitialized_copy_n(std::get<0>(*_Begin), _Partition_size, std::get<1>(*_Begin));
		},
			[](composable_iterator<_InIt, _FwdIt> _Begin, size_t _Partition_size, std::exception_ptr& _Ex) { // cleanup callback - assuming each chunk has either fully completed or has rolled back due to an exception.
			if (_Ex == nullptr) { // destroy the objects that were already initialized on other threads
				_FwdIt _It = std::get<1>(*_Begin);

				for (; _Partition_size > 0; --_Partition_size, ++_It)
					(&*_It)->~value_type();
			}
		}));
	}

	template<class _ExPolicy, class _InIt, class _Diff, class _FwdIt>
	inline typename _enable_if_parallel<_ExPolicy, _FwdIt>::type _Uninitialized_copy_n_impl(const _ExPolicy&, _InIt _First, _Diff _Count, _FwdIt _Dest, std::input_iterator_tag _Cat)
	{
		return _Uninitialized_copy_n_impl(seq, _First, _Count, _Dest, _Cat);
	}

	template<class _InIt, class _Diff, class _FwdIt, class _IterCat>
	inline _FwdIt _Uninitialized_copy_n_impl(const execution_policy& _Policy, _InIt _First, _Diff _Count, _FwdIt _Dest, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Uninitialized_copy_n_impl, _Policy, _First, _Count, _Dest, _Cat);
	}

	//
	// uninitialized_copy
	//
	template<class _InIt, class _FwdIt, class _IterCat>
	inline _FwdIt _Uninitialized_copy_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _FwdIt _Dest, _IterCat)
	{
		_EXP_TRY
			return std::uninitialized_copy(_First, _Last, _Dest);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _FwdIt, class _IterCat>
	inline _FwdIt _Uninitialized_copy_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _FwdIt _Dest, _IterCat _Cat)
	{
		return _Uninitialized_copy_n_impl(_Policy, _First, std::distance(_First, _Last), _Dest, _Cat);
	}

	template<class _ExPolicy, class _InIt, class _FwdIt>
	inline typename _enable_if_parallel<_ExPolicy, _FwdIt>::type _Uninitialized_copy_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _FwdIt _Dest, std::input_iterator_tag _Cat)
	{
		return _Uninitialized_copy_impl(seq, _First, _Last, _Dest, _Cat);
	}

	template<class _InIt, class _FwdIt, class _IterCat>
	inline _FwdIt _Uninitialized_copy_impl(const execution_policy& _Policy, _InIt _First, _InIt _Count, _FwdIt _Dest, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Uninitialized_copy_impl, _Policy, _First, _Count, _Dest, _Cat);
	}
} // details

template<class _ExPolicy, class _InIt, class _Diff, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type uninitialized_copy_n(_ExPolicy&& _Policy, _InIt _First, _Diff _Count, _FwdIt _Dest)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	details::common_iterator<_InIt, _FwdIt>::iterator_category _Cat;
	return details::_Uninitialized_copy_n_impl(_Policy, _First, _Count, _Dest, _Cat);
}

template<class _ExPolicy, class _InIt, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type uninitialized_copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _FwdIt _Dest)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	details::common_iterator<_InIt, _FwdIt>::iterator_category _Cat;
	return details::_Uninitialized_copy_impl(_Policy, _First, _Last, _Dest, _Cat);
}
_PSTL_NS1_END// std::experimental::parallel

#endif // _IMPL_UNINITIALIZED_COPY_H_
