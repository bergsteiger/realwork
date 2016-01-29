#pragma once

#ifndef _IMPL_TRANSFORM_H_
#define _IMPL_TRANSFORM_H_ 1

#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details {

	template<typename _ExPolicy, typename _IterCat>
	struct _Transform_helper
	{
		template<typename _InIt, typename _InIt2, typename _OutIt, typename _Fn>
		static void Loop(_InIt _First, size_t _Count, _InIt2 _First2, _OutIt _Dest, _Fn& _UserFunc)
		{
			for (size_t _I = 0; _I < _Count; ++_First, ++_First2, ++_Dest, ++_I)
				*_Dest = _UserFunc(*_First, *_First2);
		}

		template<typename _InIt, typename _OutIt, typename _Fn>
		static void Loop(_InIt _First, size_t _Count, _OutIt _Dest, _Fn& _UserFunc)
		{
			for (size_t _I = 0; _I < _Count; ++_First, ++_Dest, ++_I)
				*_Dest = _UserFunc(*_First);
		}
	};

	// pragma par
	template<>
	struct _Transform_helper < parallel_execution_policy, std::random_access_iterator_tag >
	{
		template<typename _InIt, typename _InIt2, typename _OutIt, typename _Fn>
		static void Loop(_InIt _First, size_t _Count, _InIt2 _First2, _OutIt _Dest, _Fn& _UserFunc)
		{
			_EXP_PRAGMA_PAR
				for (size_t _I = 0; _I < _Count; ++_I)
					_Dest[_I] = _UserFunc(_First[_I], _First2[_I]);
		}

		template<typename _InIt, typename _OutIt, typename _Fn>
		static void Loop(_InIt _First, size_t _Count, _OutIt _Dest, _Fn& _UserFunc)
		{
			_EXP_PRAGMA_PAR
				for (size_t _I = 0; _I < _Count; ++_I)
					_Dest[_I] = _UserFunc(_First[_I]);
		}
	};

	// pragma par_vec
	template<>
	struct _Transform_helper < parallel_vector_execution_policy, std::random_access_iterator_tag >
	{
		template<typename _InIt, typename _InIt2, typename _OutIt, typename _Fn>
		static void Loop(_InIt _First, size_t _Count, _InIt2 _First2, _OutIt _Dest, _Fn& _UserFunc)
		{
			VecLoopHelper2(_First, _Count, _First2, _Dest, _UserFunc, std::integral_constant<bool, _Contiguous_container_iterator_traits<_InIt>::value && _Contiguous_container_iterator_traits<_InIt2>::value && _Contiguous_container_iterator_traits<_OutIt>::value>());
		}

		template<typename _InIt, typename _InIt2, typename _OutIt, typename _Fn>
		static void VecLoopHelper2(_InIt _First, size_t _Count, _InIt2 _First2, _OutIt _Dest, _Fn& _UserFunc, std::true_type) // with contiguous iterator
		{
			if (_Count == 0)
				return;
			typename std::iterator_traits<_InIt>::pointer _FirstP = std::addressof(*_First);
			typename std::iterator_traits<_InIt>::pointer _First2P = std::addressof(*_First2);
			typename std::iterator_traits<_OutIt>::pointer _DestP = std::addressof(*_Dest);
			_EXP_PRAGMA_VEC
				for (size_t _I = 0; _I < _Count; ++_I)
					_DestP[_I] = _UserFunc(_FirstP[_I], _First2P[_I]);
		}

		template<typename _InIt, typename _InIt2, typename _OutIt, typename _Fn>
		static void VecLoopHelper2(_InIt _First, size_t _Count, _InIt2 _First2, _OutIt _Dest, _Fn& _UserFunc, std::false_type)
		{
			_EXP_PRAGMA_VEC
				for (size_t _I = 0; _I < _Count; ++_I)
					_Dest[_I] = _UserFunc(_First[_I], _First2[_I]);
		}

		template<typename _InIt, typename _OutIt, typename _Fn>
		static void Loop(_InIt _First, size_t _Count, _OutIt _Dest, _Fn& _UserFunc)
		{
			VecLoopHelper1(_First, _Count, _Dest, _UserFunc,
				std::integral_constant<bool, _Contiguous_container_iterator_traits<_InIt>::value && _Contiguous_container_iterator_traits<_OutIt>::value>());
		}

		template<typename _InIt, typename _OutIt, typename _Fn>
		static void VecLoopHelper1(_InIt _First, size_t _Count, _OutIt _Dest, _Fn& _UserFunc, std::true_type) // with contiguous iterator
		{
			if (_Count == 0)
				return;
			// We are doing this for helping compiler vectorize loops. Vectorizer likes raw pointer more.
			typename std::iterator_traits<_InIt>::pointer _FirstP = std::addressof(*_First);
			typename std::iterator_traits<_OutIt>::pointer _DestP = std::addressof(*_Dest);
			_EXP_PRAGMA_VEC
				for (size_t _I = 0; _I < _Count; ++_I)
					_DestP[_I] = _UserFunc(_FirstP[_I]);
		}

		template<typename _InIt, typename _OutIt, typename _Fn>
		static void VecLoopHelper1(_InIt _First, size_t _Count, _OutIt _Dest, _Fn& _UserFunc, std::false_type)
		{
			_EXP_PRAGMA_VEC
				for (size_t _I = 0; _I < _Count; ++_I)
					_Dest[_I] = _UserFunc(_First[_I]);
		}

	};

	//
	// transform
	//
	template <class _InIt, class _OutIt, class _Fn, class _IterCat>
	_OutIt _Transform_impl(const sequential_execution_policy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Fn _Func, _IterCat)
	{
		_EXP_TRY
			return std::transform(_First, _Last, _Dest, _Func);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _OutIt, class _Fn, class _IterCat>
	_OutIt _Transform_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Fn _Func, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First != _Last) {
			return std::get<1>(*_Partitioner<_ExPolicy>::_For_Each(make_composable_iterator(_First, _Dest), std::distance(_First, _Last), _Func,
				[](composable_iterator<_InIt, _OutIt> _Begin, size_t _Count, _Fn& _UserFunc) {
				_Transform_helper<_ExPolicy, _IterCat>::Loop(std::get<0>(*_Begin), _Count, std::get<1>(*_Begin), _UserFunc);
			}));
		}

		return _Dest;
	}

	template <class _ExPolicy, class _InIt, class _OutIt, class _Fn>
	typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Transform_impl(const _ExPolicy&, _InIt _First, _InIt _Last, _OutIt _Dest, _Fn _Func, std::input_iterator_tag _Cat)
	{
		return _Transform_impl(seq, _First, _Last, _Dest, _Func, _Cat);
	}

	template <class _InIt, class _OutIt, class _Fn, class _IterCat>
	_OutIt _Transform_impl(const execution_policy& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Fn _Func, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Transform_impl, _Policy, _First, _Last, _Dest, _Func, _Cat);
	}

	//
	// transform binary predicate
	// 
	template <class _InIt, class _InIt2, class _OutIt, class _Fn, class _IterCat>
	_OutIt _Transform_impl_binary(const sequential_execution_policy&, _InIt _First, _InIt _Last, _InIt2 _First2, _OutIt _Dest, _Fn _Func, _IterCat)
	{
		_EXP_TRY
			return std::transform(_First, _Last, _First2, _Dest, _Func);
		_EXP_RETHROW
	}

	template <class _ExPolicy, class _InIt, class _InIt2, class _OutIt, class _Fn, class _IterCat>
	_OutIt _Transform_impl_binary(const _ExPolicy&, _InIt _First, _InIt _Last, _InIt2 _First2, _OutIt _Dest, _Fn _Func, _IterCat)
	{
		typedef typename std::decay<_ExPolicy>::type _ExecutionPolicy;

		if (_First != _Last) {
			return std::get<2>(*_Partitioner<_ExecutionPolicy>::_For_Each(make_composable_iterator(_First, _First2, _Dest), std::distance(_First, _Last), _Func,
				[](composable_iterator<_InIt, _InIt2, _OutIt> _Begin, size_t _Count, _Fn _UserFunc) {
				_Transform_helper<_ExecutionPolicy, _IterCat>::Loop(std::get<0>(*_Begin), _Count, std::get<1>(*_Begin), std::get<2>(*_Begin), _UserFunc);
			}));
		}

		return _Dest;
	}

	template <class _ExPolicy, class _InIt, class _InIt2, class _OutIt, class _Fn>
	typename _enable_if_parallel<_ExPolicy, _OutIt>::type _Transform_impl_binary(const _ExPolicy&, _InIt _First, _InIt _Last, _InIt2 _First2, _OutIt _Dest, _Fn _Func, std::input_iterator_tag _Cat)
	{
		return _Transform_impl_binary(seq, _First, _Last, _First2, _Dest, _Func, _Cat);
	}

	template <class _InIt, class _InIt2, class _OutIt, class _Fn, class _IterCat>
	_OutIt _Transform_impl_binary(const execution_policy& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _OutIt _Dest, _Fn _Func, _IterCat _Cat)
	{
		_EXP_GENERIC_EXECUTION_POLICY(_Transform_impl_binary, _Policy, _First, _Last, _First2, _Dest, _Func, _Cat);
	}
} // details

template <class _ExPolicy, class _InIt, class _OutIt, class _Fn>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type transform(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _OutIt _Dest, _Fn _Func)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _OutIt>::iterator_category _Cat;
	return details::_Transform_impl(_Policy, _First, _Last, _Dest, _Func, _Cat);
}

template <class _ExPolicy, class _InIt, class _InIt2, class _OutIt, class _Fn>
inline typename details::_enable_if_policy<_ExPolicy, _OutIt>::type transform(_ExPolicy&& _Policy, _InIt _First, _InIt _Last, _InIt2 _First2, _OutIt _Dest, _Fn _Func)
{
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::input_iterator_tag, typename std::iterator_traits<_InIt2>::iterator_category>::value, "Required input iterator or stronger.");
	static_assert(std::is_base_of<std::_Mutable_iterator_tag, typename std::iterator_traits<_OutIt>::iterator_category>::value, "Required output iterator or stronger.");

	details::common_iterator<_InIt, _InIt2, _OutIt>::iterator_category _Cat;
	return details::_Transform_impl_binary(_Policy, _First, _Last, _First2, _Dest, _Func, _Cat);
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_TRANSFORM_H_
