////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/ResourceInfo/ResourceInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::ResourceInfo
//
// набор интерфейсов для предоставления информации о системе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"

namespace GCI {
namespace ResourceInfo {


const char* ResourceSystemError::uid () const /*throw ()*/ {
	return "CE4260CC-488F-4F59-BED4-73C7D244A7DA";
}

const char* ResourceSystemError::what () const throw () {
	//#UC START# *46DBF76D0128_WHAT_IMPL*
	return "ResourceSystemError (не смогли получить системную информацию о ресурсах)";
	//#UC END# *46DBF76D0128_WHAT_IMPL*
}


const char* NotSupported::uid () const /*throw ()*/ {
	return "7B1F8A75-980E-47C4-98D6-5979D1998AEA";
}

const char* NotSupported::what () const throw () {
	//#UC START# *46DBD0750157_WHAT_IMPL*
	return "NotSupported (метод на данной ОС ещё не реализован)";
	//#UC END# *46DBD0750157_WHAT_IMPL*
}

// factory interface wrapper for CPUInfo
CPUInfo& CPUInfoFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/ {
	return CPUInfoFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for ProcessMemoryInfo
ProcessMemoryInfo& ProcessMemoryInfoFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/ {
	return ProcessMemoryInfoFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for PhysicalMemoryInfo
PhysicalMemoryInfo& PhysicalMemoryInfoFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/ {
	return PhysicalMemoryInfoFactoryManager::Singleton::instance ()->get ();
}

} // namespace ResourceInfo
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

