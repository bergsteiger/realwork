#pragma once

#ifndef _IMPL_ROTATE_H_
#define _IMPL_ROTATE_H_ 1

#include "algorithm_impl.h"
#include "reverse.h"
#include "taskgroup.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// rotate_copy
	//
	template <class _FwdIt, class _IterCat>
	_FwdIt _Rotate_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _IterCat)
	{
		_EXP_TRY
			return std::rotate(_First, _Mid, _Last);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _IterCat>
	_FwdIt _Rotate_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _IterCat)
	{
		if (_First != _Mid && _Mid != _Last) {
			auto _Handle = make_task([&_Policy, &_First, &_Mid] {
				_Reverse_impl(_Policy, _First, _Mid);
			});

			TaskGroup _Tg;
			_Tg.run(_Handle);

			// Inline rest of the execution
			_Reverse_impl(_Policy, _Mid, _Last);
			_Tg.wait();
			_Reverse_impl(_Policy, _First, _Last);
		}

		std::advance(_First, std::distance(_Mid, _Last));
		return _First;
	}

	template <class _ExPolicy, class _FwdIt>
	inline typename _enable_if_parallel<_ExPolicy, _FwdIt>::type _Rotate_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, std::forward_iterator_tag _Cat)
	{
		return _Rotate_impl(seq, _First, _Mid, _Last, _Cat);
	}

	template <class _FwdIt, class _IterTag>
	inline _FwdIt _Rotate_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _IterTag _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Rotate_impl, _Policy, _First, _Mid, _Last, _Cat);
	}

	//
	// rotate_copy
	//
	template <class _FwdIt, class _OutIt, class _IterCat>
	_OutIt _Rotate_copy_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _OutIt _Dest, _IterCat)
	{
		_EXP_TRY
			return std::rotate_copy(_First, _Mid, _Last, _Dest);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _OutIt, class _IterCat>
	_OutIt _Rotate_copy_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _OutIt _Dest, _IterCat _Cat)
	{
		_Dest = _Copy_impl(_Policy, _Mid, _Last, _Dest, _Cat);
		return _Copy_impl(_Policy, _First, _Mid, _Dest, _Cat);
	}

	template <class _ExPolicy, class _FwdIt, class _OutIt>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Rotate_copy_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _OutIt _Dest, std::input_iterator_tag _Cat)
	{
		return _Rotate_copy_impl(seq, _First, _Mid, _Last, _Dest, _Cat);
	}

	template <class _FwdIt, class _OutIt, class _IterTag>
	inline _OutIt _Rotate_copy_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _OutIt _Dest, _IterTag _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Rotate_copy_impl, _Policy, _First, _Mid, _Last, _Dest, _Cat);
	}
} // details

template<class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type rotate(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Rotate_impl(_Policy, _First, _Mid, _Last, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt, class _OutIt>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type rotate_copy(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Mid, _FwdIt _Last, _OutIt _Dest)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_FwdIt, _OutIt>::iterator_category _Cat;
	return details::_Rotate_copy_impl(_Policy, _First, _Mid, _Last, _Dest, _Cat);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_ROTATE_H_
