#pragma once

#ifndef _IMPL_SORT_PAR_H_
#define _IMPL_SORT_PAR_H_ 1

#include <stdexcept>
#include <iterator>
#include <functional>
#include <type_traits>
#include <algorithm>

#include "taskgroup.h"
#include "reduce.h"

_PSTL_NS1_BEGIN
namespace details
{
	// This number is used to control dynamic task splitting
	// The ideal chunk (task) division is that the number of cores is equal to the number of tasks, but it will 
	// perform very poorly when tasks are not balanced. The simple solution is to allocate more tasks than number 
	// of cores. _SortMaxTasksPerCore provides a maximum number of tasks that will be allocated per core.
	// If this number is too small, the load balancing problem will affect efficiency very seriously, especially
	// when the compare operation is expensive.
	//
	// Note that this number is a maximum number -- the dynamic partition system will reduce the number of partitions
	// per core based on the dynamic load. If all cores are very busy, the number of partitions will shrink to 
	// reduce the scheduler overhead.
	//
	// Initially, the total tasks(chunks) number of partitions "_Div_num" will be: core number * _SortMaxTasksPerCore.
	// The _Div_num will be divided by 2 after each task splitting. There are two special numbers for _Div_num:
	//     1. When _Div_num reaches the point that _Div_num < _SortMaxTasksPerCore, it means we have split more tasks than cores.
	//     2. When _Div_num reaches the point that _Div_num <= 1, it means stop splitting more tasks and begin sorting serially.
	const int _SortMaxTasksPerCore = 1024;

	// This is a number mainly is used to control the sampling and dynamic task splitting strategies.
	// If the user configurable minimal divisible chunk size (default is 2048) is smaller than FINE_GRAIN_CHUNK_SIZE,
	// the random sampling algorithm for quicksort will enter fine-grained mode, and take a strategy that reduces the sampling 
	// overhead. Also, the dynamic task splitting will enter fine-grained mode, which will split as many tasks as possible.
	const int _SortChunkSize = 512;

	// This is the maximum depth that the quicksort will be called recursively. If we allow too far, a stack overflow may occur.
	const int _SortMaxRecursionDepth = 64;

	template<typename _Random_iterator, typename _Function>
	inline size_t _Median_of_three(const _Random_iterator &_Begin, size_t _A, size_t _B, size_t _C, _Function &_Func, bool &_Potentially_equal)
	{
		_Potentially_equal = false;
		if (_Func(_Begin[_A], _Begin[_B]))
		{
			if (_Func(_Begin[_A], _Begin[_C]))
			{
				return _Func(_Begin[_B], _Begin[_C]) ? _B : _C;
			}
			else
			{
				return _A;
			}
		}
		else
		{
			if (_Func(_Begin[_B], _Begin[_C]))
			{
				return _Func(_Begin[_A], _Begin[_C]) ? _A : _C;
			}
			else
			{
				_Potentially_equal = true;
				return _B;
			}
		}
	}

	template<typename _Random_iterator, typename _Function>
	inline size_t _Median_of_nine(const _Random_iterator &_Begin, size_t _Size, _Function &_Func, bool &_Potentially_equal)
	{
		size_t _Offset = _Size / 8;
		size_t _A = _Median_of_three(_Begin, 0, _Offset, _Offset * 2, _Func, _Potentially_equal),
			_B = _Median_of_three(_Begin, _Offset * 3, _Offset * 4, _Offset * 5, _Func, _Potentially_equal),
			_C = _Median_of_three(_Begin, _Offset * 6, _Offset * 7, _Size - 1, _Func, _Potentially_equal);
		_B = _Median_of_three(_Begin, _A, _B, _C, _Func, _Potentially_equal);

		if (_Potentially_equal)
		{
			_Potentially_equal = !_Func(_Begin[_C], _Begin[_A]);
		}

		return _B;
	}

