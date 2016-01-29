////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoWin32Impl/PhysicalMemoryInfoImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::PhysicalMemoryInfoImpl
//
// получает информацию о доступной памяти используя API windows
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/PhysicalMemoryInfoImpl.h"

//#UC START# *4999102600DB_CUSTOM_INCLUDES*
#if defined (WIN32)
	#include <windows.h>
#endif //WIN32
//#UC END# *4999102600DB_CUSTOM_INCLUDES*

#if defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

//#UC START# *4999102600DB*
//#UC END# *4999102600DB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PhysicalMemoryInfoImpl::PhysicalMemoryInfoImpl ()
//#UC START# *46DE964F02FD_49990CEB0074_4999102600DB_BASE_INIT*
//#UC END# *46DE964F02FD_49990CEB0074_4999102600DB_BASE_INIT*
{
	//#UC START# *46DE964F02FD_49990CEB0074_4999102600DB_BODY*
	//#UC END# *46DE964F02FD_49990CEB0074_4999102600DB_BODY*
}

PhysicalMemoryInfoImpl::~PhysicalMemoryInfoImpl () {
	//#UC START# *4999102600DB_DESTR_BODY*
	//#UC END# *4999102600DB_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ResourceInfo::PhysicalMemoryInfo
// доступный размер физической памяти на машине (в байтах)
ACE_UINT64 PhysicalMemoryInfoImpl::get_available_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE995C006D_4999102600DB_GET*
	return get_memory_info ().available_memory_size;
	//#UC END# *46DE995C006D_4999102600DB_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// Доступный объем виртуальной памяти на компьютере (в байтах)
const ACE_UINT64 PhysicalMemoryInfoImpl::get_available_page_file_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49A7CCD4005C_4999102600DB_GET*
	return get_memory_info ().available_page_file_size;
	//#UC END# *49A7CCD4005C_4999102600DB_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// размер доступного адрессного пространства для процесса на машине (в байтах)
ACE_UINT64 PhysicalMemoryInfoImpl::get_available_virtual_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE9A25006D_4999102600DB_GET*
	return get_memory_info ().available_virtual_memory_size;
	//#UC END# *46DE9A25006D_4999102600DB_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// общий размер физической памяти на машине (в байтах)
ACE_UINT64 PhysicalMemoryInfoImpl::get_full_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE98840242_4999102600DB_GET*
	return get_memory_info ().full_memory_size;
	//#UC END# *46DE98840242_4999102600DB_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// информация о памяти в системе
const ResourceInfo::SystemMemoryData PhysicalMemoryInfoImpl::get_memory_info () const {
	//#UC START# *499955D302CC_4999102600DB_GET*
	typedef BOOL (STDAPICALLTYPE* ProcAddress) (LPMEMORYSTATUSEX);

	static ProcAddress GlobalMemoryStatusExProc (
		(ProcAddress)::GetProcAddress (
			::GetModuleHandle ("kernel32.dll")
			, "GlobalMemoryStatusEx"
		)
	);
	ResourceInfo::SystemMemoryData mem_status;
	if (GlobalMemoryStatusExProc == (ProcAddress)0) {
		MEMORYSTATUS ms;
		ms.dwLength = sizeof (ms);
		GlobalMemoryStatus (&ms);

		// вся информация в байтах
		mem_status.full_memory_size = ms.dwTotalPhys;
		mem_status.available_memory_size = ms.dwAvailPhys;
		mem_status.virtual_memory_size = ms.dwTotalVirtual;
		mem_status.available_virtual_memory_size = ms.dwAvailVirtual;
		mem_status.total_page_file_size = ms.dwTotalPageFile;
		mem_status.available_page_file_size = ms.dwAvailPageFile;

	} else {
		MEMORYSTATUSEX ms;
		ms.dwLength = sizeof (ms);
		if (!GlobalMemoryStatusExProc (&ms)) {
			throw GCI::ResourceInfo::ResourceSystemError ();
		}

		// вся информация в байтах
		mem_status.full_memory_size = ms.ullTotalPhys;
		mem_status.available_memory_size = ms.ullAvailPhys;
		mem_status.virtual_memory_size = ms.ullTotalVirtual;
		mem_status.available_virtual_memory_size = ms.ullAvailVirtual;
		mem_status.total_page_file_size = ms.ullTotalPageFile;
		mem_status.available_page_file_size = ms.ullAvailPageFile;
	}

	return mem_status;
	//#UC END# *499955D302CC_4999102600DB_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// Общий объем виртуальной памяти на компьютере (в байтах)
const ACE_UINT64 PhysicalMemoryInfoImpl::get_total_page_file_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49A7CCAB03DB_4999102600DB_GET*
	return get_memory_info ().total_page_file_size;
	//#UC END# *49A7CCAB03DB_4999102600DB_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// размер адрессного пространства для процесса на машине (в байтах)
ACE_UINT64 PhysicalMemoryInfoImpl::get_virtual_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE997601A5_4999102600DB_GET*
	return get_memory_info ().virtual_memory_size;
	//#UC END# *46DE997601A5_4999102600DB_GET*
}
} // namespace ResourceInfoWin32Impl
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

