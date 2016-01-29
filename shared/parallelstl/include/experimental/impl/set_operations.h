#pragma once

#ifndef _IMPL_SET_UNION_H_
#define _IMPL_SET_UNION_H_ 1

#include "algorithm_impl.h"
#include "foreach.h"
#include "copy.h"
#include <vector>
#include <algorithm>
#include <numeric>
#include <type_traits>

_PSTL_NS1_BEGIN
namespace details
{
	struct _SplitedChunk
	{
		size_t _Start, _Len, _Accumulated;
	};

	template <typename _T>
	class _NullablePointerWrapper
	{
		const _T * _M_Item;

	public:
		_NullablePointerWrapper()
		{
			_M_Item = nullptr;
		}

		_NullablePointerWrapper(const _T &_Item)
		{
			_M_Item = &_Item;
		}

		_NullablePointerWrapper & operator =(const _T &_Item)
		{
			_M_Item = &_Item;
			return *this;
		}

		operator const _T &() const
		{
			_ASSERT(_M_Item != nullptr);
			return *_M_Item;
		}
	};

	template <typename OutItr>
	struct SetOperationBuffer
	{
		typedef typename std::iterator_traits<OutItr>::value_type ValueType;

		static _NullablePointerWrapper<ValueType> notUseWrapper(std::false_type);
		static typename ValueType notUseWrapper(std::true_type);
		typedef decltype(notUseWrapper(typename std::is_scalar<ValueType>::type())) ValueType2;

		typedef std::vector<ValueType2> BufferType;
		typedef typename BufferType::iterator IteratorType;
	};

	template <typename _RandItr1, typename _RandItr2, typename _RandItr3, typename SetOp, typename _CancPos, typename _Comp>
	_RandItr3 _ParallelSetOperation(_RandItr1 _Begin1, size_t _Len1, _RandItr2 _Begin2, size_t _Len2, _RandItr3 _Output, size_t _ConcurrencyLevel, SetOp _SetOp, _CancPos _CalcPos, _Comp _Cmp)
	{
		if (_ConcurrencyLevel > _Len1)
			_ConcurrencyLevel = _Len1;

		size_t _Step = (_Len1 + _ConcurrencyLevel - 1) / _ConcurrencyLevel;
		std::vector<_SplitedChunk> _ChunkInfo(_ConcurrencyLevel);

		// a reference _Buffer as big as the input data
		typename SetOperationBuffer<_RandItr3>::BufferType _Buffer(_CalcPos(_Len1, _Len2));

		// _Step 1: filter
		_Partitioner<static_partitioner_tag>::_For_Each(_ChunkInfo.begin(), _ChunkInfo.size(), _Cmp,
			[&_Step, &_Len1, &_Begin1, &_Begin2, &_Len2, &_CalcPos, &_SetOp, &_ChunkInfo, &_Buffer](std::vector<_SplitedChunk>::iterator _CurItr, size_t, _Comp& _UserFunc) {
			size_t _Start1 = (_CurItr - _ChunkInfo.begin()) * _Step;
			size_t _End1 = (std::min)(_Start1 + _Step, _Len1); // the last chunk can only be smaller than others, since we round up _Step

			// if it's not last chunk, we need to adjust tail
			if (_End1 < _Len1)
			{
				// all equal range. It will be handled by next chunk.
				if (!_UserFunc(_Begin1[_Start1], _Begin1[_End1]))
					return;
				while (!_UserFunc(_Begin1[_End1 - 1], _Begin1[_End1]))
					--_End1;
			}

			// Adjust head, until it reach the beginning
			while (_Start1 > 0 && !_UserFunc(_Begin1[_Start1 - 1], _Begin1[_Start1]))
				--_Start1;

			// find a paired range
			size_t _Start2 = _Start1 == 0 ? 0 : std::lower_bound(_Begin2, _Begin2 + _Len2, _Begin1[_Start1], _UserFunc) - _Begin2;
			size_t _End2 = _End1 == _Len1 ? _Len2 : std::upper_bound(_Begin2, _Begin2 + _Len2, _Begin1[_End1 - 1], _UserFunc) - _Begin2;

			_CurItr->_Start = _CalcPos(_Start1, _Start2);
			auto _OutItr = _Buffer.begin() + _CurItr->_Start;
			_CurItr->_Len = _SetOp(_Begin1 + _Start1, _Begin1 + _End1, _Begin2 + _Start2, _Begin2 + _End2, _OutItr, _UserFunc) - _OutItr;
		}, 1);

		// _Step 2: accumulation
		_ChunkInfo.front()._Accumulated = 0;
		for (size_t _I = 1; _I < _ChunkInfo.size(); _I++)
			_ChunkInfo[_I]._Accumulated = _ChunkInfo[_I - 1]._Accumulated + _ChunkInfo[_I - 1]._Len;

		// _Step 3: move
		_Partitioner<static_partitioner_tag>::_For_Each(_ChunkInfo.begin(), _ChunkInfo.size(), _Output,
			[&_Buffer](std::vector<_SplitedChunk>::iterator _CurItr, size_t, _RandItr3 _OutputIter) {
			std::copy(_Buffer.begin() + _CurItr->_Start, _Buffer.begin() + _CurItr->_Start + _CurItr->_Len, _OutputIter + _CurItr->_Accumulated);
		}, 1);

		return _Output + _ChunkInfo.back()._Accumulated + _ChunkInfo.back()._Len;
	}

