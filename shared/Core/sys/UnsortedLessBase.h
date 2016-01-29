////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/UnsortedLessBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::UnsortedLessBase
//
// класс-примесь для простых классов, с реализацией базового функтора сравнения для не
// сортированных контейнеров
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_UNSORTEDLESSBASE_H__
#define __SHARED_CORE_SYS_UNSORTEDLESSBASE_H__

#include "ace/ACE.h"
#include "shared/Core/sys/IUnsortedLess.h"

//#UC START# *450036CA035B_CUSTOM_INCLUDES*
//#UC END# *450036CA035B_CUSTOM_INCLUDES*

namespace Core {

// класс-примесь для простых классов, с реализацией базового функтора сравнения для не
// сортированных контейнеров
class UnsortedLessBase :
	virtual public IUnsortedLess
{
// virtual void destructor
public:
	virtual ~UnsortedLessBase () {};

//#UC START# *450036CA035B*
protected:
	UnsortedLessBase () {
	}

protected:
	template <class _VarType, bool is_pointer> friend struct ArbitraryLess;
	virtual bool is_unsorted_less (const IUnsortedLess* c) const {
		return c < this;
	}
// Запрещаем копирующий конструктор и оператор присваивания
private:
	UnsortedLessBase (const UnsortedLessBase&);
	UnsortedLessBase& operator= (const UnsortedLessBase&);

//#UC END# *450036CA035B*
}; // class UnsortedLessBase

} // namespace Core


#endif //__SHARED_CORE_SYS_UNSORTEDLESSBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

