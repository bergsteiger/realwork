////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/IObject.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::IObject
//
// базовый класс для всех интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_IOBJECT_H__
#define __SHARED_CORE_SYS_IOBJECT_H__

#include "ace/ACE.h"

//#UC START# *450035F1005D_CUSTOM_INCLUDES*
//#UC END# *450035F1005D_CUSTOM_INCLUDES*

namespace Core {

// базовый класс для всех интерфейсов
class IObject {
// virtual void destructor
public:
	virtual ~IObject () {};

//#UC START# *450035F1005D*
public:
	template <class _Type>
	static _Type* _duplicate (_Type* obj) {
		if (obj) {
			obj->addref();			
		} 
		return obj;
	}

public:
	virtual unsigned long addref () const = 0;
	virtual unsigned long release () const = 0;
	virtual unsigned long ref_count () const = 0;

//#UC END# *450035F1005D*
}; // class IObject

} // namespace Core


#endif //__SHARED_CORE_SYS_IOBJECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

