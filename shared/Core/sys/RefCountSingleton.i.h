////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/RefCountSingleton.i.h"
// генератор inline файлов реализации C++ (.i.h)
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

#include "ace/ACE.h"

//#UC START# *457EDB0B02DA_CUSTOM_INCLUDES*
//#UC END# *457EDB0B02DA_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *457EDB0B02DA*
//#UC END# *457EDB0B02DA*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает кешированную ссылку на экземпляр
template <class _RefCountType>
_RefCountType& RefCountSingleton<_RefCountType>::instance () {
	//#UC START# *457EDB8E0078*
	return *Singleton::instance ()->ptr;
	//#UC END# *457EDB8E0078**cpp*
}

// внутренний конструктор для создания экземпляра синглетона
template <class _RefCountType>
_RefCountType* RefCountSingleton<_RefCountType>::make () {
	//#UC START# *457F23A60242*
	return new _RefCountType;
	//#UC END# *457F23A60242**cpp*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

