////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::PhysicalMemoryInfoImpl
// Заголовк реализации фабрик интерфеса PhysicalMemoryInfo для серванта PhysicalMemoryInfoImpl
//
// получает информацию о доступной памяти используя API windows
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOIMPL_PHYSICALMEMORYINFOIMPL_FCTR_H__
#define __SHARED_GCI_RESOURCEINFOIMPL_PHYSICALMEMORYINFOIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

/// Interface-factory implementation for PhysicalMemoryInfoImpl
class PhysicalMemoryInfoImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ResourceInfo::PhysicalMemoryInfoAbstractFactory
{
public:
	PhysicalMemoryInfoImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ResourceInfo::PhysicalMemoryInfo* get () /*throw (ResourceInfo::NotSupported)*/;

};

typedef ::Core::Var<PhysicalMemoryInfoImpl_factory> PhysicalMemoryInfoImpl_factory_var;

} // namespace ResourceInfoImpl
} // namespace GCI


#endif //!WIN32
#endif //__SHARED_GCI_RESOURCEINFOIMPL_PHYSICALMEMORYINFOIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

