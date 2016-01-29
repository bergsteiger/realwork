#pragma once

#ifndef _IMPL_UNIQUE_H_
#define _IMPL_UNIQUE_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {

	template<class _PartitionerTag, class _ExPolicy, class _InIt, class _OutIt, class _Pr, class _Op>
	inline _OutIt _Unique_copy_impl_helper(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, _Op _Operation)
	{
		typedef std::iterator_traits<_InIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef _Output_token<_OutIt> _Output_token;
		//typedef composable_iterator<_InIt, std::vector<difference_type>::iterator > _Iter_type;
		typedef composable_iterator_base < typename common_iterator<_InIt, std::vector<difference_type>::iterator >::iterator_category,
			_InIt, std::vector<difference_type>::iterator > _Iter_type;

		if (_First == _Last)
			return _Dest;

		auto _Size = std::distance(_First, _Last);
		std::vector<difference_type> _Filter(_Size);

		// First element is always unique
		*_Dest = *_First;
		++_Dest;

		return _Partitioner<_PartitionerTag>::_For_Each(make_composable_iterator(_First, std::begin(_Filter)), _Size - 1, _Output_token(_Dest),
			[_Pred](_Iter_type _Begin, size_t _Partition_count, _Output_token& _Output) mutable { // Filtering stage
			difference_type _Sum = 0;
			_InIt _Unique = std::get<0>(*_Begin);

			LoopHelper<_ExPolicy, _Iter_type>::Loop(++_Begin, _Partition_count,
				[&_Pred, &_Unique, &_Sum](_Iter_type::reference _It){
				if (!_Pred(*_Unique, *std::get<0>(_It))) {
					_Unique = std::get<0>(_It);
					*std::get<1>(_It) = _Sum;
					++_Sum;
				}
				else *std::get<1>(_It) = _Output_token::EMPTY_POSITION;
			});

			_Output.set_position(_Sum);
		},
			[&_Operation](_Iter_type _Begin, size_t _Partition_count, _Output_token& _Dest) { // Copy stage
			auto _Out = _Dest.get();

			// The first element is always copied by the previous worker
			LoopHelper<_ExPolicy, _Iter_type>::Loop(++_Begin, _Partition_count,
				[&_Out, &_Operation](_Iter_type::reference _It){

				if (*std::get<1>(_It) != _Output_token::EMPTY_POSITION) {
					*_Out = _Operation(std::get<0>(_It));
					++_Out;
				}
			});
		}).get_result();
	}

	//
	// unique_copy
	//
	template<class _InIt, class _OutIt, class _Pr, class _IterCat>
	inline _OutIt _Unique_copy_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::unique_copy(_First, _Last, _Dest, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Pr, class _IterCat>
	inline _OutIt _Unique_copy_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, _IterCat)
	{
		return _Unique_copy_impl_helper<copy_partitioner_tag>(_Policy, _First, _Last, _Dest, _Pred, [](_InIt _It){ return *_It; });
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Unique_copy_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Unique_copy_impl(seq, _First, _Last, _Dest, _Pred, _Cat);
	}

	template<class _InIt, class _OutIt, class _Pr, class _IterCat>
	inline _OutIt _Unique_copy_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Unique_copy_impl, _Policy, _First, _Last, _Dest, _Pred, _Cat);
	}

	//
	// unique
	//
	template<class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Unique_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::unique(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Unique_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		// Call unique copy helper because parallel version of it allow only one writer while using remove_partitioner_tag
		return _Unique_copy_impl_helper<remove_partitioner_tag>(_Policy, _First, _Last, _First, _Pred, [](_FwdIt _It){ return std::move(*_It); });
	}

	template<class _ExPolicy, class _FwdIt, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, _FwdIt>::type _Unique_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Unique_impl(seq, _First, _Last, _Dest, _Pred, _Cat);
	}

	template<class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Unique_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Unique_impl, _Policy, _First, _Last, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _FwdIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type unique(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Unique_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template<class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type unique(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last)
{
	return unique(_Policy, _First, _Last, std::equal_to<>());
}

template<class _ExPolicy, class _InIt, class _OutIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type unique_copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Unique_copy_impl(_Policy, _First, _Last, _Dest, _Pred, _Cat);
}

template<class _ExPolicy, class _InIt, class _OutIt>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type unique_copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest)
{
	return unique_copy(_Policy, _First, _Last, _Dest, std::equal_to<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_UNIQUE_H_
