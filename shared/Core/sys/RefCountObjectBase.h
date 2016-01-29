////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/RefCountObjectBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::RefCountObjectBase
//
// класс-примесь для реализации счетчика ссылок на сервантах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_REFCOUNTOBJECTBASE_H__
#define __SHARED_CORE_SYS_REFCOUNTOBJECTBASE_H__

#include "ace/ACE.h"
#include "shared/Core/sys/IObject.h"

//#UC START# *45003674031C_CUSTOM_INCLUDES*
#include "shared/Core/sys/AtomicOp.h"
//#UC END# *45003674031C_CUSTOM_INCLUDES*

namespace Core {

// класс-примесь для реализации счетчика ссылок на сервантах
class RefCountObjectBase :
	virtual public IObject
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// Конструктор, при создании объекта счетчик ссылок устанавливается в 1
	RefCountObjectBase ();

public:
	virtual ~RefCountObjectBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// увеличить счетчик ссылок
	unsigned long addref () const;

	// возвращает значение счетчика ссылок
	unsigned long ref_count () const;

	// уменьшает счетчик ссылок, при достижении счетчика нуля - объект удаляется
	virtual unsigned long release () const;

protected:
	// метод для уничтожения объекта (вызывается, когда счетчик ссылок на объекте равен нулю)
	virtual void delete_obj ();

	// устанавливает счетчик ссылок в 1
	void init_counter () const;

	// Метод уменьшает счетчик ссылок и возвращает в качестве результата его значение. Отличие от
	// release в том, что в данном методе не происходит удаления объекта, даже если счетчик ссылок
	// достиг нуля.
	unsigned long internal_release () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Core::AtomicOp<long> m_counter;

//#UC START# *45003674031C*
// Запрещаем копирующий конструктор и оператор присваивания
private:
	RefCountObjectBase (const RefCountObjectBase&);
	RefCountObjectBase& operator= (const RefCountObjectBase&);
//#UC END# *45003674031C*
}; // class RefCountObjectBase

} // namespace Core


#endif //__SHARED_CORE_SYS_REFCOUNTOBJECTBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

