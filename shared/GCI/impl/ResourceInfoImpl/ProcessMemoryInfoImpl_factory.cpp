////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::ProcessMemoryInfoImpl
//
// получает информацию о занимаемой процессом памяти используя функции библиотеки psapi
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl_factory.h"
#include "shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

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

} // namespace ResourceInfoImpl
} // namespace GCI

#endif //!WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