	template <typename _ExPolicy, typename _RandItr1, typename _RandItr2, typename _RandItr3, typename _Comp>
	typename _enable_if_parallel<_ExPolicy, _RandItr3>::type set_union_impl(const _ExPolicy &_Policy, _RandItr1 _Begin1, _RandItr1 _End1, _RandItr2 _Begin2, _RandItr2 _End2, _RandItr3 _Output, _Comp _Cmp, std::random_access_iterator_tag)
	{
		size_t _Len1 = _End1 - _Begin1, _Len2 = _End2 - _Begin2;

		if (_Len1 == 0)
			return details::_Copy_impl(_Policy, _Begin2, _End2, _Output, std::random_access_iterator_tag());
		else if (_Len2 == 0)
			return details::_Copy_impl(_Policy, _Begin1, _End1, _Output, std::random_access_iterator_tag());
		else
		{
			size_t _ConcurrencyLevel = get_hardware_concurrency() * 2;
			return _ParallelSetOperation(_Begin1, _Len1, _Begin2, _Len2, _Output, _ConcurrencyLevel,
				static_cast<typename SetOperationBuffer<_RandItr3>::IteratorType(*)(_RandItr1, _RandItr1, _RandItr2, _RandItr2, typename SetOperationBuffer<_RandItr3>::IteratorType, _Comp)>(std::set_union),
				[](size_t _Left, size_t _Right) { return _Left + _Right; }, _Cmp);
		}
	}

