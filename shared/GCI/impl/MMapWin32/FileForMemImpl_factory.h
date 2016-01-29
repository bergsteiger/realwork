////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapWin32/FileForMemImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapWin32::FileForMemImpl
// Заголовк реализации фабрик интерфеса FileForMem для серванта FileForMemImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPWIN32_FILEFORMEMIMPL_FCTR_H__
#define __SHARED_GCI_MMAPWIN32_FILEFORMEMIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMapFactories.h"
#include "shared/GCI/impl/MMapWin32/MMapWin32.h"

#if defined(WIN32) && defined(_WIN32_WINNT) && (_WIN32_WINNT >= 0x0500)
namespace GCI {
namespace MMapWin32 {

/// Interface-factory implementation for FileForMemImpl
class FileForMemImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public MMap::FileForMemAbstractFactory
{
public:
	FileForMemImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MMap::FileForMem* open (
		const char* file_name
		, unsigned long flags
		, size_t file_increase
		, bool ro_mode
	) /*throw (
		MMap::SysError
	)*/;

	MMap::FileForMem* create (const char* file_name, MMap::LongSize size, unsigned long flags) /*throw (MMap::SysError)*/;

};

typedef ::Core::Var<FileForMemImpl_factory> FileForMemImpl_factory_var;

} // namespace MMapWin32
} // namespace GCI


#endif //WIN32 && _WIN32_WINNT>=0x0500
#endif //__SHARED_GCI_MMAPWIN32_FILEFORMEMIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