	// _Potentially_equal means that potentially all the values in the buffer are equal to the pivot value
	template<typename _Random_iterator, typename _Function>
	inline size_t _Select_median_pivot(const _Random_iterator &_Begin, size_t _Size, _Function &_Func, const size_t _Chunk_size, bool &_Potentially_equal)
	{
		// Base on different chunk size, apply different sampling optimization
		if (_Chunk_size < _SortChunkSize && _Size <= std::max<size_t>(_Chunk_size * 4, static_cast<size_t>(15)))
		{
			bool _Never_care_equal;
			return _Median_of_three(_Begin, 0, _Size / 2, _Size - 1, _Func, _Never_care_equal);
		}
		else
		{
			return _Median_of_nine(_Begin, _Size, _Func, _Potentially_equal);
		}
	}

	template<typename _Random_iterator, typename _Function>
	void _Parallel_quicksort_impl(const _Random_iterator &_Begin, size_t _Size, _Function &_Func, size_t _Div_num, const size_t _Chunk_size, int _Depth)
	{
		if (_Depth >= _SortMaxRecursionDepth || _Size <= _Chunk_size || _Size <= static_cast<size_t>(3) || _Chunk_size >= _SortChunkSize && _Div_num <= 1)
		{
			return std::sort(_Begin, _Begin + _Size, _Func);
		}

		// Determine whether we need to do a three-way quick sort
		// We benefit from three-way merge if there are a lot of elements that are EQUAL to the median value,
		// _Select_median_pivot function will test redundant density by sampling
		bool _Is_three_way_split = false;
		size_t _Mid_index = _Select_median_pivot(_Begin, _Size, _Func, _Chunk_size, _Is_three_way_split);

		// Move the median value to the _Begin position.
		if (_Mid_index)
		{
			std::swap(*_Begin, _Begin[_Mid_index]);
		}
		size_t _I = 1, _J = _Size - 1;

		// Three-way or two-way partition
		// _Div_num < _SortMaxTasksPerCore is checked to make sure it will never do three-way split before splitting enough tasks
		if (_Is_three_way_split && _Div_num < _SortMaxTasksPerCore)
		{
			while (_Func(*_Begin, _Begin[_J]))
			{
				--_J;
			}

			while (_Func(_Begin[_I], *_Begin))
			{
				++_I;
			}

			// Starting from this point, left side of _I will less than median value, right side of _J will be greater than median value, 
			// and the middle part will be equal to median. _K is used to scan between _I and _J
			size_t _K = _J;
			while (_I <= _K)
			{
				if (_Func(_Begin[_K], *_Begin))
				{
					std::swap(_Begin[_I++], _Begin[_K]);
				}
				else
				{
					--_K;
				}

				while (_Func(*_Begin, _Begin[_K]))
				{
					std::swap(_Begin[_K--], _Begin[_J--]);
				}
			}

			++_J;
		}
		else
		{
			while (_I <= _J)
			{
				// Will stop before _Begin
				while (_Func(*_Begin, _Begin[_J]))
				{
					--_J;
				}

				// There must be another element equal or greater than *_Begin
				while (_Func(_Begin[_I], *_Begin))
				{
					++_I;
				}

				if (_I < _J)
				{
					std::swap(_Begin[_I++], _Begin[_J--]);
				}
				else
				{
					break;
				}
			}

			_I = ++_J;
		}

		std::swap(*_Begin, _Begin[--_I]);

		TaskGroup _Tg;
		volatile size_t _Next_div = _Div_num / 2;
		auto _Handle = make_task([&]
		{
			_Parallel_quicksort_impl(_Begin + _J, _Size - _J, _Func, _Next_div, _Chunk_size, _Depth + 1);
		});
		_Tg.run(_Handle);

		_Parallel_quicksort_impl(_Begin, _I, _Func, _Next_div, _Chunk_size, _Depth + 1);

		// If at this point, the work hasn't been scheduled, then slow down creating new tasks
		if (_Div_num < _SortMaxTasksPerCore)
		{
			_Next_div /= 2;
		}

		_Tg.wait();
	}

