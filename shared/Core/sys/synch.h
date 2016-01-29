////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/synch.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::synch
//
// стандартные врапперы над АСЕ мьютексами и гвардами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_SYNCH_H__
#define __SHARED_CORE_SYS_SYNCH_H__

#include "ace/ACE.h"

//#UC START# *45003429008C_USER_INCLUDES*
#include "ace/Synch.h"
//#UC END# *45003429008C_USER_INCLUDES*

namespace Core {

// Ркурсивный мьютекс
typedef ACE_Recursive_Thread_Mutex Mutex;

//#UC START# *45003429008C_USER_DEFINITION*
	typedef ACE_RW_Thread_Mutex RWMutex;
	typedef ACE_Recursive_Thread_Mutex RWRMutex; // need to be replaced by reqursive RW mutex
	typedef ACE_Null_Mutex NullMutex;
	typedef ACE_Guard<ACE_Recursive_Thread_Mutex> Guard;
	typedef ACE_Read_Guard<ACE_RW_Thread_Mutex> ReadGuard;
	typedef ACE_Write_Guard<ACE_RW_Thread_Mutex> WriteGuard;

#define GUARD(MUTEX) \
	Core::Guard _local_guard (MUTEX);

#define READ_GUARD(MUTEX) \
	Core::ReadGuard _local_read_guard (MUTEX);

#define WRITE_GUARD(MUTEX) \
	Core::WriteGuard _local_write_guard (MUTEX);

#define GUARD_2(MUTEX) \
	Core::Guard _local_guard_2 (MUTEX);

#define READ_GUARD_2(MUTEX) \
	Core::ReadGuard _local_read_guard_2 (MUTEX);

#define WRITE_GUARD_2(MUTEX) \
	Core::WriteGuard _local_write_guard_2 (MUTEX);

#define RREAD_GUARD(MUTEX) \
	Core::Guard _local_read_guard (MUTEX);

#define RWRITE_GUARD(MUTEX) \
	Core::Guard _local_write_guard (MUTEX);
//#UC END# *45003429008C_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_SYS_SYNCH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
