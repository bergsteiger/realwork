////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoWin32Impl/ProcessMemoryInfoImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::ProcessMemoryInfoImpl
// Заголовк реализации фабрик интерфеса ProcessMemoryInfo для серванта ProcessMemoryInfoImpl
//
// получает информацию о занимаемой процессом памяти используя функции библиотеки psapi
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOWIN32IMPL_PROCESSMEMORYINFOIMPL_FCTR_H__
#define __SHARED_GCI_RESOURCEINFOWIN32IMPL_PROCESSMEMORYINFOIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"

#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0) && defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

/// Interface-factory implementation for ProcessMemoryInfoImpl
class ProcessMemoryInfoImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ResourceInfo::ProcessMemoryInfoAbstractFactory
{
public:
	ProcessMemoryInfoImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ResourceInfo::ProcessMemoryInfo* get () /*throw (ResourceInfo::NotSupported)*/;

};

typedef ::Core::Var<ProcessMemoryInfoImpl_factory> ProcessMemoryInfoImpl_factory_var;

} // namespace ResourceInfoWin32Impl
} // namespace GCI


#endif //ACE_HAS_WINNT4!=0 && WIN32
#endif //__SHARED_GCI_RESOURCEINFOWIN32IMPL_PROCESSMEMORYINFOIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

