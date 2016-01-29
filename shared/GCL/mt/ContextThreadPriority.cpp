////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/mt/ContextThreadPriority.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::mt::ContextThreadPriority
//
// Класс позволяющий изменять приоритет текущего потока и автоматичеки (в деструкторе) возвращать
// его старое значение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/mt/ContextThreadPriority.h"

//#UC START# *4501A229004E_CUSTOM_INCLUDES*
//#UC END# *4501A229004E_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *4501A229004E*
//#UC END# *4501A229004E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// устанавливает новый приоритет потока (абсолютный или относительный)
ContextThreadPriority::ContextThreadPriority (int priority, bool absolute)
//#UC START# *4501A2400232_BASE_INIT*
//#UC END# *4501A2400232_BASE_INIT*
{
	//#UC START# *4501A2400232_BODY*
	ACE_Thread::self(m_self_th);
	ACE_Thread::getprio (m_self_th, m_seved_prio);
	ACE_Thread::setprio (m_self_th, absolute ? priority : ACE_DEFAULT_THREAD_PRIORITY + priority);
	//#UC END# *4501A2400232_BODY*
}

ContextThreadPriority::~ContextThreadPriority () {
	//#UC START# *4501A229004E_DESTR_BODY*
	ACE_Thread::setprio (m_self_th, m_seved_prio);
	//#UC END# *4501A229004E_DESTR_BODY*
}


} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