	template<typename RandomIterator, typename Function>
	void parallel_partialsort_impl(const RandomIterator &begin, size_t sortSize, size_t size, Function &func, size_t _Div_num, const size_t chunkSize, int depth)
	{
		_ASSERT(sortSize <= size && sortSize > 0);

		// For special cases
		if (depth >= _SortMaxRecursionDepth || size <= chunkSize || size <= static_cast<size_t>(3))
			return std::partial_sort(begin, begin + sortSize, begin + size, func);

		if (sortSize == size)
			_Parallel_quicksort_impl(begin, size, func, _Div_num, chunkSize, depth);
		else if (size - sortSize == 1)
		{
			std::iter_swap(max_element(par, begin, begin + size, func), begin + (size - 1));
			_Parallel_quicksort_impl(begin, size - 1, func, _Div_num, chunkSize, depth);
		}
		else if (sortSize == 1)
			std::iter_swap(min_element(par, begin, begin + size, func), begin);

		// Go for general case
		bool isThreeWay = false;
		size_t midIndex = _Select_median_pivot(begin, size, func, chunkSize, isThreeWay);
		std::swap(*begin, begin[midIndex]);
		typedef typename std::iterator_traits<RandomIterator>::value_type ValueType;
		auto midItr = std::partition(begin + 1, begin + size, [&](const ValueType & item) {
			return func(item, *begin);
		});
		size_t equalRange = 1;
		if (midItr == begin + 1)
		{
			if (isThreeWay)
			{
				for (size_t i = 1; i < size; i++)
				{
					if (!func(*begin, begin[i]))
					{
						std::swap(*midItr++, begin[i]);
						++equalRange;
					}
				}
			}
		}
		else
			std::iter_swap(begin, midItr - 1);

		TaskGroup tg;
		size_t firstRangeSize = midItr - begin;
		if (firstRangeSize <= sortSize)
		{
#pragma warning(push)
			// nonstandard extension used : 'argument' : conversion from 
#pragma warning(disable: 4239)
			tg.run(make_task([&] {
				_Parallel_quicksort_impl(begin, firstRangeSize, func, _Div_num, chunkSize, depth + 1);
			}));
#pragma warning(pop)

			if (firstRangeSize < sortSize)
				parallel_partialsort_impl(midItr, sortSize - firstRangeSize, size - firstRangeSize, func, _Div_num / 2, chunkSize, depth + 1);
			tg.wait();
		}
		else if ((firstRangeSize -= equalRange) <= sortSize)
			_Parallel_quicksort_impl(begin, sortSize, func, _Div_num, chunkSize, depth + 1);
		else
			parallel_partialsort_impl(begin, sortSize, firstRangeSize, func, _Div_num / 2, chunkSize, depth + 1);
	}

