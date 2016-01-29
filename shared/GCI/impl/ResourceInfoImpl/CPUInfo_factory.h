////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoImpl/CPUInfo_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::CPUInfo
// Заголовк реализации фабрик интерфеса CPUInfo для серванта CPUInfo
//
// считывает информацию о процессоре из реестра ОС
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOIMPL_CPUINFO_FCTR_H__
#define __SHARED_GCI_RESOURCEINFOIMPL_CPUINFO_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

/// Interface-factory implementation for CPUInfo
class CPUInfo_factory: virtual public ::Core::RefCountObjectBase, virtual public ResourceInfo::CPUInfoAbstractFactory {
public:
	CPUInfo_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ResourceInfo::CPUInfo* get () /*throw (ResourceInfo::NotSupported)*/;

};

typedef ::Core::Var<CPUInfo_factory> CPUInfo_factory_var;

} // namespace ResourceInfoImpl
} // namespace GCI


#endif //!WIN32
#endif //__SHARED_GCI_RESOURCEINFOIMPL_CPUINFO_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

