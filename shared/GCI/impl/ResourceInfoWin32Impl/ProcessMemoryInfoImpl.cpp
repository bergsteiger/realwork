////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoWin32Impl/ProcessMemoryInfoImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::ProcessMemoryInfoImpl
//
// получает информацию о занимаемой процессом памяти используя функции библиотеки psapi
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/ProcessMemoryInfoImpl.h"

//#UC START# *499910CA00A6_CUSTOM_INCLUDES*
#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0) && defined(WIN32)
	#include <windows.h>
	#include "psapi.h"
	#pragma comment(lib, "psapi.lib")
#endif
//#UC END# *499910CA00A6_CUSTOM_INCLUDES*

#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0) && defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

//#UC START# *499910CA00A6*
//#UC END# *499910CA00A6*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ProcessMemoryInfoImpl::ProcessMemoryInfoImpl ()
//#UC START# *46DBF5D002FD_49990E8E0265_499910CA00A6_BASE_INIT*
//#UC END# *46DBF5D002FD_49990E8E0265_499910CA00A6_BASE_INIT*
{
	//#UC START# *46DBF5D002FD_49990E8E0265_499910CA00A6_BODY*
	//#UC END# *46DBF5D002FD_49990E8E0265_499910CA00A6_BODY*
}

ProcessMemoryInfoImpl::~ProcessMemoryInfoImpl () {
	//#UC START# *499910CA00A6_DESTR_BODY*
	//#UC END# *499910CA00A6_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ResourceInfo::ProcessMemoryInfo
// текущее количество используемой памяти (в байтах)
ACE_UINT64 ProcessMemoryInfoImpl::get_current_usage () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DBF5F302EE_499910CA00A6_GET*
	return get_memory_info ().current_usage;
	//#UC END# *46DBF5F302EE_499910CA00A6_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// Максимальное количество используемой памяти (в байтах)
ACE_UINT64 ProcessMemoryInfoImpl::get_max_usage () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DBF63501D4_499910CA00A6_GET*
	return get_memory_info ().max_usage;
	//#UC END# *46DBF63501D4_499910CA00A6_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// информация о памяти занимаемой процессом
const ResourceInfo::ProcessMemoryData ProcessMemoryInfoImpl::get_memory_info () const {
	//#UC START# *499955A7031A_499910CA00A6_GET*
	HANDLE process_handle = ::OpenProcess (
		PROCESS_QUERY_INFORMATION | PROCESS_VM_READ
		, FALSE
		, ::GetCurrentProcessId ()
	);

	if (!process_handle) {
		throw GCI::ResourceInfo::ResourceSystemError ();
	}

	PROCESS_MEMORY_COUNTERS memory_counters;
	if (!::GetProcessMemoryInfo (process_handle, &memory_counters, sizeof (memory_counters))) {
        throw GCI::ResourceInfo::ResourceSystemError ();
	}
	
	::CloseHandle (process_handle);

	ResourceInfo::ProcessMemoryData info;
	info.current_usage = memory_counters.WorkingSetSize;
	info.max_usage = memory_counters.PeakWorkingSetSize;
	info.vm_usage = memory_counters.PagefileUsage;
	info.page_fault_count = memory_counters.PageFaultCount;
	return info;
	//#UC END# *499955A7031A_499910CA00A6_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// Счетчик отказов страниц
unsigned long ProcessMemoryInfoImpl::get_page_fault_count () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49253ADF0279_499910CA00A6_GET*
	return get_memory_info ().page_fault_count;
	//#UC END# *49253ADF0279_499910CA00A6_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// Размер адресного пространства, отведённого процессу (в байтах)
ACE_UINT64 ProcessMemoryInfoImpl::get_vm_usage () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DBF6DA004E_499910CA00A6_GET*
	return get_memory_info ().vm_usage;
	//#UC END# *46DBF6DA004E_499910CA00A6_GET*
}
} // namespace ResourceInfoWin32Impl
} // namespace GCI

#endif //ACE_HAS_WINNT4!=0 && WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

