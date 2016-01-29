////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/os/disk_op.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::os::disk_op
// Файл реализации утилитного набора disk_op
//
// расширенные операции над диском (получение свободного места, ...)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/os/disk_op.h"

//#UC START# *4503DE0B02EE_CUSTOM_INCLUDES*
#include <string>
#include <iostream>

//#UC END# *4503DE0B02EE_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *4503DE0B02EE*
//#UC END# *4503DE0B02EE*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// Get free disk space for the path, in kb
// If the function succeeds, the return value is nonzero
bool get_free_space (const char* path, unsigned long& free_space) {
	//#UC START# *4503DE2F038A*
#ifdef WIN32
	std::string s = path;
	// UNC пути обязаны заканчиваться на слеш для правильной работы метода GetDiskFreeSpaceExA
	if (s [s.size () - 1] != '\\' && s [s.size () - 1] != '/') {
		s += '\\';
	}
	// implementation for WinNT 4.0 and Win95 OSR2 and later
	typedef BOOL (WINAPI *fTGetDiskFreeSpaceEx) (LPCTSTR, PULARGE_INTEGER, PULARGE_INTEGER, PULARGE_INTEGER);
	FARPROC fpointer = GetProcAddress (GetModuleHandle ("kernel32.dll") , "GetDiskFreeSpaceExA");
	fTGetDiskFreeSpaceEx pGetDiskFreeSpaceEx = reinterpret_cast <fTGetDiskFreeSpaceEx> (fpointer);
	if (pGetDiskFreeSpaceEx) {
		__int64 i64FreeBytesToCaller = 0;
		__int64 i64TotalBytes = 0;
		__int64 i64FreeBytes = 0;
		BOOL fResult = pGetDiskFreeSpaceEx (s.c_str ()
										   , (PULARGE_INTEGER)&i64FreeBytesToCaller
										   , (PULARGE_INTEGER)&i64TotalBytes
										   , (PULARGE_INTEGER)&i64FreeBytes);
		if (fResult) {
			unsigned long free_kb = static_cast <unsigned long> (i64FreeBytesToCaller / 1024);
			free_space = free_kb;
			return true;
		}
	}
	// implementation for WinNT 3.5 and Win95 and early
	DWORD dwSectPerClust = 0;
	DWORD dwBytesPerSect = 0;
	DWORD dwFreeClusters = 0;
	DWORD dwTotalClusters = 0;
	BOOL fResult = GetDiskFreeSpace (s.c_str ()
									, &dwSectPerClust
									, &dwBytesPerSect
									, &dwFreeClusters
									, &dwTotalClusters);
	if (fResult) {
		__int64 free_bytes = dwFreeClusters * dwSectPerClust * dwBytesPerSect;
		unsigned long free_kb = static_cast <unsigned long> (free_bytes / 1024);
		free_space = free_kb;
		return true;
	}
#else
//	#error "get_free_space" have been implemented for NOT WIN32 OS only for a while
std::cerr<<"get_free_space() call requested"<<std::endl;
#endif

	return false;
	//#UC END# *4503DE2F038A*
}

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

