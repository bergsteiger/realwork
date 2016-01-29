////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::PhysicalMemoryInfoImpl
//
// получает информацию о доступной памяти используя API windows
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl_factory.h"
#include "shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

PhysicalMemoryInfoImpl_factory::PhysicalMemoryInfoImpl_factory () {
}

void PhysicalMemoryInfoImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ResourceInfo::PhysicalMemoryInfoFactoryManager::register_factory (this, priority);
}

const char* PhysicalMemoryInfoImpl_factory::key () const {
	return "PhysicalMemoryInfoImpl";
}

ResourceInfo::PhysicalMemoryInfo* PhysicalMemoryInfoImpl_factory::get () /*throw (ResourceInfo::NotSupported)*/ {
	PhysicalMemoryInfoImpl_var ret = new PhysicalMemoryInfoImpl ();
	return ret._retn ();
}

} // namespace ResourceInfoImpl
} // namespace GCI

#endif //!WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

