#pragma once

#ifndef _IMPL_NTH_ELEMENT_H_
#define _IMPL_NTH_ELEMENT_H_ 1

#include "algorithm_impl.h"
#include "partition.h"
#include "sort.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// nth_element
	//
	template<class _RanIt, class _Pred>
	inline void _Nth_element_impl(const sequential_execution_policy&, _RanIt _First, _RanIt _Nth, _RanIt _Last, _Pred _Pr)
	{
		_EXP_TRY
			std::nth_element(_First, _Nth, _Last, _Pr);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _RanIt, class _Pred>
	inline void _Nth_element_impl(const _ExPolicy& _Policy, _RanIt _First, _RanIt _Nth, _RanIt _Last, _Pred _Pr)
	{
		const size_t _Chunk_size = 2048;

		if (_First == _Last)
			return;

		--_Last;

#pragma warning(suppress: 6295)
		for (; _Chunk_size > _Last - _First;) {
			_RanIt _Pivot = _First + (_Last - _First) / 2;
			std::swap(*_Pivot, *_Last);

			_Pivot = partition(_Policy, _First, _Last, [_Last, _Pr](std::iterator_traits<_RanIt>::reference _Val) mutable {
				return _Pr(_Val, *_Last);
			});

			std::swap(*_Last, *_Pivot);

			if (_Pivot == _Nth)
				return;
			else if (_Nth < _Pivot)
				_Last = _Pivot - 1;
			else _First = _Pivot + 1;
		}

		std::nth_element(_First, _Nth, _Last + 1, _Pr);
	}

	template<class _RanIt, class _Pred>
	inline void _Nth_element_impl(const execution_policy& _Policy, _RanIt _First, _RanIt _Nth, _RanIt _Last, _Pred _Pr)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Nth_element_impl, _Policy, _First, _Nth, _Last, _Pr);
	}
} // details

template<class _ExPolicy, class _RanIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, void>::type nth_element(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Nth, _RanIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::random_access_iterator_tag, typename std::iterator_traits<_RanIt>::iterator_category>::value, "Required random access iterator.");

	details::_Nth_element_impl(_Policy, _First, _Nth, _Last, _Pred);
}

template<class _ExPolicy, class _RanIt>
inline typename details::_enable_if_policy<_ExPolicy, void>::type nth_element(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Nth, _RanIt _Last)
{
	nth_element(_Policy, _First, _Nth, _Last, std::less<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_NTH_ELEMENT_H_