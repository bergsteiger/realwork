////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/TypeSingleton.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::TypeSingleton
//
// синглетон позволяющий определить статическую переменную, без необходимости ее инициализации в
// cpp-файле
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_TYPESINGLETON_H__
#define __SHARED_CORE_MNG_TYPESINGLETON_H__

#include "ace/ACE.h"

//#UC START# *4500152B01E4_USER_INCLUDES*
/*! cool for static member declaration without CPP definition
    useage:

   class X {...};

   class Y {
     typedef TypeSingleton<X> XSingl;

     some_function () {			
       XSingl::instance().some_member();
     }
   };
*/
//#UC END# *4500152B01E4_USER_INCLUDES*

namespace Core {

//#UC START# *4500152B01E4_USER_DEFINITION*
template <class _Type>
class TypeSingleton {
public:
	static _Type* const instance() {
		return &s_type_instance;
	}
private:
	static _Type s_type_instance;
};

template <class _Type>
_Type TypeSingleton<_Type>::s_type_instance;

//#UC END# *4500152B01E4_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_TYPESINGLETON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
