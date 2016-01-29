////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/mng/TypeDestructors.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::TypeDestructors
//
// ����������� ����������� ��� ���������� ���� Aptr � Box
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_TYPEDESTRUCTORS_H__
#define __SHARED_CORE_MNG_TYPEDESTRUCTORS_H__

#include "ace/ACE.h"

//#UC START# *4500153C0138_USER_INCLUDES*
//#UC END# *4500153C0138_USER_INCLUDES*

namespace Core {

//#UC START# *4500153C0138_USER_DEFINITION*

// ����� ��������� ������? ���������� ��������� ������� "destroy".
// ������������ - �������� �������������:
// Var<X, ArrayDeleteDestructor> ������ Var<X, ArrayDeleteDestructor<X> > 

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
