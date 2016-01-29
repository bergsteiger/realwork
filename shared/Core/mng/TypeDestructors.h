////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/TypeDestructors.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::TypeDestructors
//
// стандартные деструкторы для менеджеров типа Aptr и Box
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_TYPEDESTRUCTORS_H__
#define __SHARED_CORE_MNG_TYPEDESTRUCTORS_H__

#include "ace/ACE.h"

//#UC START# *4500153C0138_USER_INCLUDES*
//#UC END# *4500153C0138_USER_INCLUDES*

namespace Core {

//#UC START# *4500153C0138_USER_DEFINITION*

// зачем шаблонные классы? достаточно шаблонных функций "destroy".
// преимущества - простота использования:
// Var<X, ArrayDeleteDestructor> вместо Var<X, ArrayDeleteDestructor<X> > 

template <class T>
struct DeleteDestructor {
	static inline void destroy (T* t) {
		delete t;
	}
};

template <class T>
struct ArrayDeleteDestructor {
	static inline void destroy (T* t) {
		delete [] t;
	}
};

struct FreeDestructor {
	static inline void destroy (void* ptr) {
		/*std::*/free (ptr); // If ptr is NULL, no action occurs.
	}
};

//#UC END# *4500153C0138_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_TYPEDESTRUCTORS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
