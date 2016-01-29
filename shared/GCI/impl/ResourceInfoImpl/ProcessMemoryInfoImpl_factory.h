////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::ProcessMemoryInfoImpl
// �������� ���������� ������ ��������� ProcessMemoryInfo ��� �������� ProcessMemoryInfoImpl
//
// �������� ���������� � ���������� ��������� ������ ��������� ������� ���������� psapi
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOIMPL_PROCESSMEMORYINFOIMPL_FCTR_H__
#define __SHARED_GCI_RESOURCEINFOIMPL_PROCESSMEMORYINFOIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

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

} // namespace ResourceInfoImpl
} // namespace GCI


#endif //!WIN32
#endif //__SHARED_GCI_RESOURCEINFOIMPL_PROCESSMEMORYINFOIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