	// This function will be called to sort the elements in the "_Begin" buffer. However, we can't tell whether the result will end up in buffer
	// "_Begin", or buffer "_Output" when it returned. The return value is designed to indicate which buffer holds the sorted result.
	// Return true if the merge result is in the "_Begin" buffer; return false if the result is in the "_Output" buffer.
	// We can't always put the result into one assigned buffer because that may cause frequent buffer copies at return time.
	template<typename _Random_iterator, typename _Random_buffer_iterator, typename _Function>
	inline bool _Parallel_buffered_sort_impl(const _Random_iterator &_Begin, size_t _Size, _Random_buffer_iterator _Output, _Function &_Func,
		int _Div_num, const size_t _Chunk_size)
	{
		static_assert(std::is_same<typename std::iterator_traits<_Random_iterator>::value_type, typename std::iterator_traits<_Random_buffer_iterator>::value_type>::value,
			"same value type expected");

		if (_Div_num <= 1 || _Size <= _Chunk_size)
		{
			std::stable_sort(_Begin, _Begin + _Size, _Func);

			// In case _Size <= _Chunk_size happened BEFORE the planned stop time (when _Div_num == 1) we need to calculate how many turns of 
			// binary divisions are left. If there are an odd number of turns left, then the buffer move is necessary to make sure the final 
			// merge result will be in the original input array.
			int _Left_div_turns = 0;
			while (_Div_num >>= 1)
			{
				_Left_div_turns++;
			}

			if (_Left_div_turns & 1)
			{
				std::move(_Begin, _Begin + _Size, _Output);
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			size_t _Mid = _Size / 2;
			TaskGroup _Tg;

			auto _Handle = make_task([&, _Chunk_size]
			{
				_Parallel_buffered_sort_impl(_Begin, _Mid, _Output, _Func, _Div_num / 2, _Chunk_size);
			});
			_Tg.run(_Handle);

			bool _Is_buffer_swap = _Parallel_buffered_sort_impl(_Begin + _Mid, _Size - _Mid, _Output + _Mid, _Func, _Div_num / 2, _Chunk_size);

			_Tg.wait();

			if (_Is_buffer_swap)
			{
				_Parallel_merge(_Output, _Mid, _Output + _Mid, _Size - _Mid, _Begin, _Func, _Div_num);
			}
			else
			{
				_Parallel_merge(_Begin, _Mid, _Begin + _Mid, _Size - _Mid, _Output, _Func, _Div_num);
			}

			return !_Is_buffer_swap;
		}
	}

	//
	// Sort
	//
	template<typename _RanIt, typename _Pr, class _IterCat>
	inline void _Sort_impl(const sequential_execution_policy&, _RanIt _First, _RanIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			std::sort(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, typename _FwdIt, typename _Pr, class _IterCat>
	inline typename _enable_if_parallel<_ExPolicy, void>::type _Sort_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		// Check for cancellation before the algorithm starts.
		size_t _Size = _Last - _First;
		size_t _Core_num = get_hardware_concurrency();
		const size_t _ChunkSize = 2048; // Default chunk size

		if (_Size <= _ChunkSize || _Core_num < 2)
		{
			return std::sort(_First, _Last, _Pred);
		}

		_Parallel_quicksort_impl(_First, _Size, _Pred, _Core_num * _SortMaxTasksPerCore, _ChunkSize, 0);
	}

	template<typename _RanIt, typename _Pr, class _IterCat>
	inline void _Sort_impl(const execution_policy& _Policy, _RanIt _First, _RanIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Sort_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// partial_sort
	//
	template<typename _RanIt, typename _Pr, class _IterCat>
	inline void _Partial_sort_impl(const sequential_execution_policy&, _RanIt _First, _RanIt _Mid, _RanIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			std::partial_sort(_First, _Mid, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, typename _RanIt, typename _Pr, class _IterCat>
	inline typename _enable_if_parallel<_ExPolicy, void>::type _Partial_sort_impl(const _ExPolicy&, _RanIt _First, _RanIt _Mid, _RanIt _Last, _Pr _Pred, _IterCat)
	{
		// Check for cancellation before the algorithm starts.
		const size_t _ChunkSize = 2048; // Default chunk size
		size_t _Core_num = get_hardware_concurrency();
		size_t _Size = _Last - _First;

		// Don't need to do anything if the sort range is empty
		if (_Mid == _First)
			return;

		if (_Size <= _ChunkSize || _Core_num < 2)
		{
			return std::partial_sort(_First, _Mid, _Last, _Pred);
		}

		parallel_partialsort_impl(_First, _Mid - _First, _Size, _Pred, _Core_num * _SortMaxTasksPerCore, _ChunkSize, 0);
	}

	template<typename _RanIt, typename _Pr, class _IterCat>
	inline void _Partial_sort_impl(const execution_policy& _Policy, _RanIt _First, _RanIt _Mid, _RanIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Partial_sort_impl, _Policy, _First, _Mid, _Last, _Pred, _Cat)
	}

	//
	// stable_sort
	//
	template<class _RanIt, class _Pr, class _IterCat>
	inline void _Stable_sort_impl(const sequential_execution_policy&, _RanIt _First, _RanIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			std::stable_sort(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _RanIt, class _Pr, class _IterCat>
	inline void _Stable_sort_impl(const _ExPolicy&, _RanIt _First, _RanIt _Last, _Pr _Pred, _IterCat)
	{
		// Check cancellation before the algorithm starts.
		size_t _Size = _Last - _First;
		size_t _Core_num = get_hardware_concurrency();
		const size_t _Chunk_size = 2048;

		if (_Size <= _Chunk_size || _Core_num < 2)
		{
			return std::stable_sort(_First, _Last, _Pred);
		}
		const static size_t CORE_NUM_MASK = 0x55555555;

		// 4 times overload on each core
		_Core_num *= 4;

		auto _Holder = std::make_unique<typename std::iterator_traits<_RanIt>::value_type []>(_Size);

		// This buffered sort algorithm will divide chunks and apply parallel quicksort on each chunk. In the end, it will 
		// apply parallel merge to these sorted chunks.
		// 
		// We need to decide on the number of chunks to divide the input buffer into. If we divide it into n chunks, log(n) 
		// merges will be needed to get the final sorted result. In this algorithm, we have two buffers for each merge 
		// operation, let's say buffer A and B. Buffer A is the original input array, buffer B is the additional allocated 
		// buffer. Each turn's merge will put the merge result into the other buffer; for example, if we decided to split 
		// into 8 chunks in buffer A at very beginning, after one pass of merging, there will be 4 chunks in buffer B.
		// If we apply one more pass of merging, there will be 2 chunks in buffer A again.
		// 
		// The problem is we want to the final merge pass to put the result back in buffer A, so that we don't need 
		// one extra copy to put the sorted data back to buffer A.
		// To make sure the final result is in buffer A (original input array), we need an even number of merge passes,
		// which means log(n) must be an even number. Thus n must be a number power(2, even number). For example, when the
		// even number is 2, n is power(2, 2) = 4, when even number is 4, n is power(2, 4) = 16. When we divide chunks 
		// into these numbers, the final merge result will be in the original input array. Now we need to decide the chunk(split) 
		// number based on this property and the number of cores.
		// 
		// We want to get a chunk (split) number close to the core number (or a little more than the number of cores), 
		// and it also needs to satisfy above property. For a 8 core machine, the best chunk number should be 16, because it's 
		// the smallest number that satisfies the above property and is bigger than the core number (so that we can utilize all 
		// cores, a little more than core number is OK, we need to split more tasks anyway). 
		// 
		// In this algorithm, we will make this alignment by bit operations (it's easy and clear). For a binary representation, 
		// all the numbers that satisfy power(2, even number) will be 1, 100, 10000, 1000000, 100000000 ...
		// After OR-ing these numbers together, we will get a mask (... 0101 0101 0101) which is all possible combinations of 
		// power(2, even number). We use _Core_num & CORE_NUM_MASK | _Core_num << 1 & CORE_NUM_MASK, a bit-wise operation to align 
		// _Core_num's highest bit into a power(2, even number).
		// 
		// It means if _Core_num = 8, the highest bit in binary is bin(1000) which is not power(2, even number). After this 
		// bit-wise operation, it will align to bin(10000) = 16 which is power(2, even number). If the _Core_num = 16, after 
		// alignment it still returns 16. The trick is to make sure the highest bit of _Core_num will align to the "1" bit of the 
		// mask bin(... 0101 0101 0101) We don't care about the other bits on the aligned result except the highest bit, because they 
		// will be ignored in the function.
		_Parallel_buffered_sort_impl(_First, _Size, stdext::make_unchecked_array_iterator(_Holder.get()),
			_Pred, _Core_num & CORE_NUM_MASK | _Core_num << 1 & CORE_NUM_MASK, _Chunk_size);
	}

	template<class _ExPolicy, class _RanIt, class _Pr>
	inline void _Stable_sort_impl(const _ExPolicy&, _RanIt _First, _RanIt _Last, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		_Stable_sort_impl(seq, _First, _Last, _Pred, _Cat);
	}

	template<class _RanIt, class _Pr, class _IterCat>
	inline void _Stable_sort_impl(const execution_policy& _Policy, _RanIt _First, _RanIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Stable_sort_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// partial_sort_copy
	//
	// partial_sort_copy always fallback to sequential since heap_sort is not able to be parallelized
	template<class _ExPolicy, class _InIt, class _RanIt, class _Pr>
	inline _RanIt _Partial_sort_copy_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _RanIt _First2, _RanIt _Last2, _Pr _Pred)
	{
		_EXP_TRY
			return std::partial_sort_copy(_First, _Last, _First2, _Last2, _Pred);
		_EXP_RETHROW
	}

	template<class _InIt, class _RanIt, class _Pr>
	inline _RanIt _Partial_sort_copy_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _RanIt _First2, _RanIt _Last2, _Pr _Pred)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Partial_sort_copy_impl, _Policy, _First, _Last, _First2, _Last2, _Pred);
	}
}  //details

template<class _ExPolicy, class _RanIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, void>::type sort(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::random_access_iterator_tag, typename std::iterator_traits<_RanIt>::iterator_category>::value, "Required random access iterator.");

	details::_Sort_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _RanIt>
inline typename details::_enable_if_policy<_ExPolicy, void>::type sort(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Last)
{
	sort(std::forward<_ExPolicy>(_Policy), _First, _Last, std::less<>());
}

template<class _ExPolicy, class _RanIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, void>::type partial_sort(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Mid, _RanIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::random_access_iterator_tag, typename std::iterator_traits<_RanIt>::iterator_category>::value, "Required random access iterator.");

	details::_Partial_sort_impl(_Policy, _First, _Mid, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _RanIt>
inline typename details::_enable_if_policy<_ExPolicy, void>::type partial_sort(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Mid, _RanIt _Last)
{
	partial_sort(std::forward<_ExPolicy>(_Policy), _First, _Mid, _Last, std::less<>());
}

template<class _ExPolicy, class _RanIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, void>::type stable_sort(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::random_access_iterator_tag, typename std::iterator_traits<_RanIt>::iterator_category>::value, "Required random access iterator.");

	details::_Stable_sort_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _RanIt>
inline typename details::_enable_if_policy<_ExPolicy, void>::type stable_sort(_ExPolicy&& _Policy, _RanIt _First, _RanIt _Last)
{
	static_assert(std::is_base_of<std::random_access_iterator_tag, typename std::iterator_traits<_RanIt>::iterator_category>::value, "Required random access iterator.");

	stable_sort(std::forward<_ExPolicy>(_Policy), _First, _Last, std::less<>());
}

template<class _ExPolicy, class _InIt, class _RanIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _RanIt>::type partial_sort_copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _RanIt _First2, _RanIt _Last2, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::random_access_iterator_tag, typename std::iterator_traits<_RanIt>::iterator_category>::value, "Required random access iterator.");

	return details::_Partial_sort_copy_impl(_Policy, _First, _Last, _First2, _Last2, _Pred);
}

template<class _ExPolicy, class _InIt, class _RanIt>
inline typename details::_enable_if_policy<_ExPolicy, _RanIt>::type partial_sort_copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _RanIt _First2, _RanIt _Last2)
{
	return partial_sort_copy(std::forward<_ExPolicy>(_Policy), _First, _Last, _First2, _Last2, std::less<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_SORT_PAR_H_
