////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapWin32/MMapWin32.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::MMapWin32
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPWIN32_H__
#define __SHARED_GCI_MMAPWIN32_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMap.h"


#if defined(WIN32)
namespace GCI {
namespace MMapWin32 {

// тип хендля объекта смапленной памяти
typedef HANDLE MapObjectID;

// тип хендла для открытого мап-файла
typedef HANDLE FileHandle;

// данные для CreateFileA
struct OpenFileInfo {
	// путь и имя файла
	std::string name;
	// системное смещение памяти
	MMap::LongSize memory_offset;
	// желаемый размер файла для мапинга
	MMap::LongSize desired_size;
	// флаги доступа
	DWORD access;
	// флаги шаринга
	DWORD shared_mode;
	// флаги создания
	DWORD creation;
	// Дополнительные флаги
	DWORD flags;
	// Гранулярность памяти в системе
	DWORD granularity;
};

} //namespace MMapWin32
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPWIN32_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

