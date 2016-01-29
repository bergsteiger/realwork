////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/functional/equal_to.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::functional::equal_to
//
// обертка над std::equal используется для специализации сравнения Var'ов, Aptr'ов, Box'ов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_FUNCTIONAL_EQUAL_TO_H__
#define __SHARED_CORE_FUNCTIONAL_EQUAL_TO_H__

#include "ace/ACE.h"

//#UC START# *4945FB4300C7_USER_INCLUDES*
#include <functional>
//#UC END# *4945FB4300C7_USER_INCLUDES*

namespace Core {

//#UC START# *4945FB4300C7_USER_DEFINITION*
template <class T> class Var;
template <class T, class Destructor, bool allow_use_on_refcounted> class Box;
template <class T, class Destructor>  class Aptr;

namespace detail {
	template <class T> 
	struct equal_to_impl {
		static bool call (T const& lhs, T const& rhs) {
			return std::equal_to<T> () (lhs, rhs);
		}
	};

	template <class T> 
	struct equal_to_impl<Core::Var<T> > {
		static bool call (Core::Var<T> const& lhs, Core::Var<T> const& rhs) {
			return std::equal_to<const T*> () (lhs.ptr (), rhs.ptr ());
		}
	};
	
	//специализация для Box'а
	template <class T, class Destructor, bool allow_use_on_refcounted>
	struct equal_to_impl<Core::Box<T, Destructor, allow_use_on_refcounted> > {
		static bool call (
			Core::Box<T, Destructor, allow_use_on_refcounted> const& lhs
			, Core::Box<T, Destructor, allow_use_on_refcounted> const& rhs
		) {
			return std::equal_to<const T*> () (lhs.ptr (), rhs.ptr ());
		}
	};
	
	//специализация для Aptr'а
	template <class T, class Destructor> 
	struct equal_to_impl<Core::Aptr<T, Destructor> > {
		static bool call (
			Core::Aptr<T, Destructor> const& lhs
			, Core::Aptr<T, Destructor> const& rhs
		) {
			 return std::equal_to<const T*>() (lhs.ptr (), rhs.ptr ());
		}
	};
} //namespace detail

template <class T> 
struct equal_to: std::binary_function<T, T, bool>
{
    bool operator () (T const& lhs, T const& rhs) const {
		return detail::equal_to_impl<T>::call (lhs, rhs);
    }
};
//#UC END# *4945FB4300C7_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_FUNCTIONAL_EQUAL_TO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
