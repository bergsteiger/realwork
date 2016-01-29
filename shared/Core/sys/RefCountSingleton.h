////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/RefCountSingleton.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Core::sys::RefCountSingleton
//
// Обертка над ACE-овским синглетоном для работы с объктами со счетчиком ссылок. Хранит вместо
// самого экземпляра его Var, за счет чего экземпляр хранящийся в синглетоне может независимо
// управляться через счетчик ссылок . Например, "пережить" свой синглетон, если кто-то другой
// (веороятно другой синглетон) им владеет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_REFCOUNTSINGLETON_H__
#define __SHARED_CORE_SYS_REFCOUNTSINGLETON_H__

#include "ace/ACE.h"

//#UC START# *457EDB0B02DA_CUSTOM_INCLUDES*
#include "ace/Singleton.h"

#define CORE_SINGLETON(TYPE) \
	typedef ACE_Singleton <TYPE, ACE_SYNCH_RECURSIVE_MUTEX> Singleton; \
	friend class ACE_Singleton <TYPE, ACE_SYNCH_RECURSIVE_MUTEX>;

#define REFCOUNT_SINGLETON(TYPE) \
	typedef Core::RefCountSingleton<TYPE> Singleton; \
	friend class Core::RefCountSingleton<TYPE>;

//#UC END# *457EDB0B02DA_CUSTOM_INCLUDES*

namespace Core {

// Обертка над ACE-овским синглетоном для работы с объктами со счетчиком ссылок. Хранит вместо
// самого экземпляра его Var, за счет чего экземпляр хранящийся в синглетоне может независимо
// управляться через счетчик ссылок . Например, "пережить" свой синглетон, если кто-то другой
// (веороятно другой синглетон) им владеет
template <class _RefCountType>
class RefCountSingleton {
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возвращает кешированную ссылку на экземпляр
	static _RefCountType& instance ();

private:
	// внутренний конструктор для создания экземпляра синглетона
	static _RefCountType* make ();


//#UC START# *457EDB0B02DA*
	struct AutoVar {
		AutoVar () {
			ptr = RefCountSingleton<_RefCountType>::make();
		}
		~AutoVar () {
			ptr->release();
		}
		_RefCountType* ptr;
	};

	typedef ACE_Singleton <AutoVar, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
//#UC END# *457EDB0B02DA*
}; // class RefCountSingleton

} // namespace Core

#include "shared/Core/sys/RefCountSingleton.i.h"

#endif //__SHARED_CORE_SYS_REFCOUNTSINGLETON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

