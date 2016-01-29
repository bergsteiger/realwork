////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/container_op.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::container_op
//
// расширение стандартных алгоритмов над контейнерами: normolize; merge, difference, intersect на
// самом контейнере (пока тока для std::set)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_ALG_CONTAINER_OP_H__
#define __SHARED_GCL_ALG_CONTAINER_OP_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450130B00213_USER_INCLUDES*
#include <set>
#include <vector>
//#UC END# *450130B00213_USER_INCLUDES*

namespace GCL {

//#UC START# *450130B00213_USER_DEFINITION*
template<class Container>
void reverse (Container& container) {
	std::reverse (container.begin (), container.end ());
}

template<class Container>
void sort (Container& container) {
	std::sort (container.begin (), container.end ());
}

template<class Container, class Functor>
void sort (Container& container, Functor functor) {
	std::sort (container.begin (), container.end (), functor);
}


template<class Container, class Pred>
bool any_of (Container& container, Pred& predicate) {
	return std::any_of (container.begin (), container.end (), predicate);
}

// template classes for octet sequence comparision operators
// for use in STL containers such as std::map
// using ACE_OS_String::memcmp
// example:
// 	typedef GCL::OctetSeqLess<GslTree::TreeID_var> TreeIDCompare;
// 	typedef std::map<GslTree::TreeID_var, Tree_impl*> TreeMap;
template<class T> 
struct OctetSeqLess : public std::binary_function<T, T, bool> {
	bool operator() (T a, T b) const;
};

template<class T> 
struct OctetSeqGreater : public std::binary_function<T, T, bool> {
	bool operator() (T a, T b) const;
};			

// нормализует массив target относительно массива base
// Пример 1:
//	base = {1:2:3:4}
//  target = {1:2:3a:4}
//  normalize (base, target, true) = {3a:4}
// Пример 2:
//	base = {1:2:3:4}
//  target = {1:2:3}
//  normalize (base, target, true) = {3}
// Пример 3:
//	base = {1:2:3}
//  target = {1:2:3}
//  normalize (base, target, true) = {3}
// Пример 4:
//	base = {1:2:3}
//  target = {1:2:3}
//  normalize (base, target, false) = {}
template <class _C>
_C& normalize (const _C& base, _C& target, bool with_back = true);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// merge, intersect, difference for std::set

template <class _Key, class _Compare, class _Allocator>
std::set<_Key, _Compare, _Allocator>& merge (
	std::set<_Key, _Compare, _Allocator>& cont
	, const std::set<_Key, _Compare, _Allocator>& operand
);

//#UC END# *450130B00213_USER_DEFINITION*

} // namespace GCL

#include "shared/GCL/alg/container_op.i.h"

#endif //__SHARED_GCL_ALG_CONTAINER_OP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
