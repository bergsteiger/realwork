////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoWin32Impl/ProcessMemoryInfoImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::ProcessMemoryInfoImpl
//
// получает информацию о занимаемой процессом памяти используя функции библиотеки psapi
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/ProcessMemoryInfoImpl_factory.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/ProcessMemoryInfoImpl.h"

#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0) && defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

ProcessMemoryInfoImpl_factory::ProcessMemoryInfoImpl_factory () {
}

void ProcessMemoryInfoImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ResourceInfo::ProcessMemoryInfoFactoryManager::register_factory (this, priority);
}

const char* ProcessMemoryInfoImpl_factory::key () const {
	return "ProcessMemoryInfoImpl";
}

ResourceInfo::ProcessMemoryInfo* ProcessMemoryInfoImpl_factory::get () /*throw (ResourceInfo::NotSupported)*/ {
	ProcessMemoryInfoImpl_var ret = new ProcessMemoryInfoImpl ();
	return ret._retn ();
}

} // namespace ResourceInfoWin32Impl
} // namespace GCI

#endif //ACE_HAS_WINNT4!=0 && WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

