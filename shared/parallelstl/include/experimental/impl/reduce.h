#pragma once

#ifndef _IMPL_REDUCE_H_
#define _IMPL_REDUCE_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {

	template<typename _ExPolicy, typename _IterCat>
	struct _Reduce_helper
	{
		template<typename _Ty, typename _InIt, typename _Fn>
		static _Ty Loop(_InIt _First, size_t _Count, _Fn& _UserFunc)
		{
			_Ty _Val = *_First;
			++_First;
			--_Count;

			for (size_t _I = 0; _I < _Count; ++_First, ++_I)
				_Val = _UserFunc(_Val, *_First);

			return _Val;
		}
	};

	// pragma par
	template<>
	struct _Reduce_helper < parallel_execution_policy, std::random_access_iterator_tag >
	{
		template<typename _Ty, typename _InIt, typename _Fn>
		static _Ty Loop(_InIt _First, size_t _Count, _Fn& _UserFunc)
		{
			_Ty _Val = *_First;
			++_First;
			--_Count;

			_EXP_PRAGMA_PAR
				for (size_t _I = 0; _I < _Count; ++_I)
					_Val = _UserFunc(_Val, _First[_I]);

			return _Val;
		}
	};

	// pragma par_vec
	template<>
	struct _Reduce_helper < parallel_vector_execution_policy, std::random_access_iterator_tag >
	{
		template<typename _Ty, typename _InIt, typename _Fn>
		static _Ty Loop(_InIt _First, size_t _Count, _Fn& _UserFunc)
		{
			_Ty _Val = *_First;
			++_First;
			--_Count;

#pragma loop(ivdep)
			for (size_t _I = 0; _I < _Count; ++_I)
				_Val = _UserFunc(_Val, _First[_I]);

			return _Val;
		}
	};

	//
	// reduce
	//
	template <class _InIt, class _Ty, class _BinPr, class _IterCat>
	_Ty _Reduce_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _Ty _Init, _BinPr _BinOp, _IterCat)
	{
		_EXP_TRY
			return reduce(_First, _Last, _Init, _BinOp);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _Ty, class _BinPr, class _IterCat>
	_Ty _Reduce_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Ty _Init, _BinPr _BinOp, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First == _Last)
			return _Init;

		// There is not requirement for _Ty to be default constructible thus combinable needs to be initialized with _Init value
		combinable<_Ty> _Combine([_Init]{ return _Init; });

		_Partitioner<_ExecutionPolicy>::_For_Each(_First, std::distance(_First, _Last), _BinOp,
			[&_Combine](_InIt _Begin, size_t _Count, _BinPr& _UserBinOp) {
			_Ty _Val = _Reduce_helper<_ExecutionPolicy, _IterCat>::Loop<_Ty>(_Begin, _Count, _UserBinOp);

			bool _Exists;
			auto &_Sum = _Combine.local(_Exists);
			if (_Exists)
				_Sum = _UserBinOp(_Sum, _Val);
			else _Sum = _Val;
		});

		return _BinOp(_Init, _Combine.combine(_BinOp));
	}

	template <class _ExPolicy, class _InIt, class _Ty, class _BinPr, class _IterCat>
	inline typename _enable_if_parallel<_ExPolicy, _Ty>::type _Reduce_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _Ty _Init, _BinPr _Pred, std::input_iterator_tag _Cat)
	{
		return _Reduce_impl(seq, _First, _Last, _Init, _Pred, _Cat);
	}

	template <class _InIt, class _Ty, class _BinPr, class _IterCat>
	inline _Ty _Reduce_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _Ty _Init, _BinPr _Pred, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Reduce_impl, _Policy, _First, _Last, _Init, _Pred, _Cat);
	}
}  //details

template <class _ExPolicy, class _InIt, class _Ty = std::iterator_traits<_InIt>::value_type, class _BinPr>
inline typename details::_enable_if_policy<_ExPolicy, _Ty>::type reduce(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Ty _Init, _BinPr _BinOp)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");

	return details::_Reduce_impl(_Policy, _First, _Last, _Init, _BinOp, std::_Iter_cat(_First));
}

template <class _ExPolicy, class _InIt, class _Ty = std::iterator_traits<_InIt>::value_type>
inline typename details::_enable_if_policy<_ExPolicy, _Ty>::type reduce(_ExPolicy&& _Policy, _InIt _First, _InIt _Last)
{
	return reduce(_Policy, _First, _Last, _Ty{}, std::plus<>());
}

template <class _ExPolicy, class _InIt, class _Ty = std::iterator_traits<_InIt>::value_type>
inline typename details::_enable_if_policy<_ExPolicy, _Ty>::type reduce(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _Ty _Init)
{
	return reduce(_Policy, _First, _Last, _Init, std::plus<>());
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_REDUCE_H_
