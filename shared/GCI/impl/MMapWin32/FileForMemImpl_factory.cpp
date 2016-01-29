////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapWin32/FileForMemImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapWin32::FileForMemImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapWin32/FileForMemImpl_factory.h"
#include "shared/GCI/impl/MMapWin32/FileForMemImpl.h"

#if defined(WIN32) && defined(_WIN32_WINNT) && (_WIN32_WINNT >= 0x0500)
namespace GCI {
namespace MMapWin32 {

FileForMemImpl_factory::FileForMemImpl_factory () {
}

void FileForMemImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MMap::FileForMemFactoryManager::register_factory (this, priority);
}

const char* FileForMemImpl_factory::key () const {
	return "FileForMemImpl";
}

MMap::FileForMem* FileForMemImpl_factory::open (
	const char* file_name
	, unsigned long flags
	, size_t file_increase
	, bool ro_mode
) /*throw (
	MMap::SysError
)*/ {
	FileForMemImpl_var ret = new FileForMemImpl (file_name, flags, file_increase, ro_mode);
	return ret._retn ();
}

MMap::FileForMem* FileForMemImpl_factory::create (
	const char* file_name
	, MMap::LongSize size
	, unsigned long flags
) /*throw (
	MMap::SysError
)*/ {
	FileForMemImpl_var ret = new FileForMemImpl (file_name, size, flags);
	return ret._retn ();
}

} // namespace MMapWin32
} // namespace GCI

#endif //WIN32 && _WIN32_WINNT>=0x0500
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

