#pragma once

#ifndef _IMPL_MINMAX_ELEMENT_H_
#define _IMPL_MINMAX_ELEMENT_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {
	//
	// min_element
	//
	template <class _FwdIt, class _Pr, class _IterCat>
	_FwdIt _Min_element_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::min_element(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Pr, class _IterCat>
	_FwdIt _Min_element_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First != _Last)
		{
			combinable<_FwdIt> _Combine;

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, std::distance(_First, _Last), _Pred,
				[&_Combine, &_First](_FwdIt _Begin, size_t _Count, _Pr& _UserPred) {
				auto _End = _Begin;
				std::advance(_End, _Count);

				_Begin = std::min_element(_Begin, _End, _UserPred);

				bool _Exists;
				auto &_Found = _Combine.local(_Exists);
				if (!_Exists || _UserPred(*_Begin, *_Found) || (!_UserPred(*_Found, *_Begin) && std::distance(_First, _Begin) < std::distance(_First, _Found)))
					_Found = _Begin;
			});

			return _Combine.combine([&_Pred, &_First](const _FwdIt& _Val, const _FwdIt& _Current) {
				if (_Pred(*_Val, *_Current))
					return _Val;
				else if (_Pred(*_Current, *_Val))
					return _Current;

				return std::distance(_First, _Val) < std::distance(_First, _Current) ? _Val : _Current;
			});
		}

		return _First;
	}

	template <class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Min_element_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Min_element_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// max_element
	//
	template <class _FwdIt, class _Pr, class _IterCat>
	_FwdIt _Max_element_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::max_element(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Pr, class _IterCat>
	_FwdIt _Max_element_impl(const _ExPolicy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		return _Min_element_impl(_Policy, _First, _Last, [_Pred](std::iterator_traits<_FwdIt>::reference _Val, std::iterator_traits<_FwdIt>::reference _Val2) mutable {
			return _Pred(_Val2, _Val);
		}, _Cat);
	}

	template <class _FwdIt, class _Pr, class _IterCat>
	inline _FwdIt _Max_element_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Max_element_impl, _Policy, _First, _Last, _Pred, _Cat);
	}

	//
	// minmax_element
	//
	template<typename _FwdIt, typename _Pr>
	std::pair<_FwdIt, _FwdIt> _Minmax_helper(_FwdIt _First, std::pair<_FwdIt, _FwdIt> _Old, std::pair<_FwdIt, _FwdIt> _Current, _Pr _Pred)
	{
		// Check if the current element is smaller than the stored one
		// If they are equal pick the one that is closer to the beginning of the collection
		if (_Pred(*_Current.first, *_Old.first) || (!_Pred(*_Old.first, *_Current.first) && std::distance(_First, _Current.first) < std::distance(_First, _Old.first)))
			_Old.first = _Current.first;

		// Check if the current element is larger than the stored one
		// If they are equal pick the one that is closer to the end of the collection
		if (_Pred(*_Old.second, *_Current.second) || (!_Pred(*_Current.second, *_Old.second) && std::distance(_First, _Old.second) < std::distance(_First, _Current.second)))
			_Old.second = _Current.second;

		return _Old;
	}

	template <class _FwdIt, class _Pr, class _IterCat>
	std::pair<_FwdIt, _FwdIt> _Minmax_element_impl(const sequential_execution_policy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		_EXP_TRY
			return std::minmax_element(_First, _Last, _Pred);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _FwdIt, class _Pr, class _IterCat>
	std::pair<_FwdIt, _FwdIt> _Minmax_element_impl(const _ExPolicy&, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First != _Last)
		{
			combinable<std::pair<_FwdIt, _FwdIt> > _Combine;

			_Partitioner<_ExecutionPolicy>::_For_Each(_First, std::distance(_First, _Last), _Pred,
				[&_Combine, &_First](_FwdIt _Begin, size_t _Count, _Pr& _UserPred) {
				auto _End = _Begin;
				std::advance(_End, _Count);

				std::pair<_FwdIt, _FwdIt> _Found_local = std::minmax_element(_Begin, _End, _UserPred);

				bool _Exists;
				auto &_Found = _Combine.local(_Exists);
				if (!_Exists)
					_Found = _Found_local;
				else _Found = _Minmax_helper(_First, _Found, _Found_local, _UserPred);
			});

			return _Combine.combine([&_First, &_Pred](std::pair<_FwdIt, _FwdIt> _Val, std::pair<_FwdIt, _FwdIt> _Current) {
				return _Minmax_helper(_First, _Val, _Current, _Pred);
			});
		}

		return std::make_pair(_First, _First);
	}

	template <class _FwdIt, class _Pr, class _IterCat>
	inline std::pair<_FwdIt, _FwdIt> _Minmax_element_impl(const execution_policy& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Minmax_element_impl, _Policy, _First, _Last, _Pred, _Cat);
	}
} //details

template <class _ExPolicy, class _FwdIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type min_element(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Min_element_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type min_element(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last)
{
	return min_element(_Policy, _First, _Last, std::less<>());
}

template <class _ExPolicy, class _FwdIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type max_element(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Max_element_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, _FwdIt>::type max_element(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last)
{
	return max_element(_Policy, _First, _Last, std::less<>());
}

template <class _ExPolicy, class _FwdIt, class _Pr>
inline typename details::_enable_if_policy<_ExPolicy, std::pair<_FwdIt, _FwdIt> >::type minmax_element(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last, _Pr _Pred)
{
	static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<_FwdIt>::iterator_category>::value, "Required forward iterator or stronger.");

	return details::_Minmax_element_impl(_Policy, _First, _Last, _Pred, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _FwdIt>
inline typename details::_enable_if_policy<_ExPolicy, std::pair<_FwdIt, _FwdIt> >::type minmax_element(_ExPolicy&& _Policy, _FwdIt _First, _FwdIt _Last)
{
	return minmax_element(_Policy, _First, _Last, std::less<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_MINMAX_ELEMENT_H_
