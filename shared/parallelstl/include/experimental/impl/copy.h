#pragma once

#ifndef _IMPL_COPY_H_
#define _IMPL_COPY_H_ 1

#include "algorithm_impl.h"
#include "foreach.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// copy_n
	//
	template<class _InIt, class _Diff, class _OutIt, class _IterCat>
	inline _OutIt _Copy_n_impl(const sequential_execution_policy&, _InIt _First, _Diff _Count, _OutIt _Dest, _IterCat)
	{
		_EXP_TRY
			return std::copy_n(_First, _Count, _Dest);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _Diff, class _OutIt, class _IterCat>
	inline _OutIt _Copy_n_impl(const _ExPolicy& _Policy, _InIt _First, _Diff _Count, _OutIt _Dest, _IterCat _Cat)
	{
		return std::get<1>(*_For_each_n_impl(_Policy, make_composable_iterator(_First, _Dest), _Count,
			[](typename composable_iterator<_InIt, _OutIt>::reference _It){
			*std::get<1>(_It) = *std::get<0>(_It);
		}, _Cat));
	}

	template<class _ExPolicy, class _InIt, class _Diff, class _OutIt>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Copy_n_impl(const _ExPolicy&, _InIt _First, _Diff _Count, _OutIt _Dest, std::input_iterator_tag _Cat)
	{
		return _Copy_n_impl(seq, _First, _Count, _Dest, _Cat);
	}

	template<class _InIt, class _Diff, class _OutIt, class _IterCat>
	inline _OutIt _Copy_n_impl(const execution_policy& _Policy, _InIt _First, _Diff _Count, _OutIt _Dest, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Copy_n_impl, _Policy, _First, _Count, _Dest, _Cat);
	}

	//
	// copy
	//
	template<class _InIt, class _OutIt, class _IterCat>
	inline _OutIt _Copy_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _IterCat)
	{
		_EXP_TRY
			return std::copy(_First, _Last, _Dest);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _IterCat>
	inline _OutIt _Copy_impl(const _ExPolicy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _IterCat _Cat)
	{
		return _Copy_n_impl(_Policy, _First, std::distance(_First, _Last), _Dest, _Cat);
	}

	template<class _ExPolicy, class _InIt, class _OutIt>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Copy_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, std::input_iterator_tag _Cat)
	{
		return _Copy_impl(seq, _First, _Last, _Dest, _Cat);
	}

	template<class _InIt, class _OutIt, class _IterCat>
	inline _OutIt _Copy_impl(const execution_policy& _Policy, _InIt _First, _InIt _Count, _OutIt _Dest, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Copy_impl, _Policy, _First, _Count, _Dest, _Cat);
	}

	//
	// copy_if
	//
	template<class _InIt, class _OutIt, class _Pr, class _IterCat>
	inline _OutIt _Copy_if_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::copy_if(_First, _Last, _Dest, _Pred);
		_EXP_RETHROW
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Pr, class _IterCat>
	inline _OutIt _Copy_if_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, _IterCat)
	{
		typedef std::iterator_traits<_InIt>::difference_type difference_type;
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;
		typedef composable_iterator<_InIt, std::vector<difference_type>::iterator > _Iter_type;
		typedef _Output_token<_OutIt> _Output_token;

		if (_First == _Last)
			return _Dest;

		auto _Size = std::distance(_First, _Last);
		std::vector<difference_type> _Filter(_Size);

		return _Partitioner<copy_partitioner_tag>::_For_Each(make_composable_iterator(_First, std::begin(_Filter)), _Size, _Output_token(_Dest),
			[_Pred](_Iter_type _Begin, size_t _Partition_count, _Output_token& _Output) mutable { // Filtering stage

			difference_type _Sum = 0;
			LoopHelper<_ExPolicy, _Iter_type>::Loop(_Begin, _Partition_count,
				[&_Pred, &_Sum](_Iter_type::reference _It){

				if (_Pred(*std::get<0>(_It))) {
					*std::get<1>(_It) = _Sum;
					++_Sum;
				}
				else *std::get<1>(_It) = _Output_token::EMPTY_POSITION;
			});

			_Output.set_position(_Sum);
		},
			[](_Iter_type _Begin, size_t _Partition_count, _Output_token& _Dest) { // Copy stage
			auto _Out = _Dest.get();

			LoopHelper<_ExPolicy, _Iter_type>::Loop(_Begin, _Partition_count,
				[&_Out](_Iter_type::reference _It){

				if (*std::get<1>(_It) != _Output_token::EMPTY_POSITION) {
					*_Out = *std::get<0>(_It);
					++_Out;
				}
			});
		}).get_result();
	}

	template<class _ExPolicy, class _InIt, class _OutIt, class _Pr>
	inline typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Copy_if_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, std::input_iterator_tag _Cat)
	{
		return _Copy_if_impl(seq, _First, _Last, _Dest, _Pred, _Cat);
	}

	template<class _InIt, class _OutIt, class _Pr, class _IterCat>
	inline _OutIt _Copy_if_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Copy_if_impl, _Policy, _First, _Last, _Dest, _Pred, _Cat);
	}
} // details

template<class _ExPolicy, class _InIt, class _Diff, class _OutIt>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type copy_n(_ExPolicy&& _Policy, _InIt _First, _Diff _Count, _OutIt _Dest)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Copy_n_impl(_Policy, _First, _Count, _Dest, _Cat);
}

template<class _ExPolicy, class _InIt, class _OutIt>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type copy(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Copy_impl(_Policy, _First, _Last, _Dest, _Cat);
}

template<class _ExPolicy, class _InIt, class _OutIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type copy_if(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Pr _Pred)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Copy_if_impl(_Policy, _First, _Last, _Dest, _Pred, _Cat);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_COPY_H_
