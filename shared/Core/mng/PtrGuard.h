////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/PtrGuard.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::PtrGuard
//
// вспомогательный класс-обертка над указателем, для предотвращение попадания кешированных (без
// взведденыого addref) результатов функций в менеджеры типа Var, Aptr или Box
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_PTRGUARD_H__
#define __SHARED_CORE_MNG_PTRGUARD_H__

#include "ace/ACE.h"

//#UC START# *4500151200DA_USER_INCLUDES*
//#UC END# *4500151200DA_USER_INCLUDES*

namespace Core {

//#UC START# *4500151200DA_USER_DEFINITION*
template <class _Type>
class PtrGuard {
private:
	PtrGuard () : m_ptr(0) {
	}

public:	
	///////////////////////////
	// construction	
	///////////////////////////

	PtrGuard (_Type* data) : m_ptr (data) {
	}

	PtrGuard (const PtrGuard<_Type>& copy) {
		m_ptr = copy.m_ptr;
	}
			
	///////////////////////////
	// cast operator
	///////////////////////////

	inline operator _Type const* () const {
		return m_ptr;
	}

	inline operator _Type* () {
		return m_ptr;
	}

	///////////////////////////
	// access by pointer	
	///////////////////////////

	inline _Type* operator -> () {
		assert (m_ptr);
		return m_ptr;
	}

	inline _Type const* operator -> () const {
		assert (m_ptr);
		return m_ptr;
	}

private:
	_Type* m_ptr;
};

//#UC END# *4500151200DA_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_PTRGUARD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
