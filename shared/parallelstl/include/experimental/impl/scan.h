#pragma once

#ifndef _IMPL_SCAN_H_
#define _IMPL_SCAN_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {

	template<typename _OutIt, typename _InitType, typename _BinOp>
	class _Output_scan_token
	{
		typedef typename std::iterator_traits<_OutIt>::difference_type _DiffType;

		_OutIt _Begin;
		_DiffType _Iter_pos;
		_InitType _Local_sum;
		_InitType _Partial_sum;
		_BinOp _BinOperation;
	public:
		_Output_scan_token(_OutIt _It, _InitType _Sum, _BinOp _Op) : _Begin(_It), _Iter_pos(0), _Partial_sum(_Sum), _BinOperation(_Op)
		{
		}

		// Can be called only on one thread and set once
		void set(_DiffType _Pos, _InitType _Sum)
		{
			_Iter_pos = _Pos;
			_Local_sum = _Sum;
		}

		_OutIt get() const
		{
			return _Begin;
		}

		_InitType get_sum() const
		{
			return _Partial_sum;
		}

		_BinOp get_operation() const
		{
			return _BinOperation;
		}

		_OutIt get_result() const
		{
			_OutIt _Out = _Begin;
			std::advance(_Out, _Iter_pos);
			return _Out;
		}

		template<typename _ExPolicy, typename _InIt>
		void filter(_InIt _Begin, size_t _Partition_count)
		{
			auto _Opration = get_operation();
			_InitType _Val = *_Begin;

			LoopHelper<_ExPolicy, _InIt>::Loop(++_Begin, _Partition_count - 1,
				[&_Opration, &_Val](std::iterator_traits<_InIt>::reference _It) {
				_Val = _Opration(_Val, _It);
			});

			set(_Partition_count, _Val);
		}

		template <typename _It, typename _OutIt, typename _First_stage, typename _Second_stage> friend class _Copy_chore;
	public:
		void move(_Output_scan_token& _Token)
		{
			_Begin = _Token._Begin;
			std::advance(_Begin, _Token._Iter_pos);
			_Partial_sum = _BinOperation(_Token._Partial_sum, _Token._Local_sum);
		}

		bool empty() const
		{
			return false;
		}
	};

	//
	// exclusive_scan
	//
	template<class _InIt, class _OutIt, class _Ty, class _BinOp, class _IterCat>
	inline _OutIt _Exclusive_scan_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, _IterCat)
	{
		_EXP_TRY
			return exclusive_scan(_First, _Last, _Dest, _Init, _Op);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Ty, class _BinOp, class _IterCat>
	inline _OutIt _Exclusive_scan_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, _IterCat)
	{
		typedef std::iterator_traits<_InIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef _Output_scan_token<_OutIt, _Ty, _BinOp> _Output_token;

		if (_First == _Last)
			return _Dest;

		return _Partitioner<copy_partitioner_tag>::_For_Each(_First, std::distance(_First, _Last), _Output_token(_Dest, _Init, _Op),
			[](_InIt _Begin, size_t _Partition_count, _Output_token& _Output){
			_Output.filter<_ExPolicy>(_Begin, _Partition_count);
		},
			[](_InIt _Begin, size_t _Partition_count, _Output_token& _Dest) { // Copy stage						
			auto _Opration = _Dest.get_operation();
			auto _Out = _Dest.get();
			_Ty _Val = _Dest.get_sum();

			LoopHelper<_ExPolicy, _InIt>::Loop(_Begin, _Partition_count,
				[&_Out, &_Val, &_Opration](std::iterator_traits<_InIt>::reference _It) {
				*_Out = _Val;
				++_Out;

				_Val = _Opration(_Val, _It);
			});
		}).get_result();
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Ty, class _BinOp>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Exclusive_scan_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, std::input_iterator_tag _Cat)
	{
		return _Exclusive_scan_impl(seq, _First, _Last, _Dest, _Init, _Op, _Cat);
	}

	template<class _InIt, class _OutIt, class _Ty, class _BinOp, class _IterCat>
	inline _OutIt _Exclusive_scan_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Exclusive_scan_impl, _Policy, _First, _Last, _Dest, _Init, _Op, _Cat);
	}

	//
	// inclusive_scan
	//
	template<class _InIt, class _OutIt, class _Ty, class _BinOp, class _IterCat>
	inline _OutIt _Inclusive_scan_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, _IterCat)
	{
		_EXP_TRY
			return inclusive_scan(_First, _Last, _Dest, _Op, _Init);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Ty, class _BinOp, class _IterCat>
	inline _OutIt _Inclusive_scan_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, _IterCat)
	{
		typedef std::iterator_traits<_InIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef composable_iterator<_InIt, std::vector<difference_type>::iterator > _Iter_type;
		typedef _Output_scan_token<_OutIt, _Ty, _BinOp> _Output_token;

		if (_First == _Last)
			return _Dest;

		return _Partitioner<copy_partitioner_tag>::_For_Each(_First, std::distance(_First, _Last), _Output_token(_Dest, _Init, _Op),
			[](_InIt _Begin, size_t _Partition_count, _Output_token& _Output) { // Filtering stage						
			_Output.filter<_ExPolicy>(_Begin, _Partition_count);
		},
			[](_InIt _Begin, size_t _Partition_count, _Output_token& _Dest) { // Copy stage						
			auto _Opration = _Dest.get_operation();
			auto _Out = _Dest.get();
			_Ty _Val = _Dest.get_sum();

			LoopHelper<_ExPolicy, _InIt>::Loop(_Begin, _Partition_count,
				[&_Out, &_Val, &_Opration](std::iterator_traits<_InIt>::reference _It){
				_Val = _Opration(_Val, _It);

				*_Out = _Val;
				++_Out;
			});
		}).get_result();
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Ty, class _BinOp>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Inclusive_scan_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, std::input_iterator_tag _Cat)
	{
		return _Inclusive_scan_impl(seq, _First, _Last, _Dest, _Init, _Op, _Cat);
	}

	template<class _InIt, class _OutIt, class _Ty, class _BinOp, class _IterCat>
	inline _OutIt _Inclusive_scan_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Inclusive_scan_impl, _Policy, _First, _Last, _Dest, _Init, _Op, _Cat);
	}
} // details

template<class _ExPolicy, class _InIt, class _OutIt, class _Ty, class _BinOp>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type exclusive_scan(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init, _BinOp _Op)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Exclusive_scan_impl(_Policy, _First, _Last, _Dest, _Init, _Op, _Cat);
}

template<class _ExPolicy, class _InIt, class _OutIt, class _Ty>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type exclusive_scan(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Ty _Init)
{
	return exclusive_scan(_Policy, _First, _Last, _Dest, _Init, std::plus<>());
}

template<class _ExPolicy, class _InIt, class _OutIt, class _Ty, class _BinOp>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type inclusive_scan(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _BinOp _Op, _Ty _Init)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Inclusive_scan_impl(_Policy, _First, _Last, _Dest, _Init, _Op, _Cat);
}

template<class _ExPolicy, class _InIt, class _OutIt, class _BinOp>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type inclusive_scan(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _BinOp _Op)
{
	return inclusive_scan(_Policy, _First, _Last, _Dest, _Op, std::iterator_traits<_InIt>::value_type{});
}

template<class _ExPolicy, class _InIt, class _OutIt>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type inclusive_scan(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest)
{
	return inclusive_scan(_Policy, _First, _Last, _Dest, std::plus<>(), std::iterator_traits<_InIt>::value_type{});
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_SCAN_H_
