#pragma once

#ifndef _IMPL_PARTITION_H_
#define _IMPL_PARTITION_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details
{
	class _PartitionRangeHelper
	{
		std::atomic<size_t> _M_Begin, _M_End, _M_UsedSize;
		size_t _M_ChunkSize, _M_TotalSize;

		size_t _AcquireChunk()
		{
			if (_M_UsedSize >= _M_TotalSize)
				return 0;

			size_t _Avail = _M_UsedSize += _M_ChunkSize;
			if (_Avail - _M_ChunkSize >= _M_TotalSize)
				return 0;
			else
				return (std::min)(_M_TotalSize - (_Avail - _M_ChunkSize), _M_ChunkSize);
		}

	public:

		_PartitionRangeHelper(size_t _TotalSize, size_t _ChunkSize) : _M_Begin(0), _M_End(_TotalSize), _M_ChunkSize(_ChunkSize), _M_UsedSize(0), _M_TotalSize(_TotalSize) {}

		// It should only be called when the entire _Range has been acquired (_AcquireLeft or _AcquireRight returns empty _Range).
		size_t _Boundary() const
		{
			return _M_Begin;
		}

		std::pair<size_t, size_t> _AcquireLeft()
		{
			size_t _Avail = _AcquireChunk();
			if (_Avail == 0)
				return std::pair<size_t, size_t>(0, 0);
			size_t _Pos = _M_Begin += _Avail;
			return std::make_pair(_Pos - _Avail, _Pos);
		}

		std::pair<size_t, size_t> _AcquireRight()
		{
			size_t _Avail = _AcquireChunk();
			if (_Avail == 0)
				return std::pair<size_t, size_t>(0, 0);
			size_t _Pos = _M_End -= _Avail;
			return std::make_pair(_Pos, _Pos + _Avail);
		}
	};

	inline bool _IsPairRangeEmpty(const std::pair<size_t, size_t> &_Range)
	{
		return _Range.first == _Range.second;
	}

	// Moves a sub-array into a new position of the current array.
	// All elements will be preserved (no override), but element orders may be rearranged.
	template <typename Itr>
	size_t _MoveRangeImpl(Itr _Begin, std::pair<size_t, size_t> _Range, size_t _Target)
	{
		if (_Target == _Range.first)
			return _Range.second;
		size_t _TargetEnd = _Target + _Range.second - _Range.first;
		if (_Target < _Range.second && _Range.first < _TargetEnd)
		{
			if (_Range.first < _Target)
				std::swap(_Range.second, _Target);
			else
				_Range.first = _TargetEnd;
		}
		std::swap_ranges(_Begin + _Range.first, _Begin + _Range.second, _Begin + _Target);
		return _TargetEnd;
	}

	template <typename Itr, typename Predicate>
	size_t _Parallel_partition_impl(Itr _Begin, size_t size, const Predicate &_Pred, size_t _ChunkSize, size_t _ConcurrencyLevel)
	{
		_ASSERT(_ChunkSize > 0);
		std::vector<std::pair<size_t, size_t>> _LeftOver(_ConcurrencyLevel);
		_PartitionRangeHelper _Helper(size, _ChunkSize);

		// main parallel phase
		details::_Partitioner<static_partitioner_tag>::_For_Each(_LeftOver.begin(), _LeftOver.size(), _Pred,
			[&_Helper, &_Begin](std::vector<std::pair<size_t, size_t>>::iterator _CurItr, size_t, Predicate& _UserPred) {
			auto _Left = _Helper._AcquireLeft();
			if (_IsPairRangeEmpty(_Left))
			{
				*_CurItr = _Left;
				return;
			}
			auto _Right = _Helper._AcquireRight();
			if (_IsPairRangeEmpty(_Right))
			{
				*_CurItr = _Left;
				return;
			}

			for (;;)
			{
				while ((!_IsPairRangeEmpty(_Left) || !_IsPairRangeEmpty(_Left = _Helper._AcquireLeft())) && _UserPred(_Begin[_Left.first]))
					++_Left.first;

				while ((!_IsPairRangeEmpty(_Right) || !_IsPairRangeEmpty(_Right = _Helper._AcquireRight())) && !_UserPred(_Begin[_Right.second - 1]))
					--_Right.second;

				if (_IsPairRangeEmpty(_Left))
				{
					*_CurItr = _Right;
					return;
				}
				if (_IsPairRangeEmpty(_Right))
				{
					*_CurItr = _Left;
					return;
				}

				std::iter_swap(_Begin + _Left.first++, _Begin + --_Right.second);
			}
		}, 1);

		// cleanup _Left-over (not partitioned yet) ranges from parallel phase

		// remove empty ranges
		_LeftOver.erase(std::remove_if(_LeftOver.begin(), _LeftOver.end(), _IsPairRangeEmpty), _LeftOver.end());
		size_t _MidPoint = _Helper._Boundary();

		if (_LeftOver.empty())
			return _MidPoint;

		// move all _Left-over ranges into middle
		std::sort(_LeftOver.begin(), _LeftOver.end());
		auto _Itr = std::lower_bound(_LeftOver.begin(), _LeftOver.end(), std::make_pair(_MidPoint, _MidPoint), [](const std::pair<size_t, size_t> &_Left, const std::pair<size_t, size_t> &_Right) {
			return _Left.second < _Right.second; });

			auto _LeftPoint = _Itr == _LeftOver.end() || _Itr->first > _MidPoint ? _MidPoint : _Itr->first;
			auto _CurItr = _Itr;


			while (_CurItr != _LeftOver.begin())
			{
				--_CurItr;
				_MoveRangeImpl(_Begin, *_CurItr, _LeftPoint -= (_CurItr->second - _CurItr->first));
			}

			bool _IsCurItrCrossMiddle = _Itr != _LeftOver.end() && _Itr->first <= _MidPoint;
			auto _RightPoint = _IsCurItrCrossMiddle ? _Itr->second : _MidPoint;
			_CurItr = _IsCurItrCrossMiddle ? ++_Itr : _Itr;
			while (_CurItr != _LeftOver.end())
			{
				_RightPoint = _MoveRangeImpl(_Begin, *_CurItr, _RightPoint);
				++_CurItr;
			}

			// now all _Left-overs are at middle, we partition them again
			return std::partition(_Begin + _LeftPoint, _Begin + _RightPoint, _Pred) - _Begin;
	}


	//
	// Partition
	//
	template <typename _FwdIt, typename _Pr, class _IterCat>
	_FwdIt _Partition_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::partition(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, typename _FwdIt, typename _Pr, class _IterCat>
	_FwdIt _Partition_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		const size_t _Chunk_size = 1024;

		size_t _Size = std::distance(_First, _Last);
		const size_t _HdConc = (std::min)(static_cast<size_t>(get_hardware_concurrency()), _Size / (_Chunk_size * 2));
		if (_HdConc <= 1)
			return std::partition(_First, _Last, _Pred);
		else
			return _First + _Parallel_partition_impl(_First, _Size, _Pred, _Chunk_size, _HdConc);
	}

	// FIXME currently the forward iterator defaults to sequential execution policy
	template <class _ExPolicy, typename _FwdIt, typename _Pr>
	inline typename _enable_if_parallel<_ExPolicy, _FwdIt>::type _Partition_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, std::forward_iterator_tag _Cat)
	{
		return _Partition_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template <class _ExPolicy, typename _FwdIt, typename _Pr>
	inline typename _enable_if_parallel<_ExPolicy, _FwdIt>::type _Partition_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, std::bidirectional_iterator_tag _Cat)
	{
		return _Partition_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template <typename _FwdIt, typename _Pr, class _IterCat>
	inline _FwdIt _Partition_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Partition_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// stable_partition
	//
	template<class _BidIt, class _Pr, class _IterCat>
	inline _BidIt _Stable_partition_impl(const sequential_execution_policy&, _BidIt _First, _BidIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::stable_partition(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _BidIt, class _Pr>
	inline _BidIt _Stable_partition_impl_helper(_BidIt _First, _BidIt _Last, size_t _Count, _Pr _Pred, size_t _Div)
	{
		if (_Div < 2)
			return std::stable_partition(_First, _Last, _Pred);
		else {
			auto _Mid = _First;
			size_t _Mid_point = _Count / 2;
			_Count -= _Mid_point;

			std::advance(_Mid, _Mid_point);

			_BidIt _Right;

			auto _Handle = make_task([_Pred, _Div, _Count, _Mid, _Last, &_Right]{
				_Right = _Stable_partition_impl_helper(_Mid, _Last, _Count, _Pred, _Div / 2);
			});

			TaskGroup _Tg;
			_Tg.run(_Handle);

			auto _Left = _Stable_partition_impl_helper(_First, _Mid, _Mid_point, _Pred, _Div / 2);
			_Tg.wait();

			return std::rotate(_Left, _Mid, _Right);
		}
	}

	template<class _ExPolicy, class _BidIt, class _Pr, class _IterCat>
	inline _BidIt _Stable_partition_impl(const _ExPolicy&, _BidIt _First, _BidIt _Last, _Pr _Pred, _IterCat)
	{
		typedef std::iterator_traits<_BidIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef composable_iterator<_BidIt, std::vector<difference_type>::iterator > _Iter_type;

		if (_First != _Last) {
			auto _Size = std::distance(_First, _Last);
			return _Stable_partition_impl_helper(_First, _Last, _Size, _Pred, _Size == 1 ? 1 : get_hardware_concurrency());
		}

		return _First;
	}

	template<class _ExPolicy, class _BidIt, class _OutIt, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, _BidIt>::type _Stable_partition_impl(const _ExPolicy&, _BidIt _First, _BidIt _Last, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Stable_partition_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template<class _BidIt, class _Pr, class _IterCat>
	inline _BidIt _Stable_partition_impl(const execution_policy& _Policy, _BidIt _First, _BidIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Stable_partition_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// partition_copy
	//
	template<class _InIt, class _OutIt, class _OutIt2, class _Pr, class _IterCat>
	inline std::pair<_OutIt, _OutIt2> _Partition_copy_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _OutIt2 _Dest2, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::partition_copy(_First, _Last, _Dest, _Dest2, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _OutIt2, class _Pr, class _IterCat>
	inline std::pair<_OutIt, _OutIt2> _Partition_copy_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _OutIt2 _Dest2, _Pr _Pred, _IterCat)
	{
		typedef std::iterator_traits<_InIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef composable_iterator<_InIt, std::vector< std::pair<difference_type, difference_type> >::iterator > _Iter_type;
		typedef _Output_token_double<_OutIt, _OutIt2> _Output_token;

		if (_First != _Last) {
			auto _Size = std::distance(_First, _Last);
			std::vector<std::pair<difference_type, difference_type>> _FilterList(_Size);

			return _Partitioner<copy_partitioner_tag>::_For_Each(
				make_composable_iterator(_First, std::begin(_FilterList)), _Size, _Output_token(_Dest, _Dest2),
				[_Pred](_Iter_type _Begin, size_t _Partition_count, _Output_token& _Output) { // Filtering stage

				difference_type _Sum_true = 0;
				difference_type _Sum_false = 0;

				LoopHelper<_ExPolicy, _Iter_type>::Loop(_Begin, _Partition_count,
					[_Pred, &_Sum_true, &_Sum_false](_Iter_type::reference _It){

					auto _Filter = std::get<1>(_It);

					if (_Pred(*std::get<0>(_It))) {
						_Filter->first = _Sum_true;
						_Filter->second = _Output_token::EMPTY_POSITION;
						++_Sum_true;
					}
					else {
						_Filter->first = _Output_token::EMPTY_POSITION;
						_Filter->second = _Sum_false;
						++_Sum_false;
					}
				});

				_Output.set_position(_Sum_true, _Sum_false);
			},
				[](_Iter_type _Begin, size_t _Partition_count, _Output_token& _Dest) { // Copy stage
				auto _Out = _Dest.get();

				LoopHelper<_ExPolicy, _Iter_type>::Loop(_Begin, _Partition_count,
					[&_Out](_Iter_type::reference _It){

					auto _Filter = std::get<1>(_It);

					if (_Filter->first != _Output_token::EMPTY_POSITION) {
						*_Out.first = *std::get<0>(_It);
						++_Out.first;
					}
					else if (_Filter->second != _Output_token::EMPTY_POSITION) {
						*_Out.second = *std::get<0>(_It);
						++_Out.second;
					}
				});
			}).get_result();
		}

		return std::pair<_OutIt, _OutIt2>(_Dest, _Dest2);
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _OutIt2, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, std::pair<_OutIt, _OutIt2>>::type _Partition_copy_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _OutIt2 _Dest2, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Partition_copy_impl(seq, _First, _Last, _Dest, _Dest2, _Pred, _Cat);
	}

	template<class _InIt, class _OutIt, class _OutIt2, class _Pr, class _IterCat>
	inline std::pair<_OutIt, _OutIt2> _Partition_copy_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _OutIt2 _Dest2, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Partition_copy_impl, _Policy, _First, _Last, _Dest, _Dest2, _Pred, _Cat)
	}
} // details

template <class _ExPolicy, typename _FwdIt, typename _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type partition(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Partition_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _BidIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _BidIt>::type stable_partition(_ExPolicy&& _Policy, _BidIt _First, _BidIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::bidirectional_iterator_tag, typename std::iterator_traits<_BidIt>::iterator_category>::value, "Required bidirectional iterator or stronger.");

	return details::_Stable_partition_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _InIt, class _OutIt, class _OutIt2, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, std::pair<_OutIt, _OutIt2> >::type partition_copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _OutIt2 _Dest2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt2>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt, _OutIt2>::iterator_category _Cat;
	return details::_Partition_copy_impl(_Policy, _First, _Last, _Dest, _Dest2, _Pred, _Cat);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_PARTITION_PAR_H_