	template <typename _ExPolicy, typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	typename _enable_if_parallel<_ExPolicy, OutputItr>::type set_union_impl(_ExPolicy &&, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _ItrTag)
	{
		return set_union_impl(seq, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _ItrTag);
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_union_impl(const sequential_execution_policy &, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat)
	{
		_EXP_TRY
			return std::set_union(_Begin1, _End1, _Begin2, _End2, _Output, _Cmp);
		_EXP_RETHROW
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_union_impl(const execution_policy &_Policy, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _ItrTag)
	{
		_EXP_GENERIC_EXECUTION_POLICY(set_union_impl, _Policy, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _ItrTag);
	}

	template <typename _ExPolicy, typename _RandItr1, typename _RandItr2, typename _RandItr3, typename _Comp>
	typename _enable_if_parallel<_ExPolicy, _RandItr3>::type set_intersection_impl(_ExPolicy &&, _RandItr1 _Begin1, _RandItr1 _End1, _RandItr2 _Begin2, _RandItr2 _End2, _RandItr3 _Output, _Comp _Cmp, std::random_access_iterator_tag)
	{
		size_t _Len1 = _End1 - _Begin1, _Len2 = _End2 - _Begin2;

		if (_Len1 == 0 || _Len2 == 0)
			return _Output;
		else
		{
			size_t _ConcurrencyLevel = get_hardware_concurrency() * 2;
			return _ParallelSetOperation(_Begin1, _Len1, _Begin2, _Len2, _Output, _ConcurrencyLevel,
				static_cast<typename SetOperationBuffer<_RandItr3>::IteratorType(*)(_RandItr1, _RandItr1, _RandItr2, _RandItr2, typename SetOperationBuffer<_RandItr3>::IteratorType, _Comp)>(std::set_intersection),
				[](size_t _Left, size_t _Right) { return (std::min)(_Left, _Right); }, _Cmp);
		}
	}

	template <typename _ExPolicy, typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	typename _enable_if_parallel<_ExPolicy, OutputItr>::type set_intersection_impl(_ExPolicy &&, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _ItrTag)
	{
		return set_intersection_impl(seq, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _ItrTag);
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_intersection_impl(const sequential_execution_policy &, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat)
	{
		_EXP_TRY
			return std::set_intersection(_Begin1, _End1, _Begin2, _End2, _Output, _Cmp);
		_EXP_RETHROW
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_intersection_impl(const execution_policy &_Policy, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(set_intersection_impl, _Policy, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _Cat);
	}

	template <typename _ExPolicy, typename _RandItr1, typename _RandItr2, typename _RandItr3, typename _Comp>
	typename _enable_if_parallel<_ExPolicy, _RandItr3>::type set_difference_impl(_ExPolicy &&_Policy, _RandItr1 _Begin1, _RandItr1 _End1, _RandItr2 _Begin2, _RandItr2 _End2, _RandItr3 _Output, _Comp _Cmp, std::random_access_iterator_tag)
	{
		size_t _Len1 = _End1 - _Begin1, _Len2 = _End2 - _Begin2;

		if (_Len1 == 0)
			return _Output;
		else if (_Len2 == 0)
			return details::_Copy_impl(std::forward<_ExPolicy>(_Policy), _Begin1, _End1, _Output, std::random_access_iterator_tag());
		else
		{
			size_t _ConcurrencyLevel = get_hardware_concurrency() * 2;
			return _ParallelSetOperation(_Begin1, _Len1, _Begin2, _Len2, _Output, _ConcurrencyLevel,
				static_cast<typename SetOperationBuffer<_RandItr3>::IteratorType(*)(_RandItr1, _RandItr1, _RandItr2, _RandItr2, typename SetOperationBuffer<_RandItr3>::IteratorType, _Comp)>(std::set_difference),
				[](size_t _Left, size_t) { return _Left; }, _Cmp);
		}
	}

	template <typename _ExPolicy, typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	typename _enable_if_parallel<_ExPolicy, OutputItr>::type set_difference_impl(_ExPolicy &&, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _Cat)
	{
		return set_difference_impl(seq, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _Cat);
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_difference_impl(const sequential_execution_policy &, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat)
	{
		_EXP_TRY
			return std::set_difference(_Begin1, _End1, _Begin2, _End2, _Output, _Cmp);
		_EXP_RETHROW
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_difference_impl(const execution_policy &_Policy, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(set_difference_impl, _Policy, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _Cat);
	}

	template <typename _ExPolicy, typename _RandItr1, typename _RandItr2, typename _RandItr3, typename _Comp>
	typename _enable_if_parallel<_ExPolicy, _RandItr3>::type set_symmetric_difference_impl(_ExPolicy &&_Policy, _RandItr1 _Begin1, _RandItr1 _End1, _RandItr2 _Begin2, _RandItr2 _End2, _RandItr3 _Output, _Comp _Cmp, std::random_access_iterator_tag)
	{
		size_t _Len1 = _End1 - _Begin1, _Len2 = _End2 - _Begin2;
		if (_Len1 == 0)
			return details::_Copy_impl(std::forward<_ExPolicy>(_Policy), _Begin2, _End2, _Output, std::random_access_iterator_tag());
		else if (_Len2 == 0)
			return details::_Copy_impl(std::forward<_ExPolicy>(_Policy), _Begin1, _End1, _Output, std::random_access_iterator_tag());
		else
		{
			size_t _ConcurrencyLevel = get_hardware_concurrency() * 2;
			return _ParallelSetOperation(_Begin1, _Len1, _Begin2, _Len2, _Output, _ConcurrencyLevel,
				static_cast<typename SetOperationBuffer<_RandItr3>::IteratorType(*)(_RandItr1, _RandItr1, _RandItr2, _RandItr2, typename SetOperationBuffer<_RandItr3>::IteratorType, _Comp)>(std::set_symmetric_difference),
				[](size_t _Left, size_t _Right) { return _Left + _Right; }, _Cmp);
		}
	}

	template <typename _ExPolicy, typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	typename _enable_if_parallel<_ExPolicy, OutputItr>::type set_symmetric_difference_impl(_ExPolicy &&, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _ItrTag)
	{
		return set_symmetric_difference_impl(seq, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _ItrTag);
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_symmetric_difference_impl(const sequential_execution_policy &, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat)
	{
		_EXP_TRY
			return std::set_symmetric_difference(_Begin1, _End1, _Begin2, _End2, _Output, _Cmp);
		_EXP_RETHROW
	}

	template <typename _InputItr1, typename _InputItr2, typename OutputItr, typename _Comp, typename _ItrCat>
	OutputItr set_symmetric_difference_impl(const execution_policy &_Policy, _InputItr1 _Begin1, _InputItr1 _End1, _InputItr2 _Begin2, _InputItr2 _End2, OutputItr _Output, _Comp _Cmp, _ItrCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(set_symmetric_difference_impl, _Policy, _Begin1, _End1, _Begin2, _End2, _Output, _Cmp, _Cat);
	}
} // details

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt, typename _Comp>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_union(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest, _Comp _Cmp)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt1>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required _Output iterator or stronger.");

	return details::set_union_impl(_Policy, _First1, _Last1, _First2, _Last2, _Dest, _Cmp, typename details::common_iterator<_InIt1, _InIt2, _OutIt>::iterator_category());
}

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_union(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest)
{
	return set_union(std::forward<_ExecPolicy>(_Policy), _First1, _Last1, _First2, _Last2, _Dest, std::less<typename std::iterator_traits<_InIt1>::value_type>());
}

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt, typename _Comp>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_intersection(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest, _Comp _Cmp)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt1>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required _Output iterator or stronger.");

	return details::set_intersection_impl(_Policy, _First1, _Last1, _First2, _Last2, _Dest, _Cmp, typename details::common_iterator<_InIt1, _InIt2, _OutIt>::iterator_category());
}

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_intersection(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest)
{
	return set_intersection(std::forward<_ExecPolicy>(_Policy), _First1, _Last1, _First2, _Last2, _Dest, std::less<>());
}

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt, typename _Comp>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_difference(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest, _Comp _Cmp)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt1>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required _Output iterator or stronger.");

	return details::set_difference_impl(_Policy, _First1, _Last1, _First2, _Last2, _Dest, _Cmp, typename details::common_iterator<_InIt1, _InIt2, _OutIt>::iterator_category());
}

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_difference(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest)
{
	return set_difference(std::forward<_ExecPolicy>(_Policy), _First1, _Last1, _First2, _Last2, _Dest, std::less<>());
}

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt, typename _Comp>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_symmetric_difference(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest, _Comp _Cmp)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt1>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required _Output iterator or stronger.");

	return details::set_symmetric_difference_impl(_Policy, _First1, _Last1, _First2, _Last2, _Dest, _Cmp, typename details::common_iterator<_InIt1, _InIt2, _OutIt>::iterator_category());
}

template <typename _ExecPolicy, typename _InIt1, typename _InIt2, typename _OutIt>
inline typename details::_enable_if_policy<_ExecPolicy, _OutIt>::type set_symmetric_difference(_ExecPolicy &&_Policy, _InIt1 _First1, _InIt1 _Last1, _InIt2 _First2, _InIt2 _Last2, _OutIt _Dest)
{
	return set_symmetric_difference(_Policy, _First1, _Last1, _First2, _Last2, _Dest, std::less<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_SET_UNION_H_
