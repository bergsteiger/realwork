////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoImpl/CPUInfo_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::CPUInfo
//
// считывает информацию о процессоре из реестра ОС
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/ResourceInfoImpl/CPUInfo_factory.h"
#include "shared/GCI/impl/ResourceInfoImpl/CPUInfo.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

CPUInfo_factory::CPUInfo_factory () {
}

void CPUInfo_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ResourceInfo::CPUInfoFactoryManager::register_factory (this, priority);
}

const char* CPUInfo_factory::key () const {
	return "CPUInfo";
}

ResourceInfo::CPUInfo* CPUInfo_factory::get () /*throw (ResourceInfo::NotSupported)*/ {
	CPUInfo_var ret = new CPUInfo ();
	return ret._retn ();
}

} // namespace ResourceInfoImpl
} // namespace GCI

#endif //!WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

