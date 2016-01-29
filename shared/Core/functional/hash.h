////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/functional/hash.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::functional::hash
//
// Алгоритм вычисления хэша - простая обертка над boost::hash
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_FUNCTIONAL_HASH_H__
#define __SHARED_CORE_FUNCTIONAL_HASH_H__

#include "ace/ACE.h"

//#UC START# *4945FAC70197_USER_INCLUDES*
#include <functional>
#include "boost/functional/hash.hpp"
#if !defined(__APPLE__)
#include "tao/Objref_VarOut_T.h"
#endif
//#UC END# *4945FAC70197_USER_INCLUDES*

namespace Core {

//#UC START# *4945FAC70197_USER_DEFINITION*
template <class T> class Var;
template <class T, class Destructor, bool allow_use_on_refcounted> class Box;
template <class T, class Destructor>  class Aptr;

namespace detail {
	template <class T> 
	struct hash_impl {
		static std::size_t call (T const& val) {
			return boost::hash<T>() (val);
		}
	};
	
	//специализация для Var'а
	template <class T> 
	struct hash_impl<Core::Var<T> > {
		static std::size_t call (Core::Var<T> const& val) {
			return boost::hash<const T*>() (val.ptr());
		}
	};
	
	//специализация для Box'а
	template <class T, class Destructor, bool allow_use_on_refcounted> 
	struct hash_impl<Core::Box<T, Destructor, allow_use_on_refcounted> > {
		static std::size_t call (Core::Box<T, Destructor, allow_use_on_refcounted> const& val) {
			return boost::hash<const T*>() (val.ptr());
		}
	};

	//специализация для Aptr'а
	template <class T, class Destructor> 
	struct hash_impl<Core::Aptr<T, Destructor> > {
		static std::size_t call (Core::Aptr<T, Destructor> const& val) {
			return boost::hash<const T*> () (val.ptr ());
		}
	};

#if !defined(__APPLE__)
	template <class T>
	struct hash_impl<TAO_Objref_Var_T<T> > {
		static std::size_t call(TAO_Objref_Var_T<T> const& val) {
			return boost::hash<const T*>() (val.ptr());
		}
	};
#endif

} //namespace detail

template <class T> 
struct hash: std::unary_function<T, std::size_t>
{
    std::size_t operator() (T const& val) const {
		return detail::hash_impl<T>::call (val);
    }
};
//#UC END# *4945FAC70197_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_FUNCTIONAL_HASH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
