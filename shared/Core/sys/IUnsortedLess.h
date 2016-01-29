////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/IUnsortedLess.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::IUnsortedLess
//
// базовый интерфейс всех объектов с поддержкой базового функтора сравнения, для не сортированных
// контейнеров
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_IUNSORTEDLESS_H__
#define __SHARED_CORE_SYS_IUNSORTEDLESS_H__

#include "ace/ACE.h"

//#UC START# *459CEBF101F9_CUSTOM_INCLUDES*
namespace Core {

template <class _VarType, bool is_pointer>
struct ArbitraryLess;

}
//#UC END# *459CEBF101F9_CUSTOM_INCLUDES*

namespace Core {

// базовый интерфейс всех объектов с поддержкой базового функтора сравнения, для не сортированных
// контейнеров
class IUnsortedLess {
// virtual void destructor
public:
	virtual ~IUnsortedLess () {};

//#UC START# *459CEBF101F9*
protected:
	template <class _VarType, bool is_pointer> friend struct ArbitraryLess;
	virtual bool is_unsorted_less (const IUnsortedLess* c) const = 0;
//#UC END# *459CEBF101F9*
}; // class IUnsortedLess

} // namespace Core


#endif //__SHARED_CORE_SYS_IUNSORTEDLESS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

