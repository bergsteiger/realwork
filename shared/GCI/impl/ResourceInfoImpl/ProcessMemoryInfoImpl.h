////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::ProcessMemoryInfoImpl
// ��������� ���������� ������ �������� ��� ��������� ProcessMemoryInfo
//
// �������� ���������� � ���������� ��������� ������ ��������� ������� ���������� psapi
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOIMPL_PROCESSMEMORYINFOIMPL_H__
#define __SHARED_GCI_RESOURCEINFOIMPL_PROCESSMEMORYINFOIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

class ProcessMemoryInfoImpl; // self forward Var
typedef ::Core::Var<ProcessMemoryInfoImpl> ProcessMemoryInfoImpl_var;
typedef ::Core::Var<const ProcessMemoryInfoImpl> ProcessMemoryInfoImpl_cvar;

class ProcessMemoryInfoImpl_factory;

// �������� ���������� � ���������� ��������� ������ ��������� ������� ���������� psapi
class ProcessMemoryInfoImpl:
	virtual public ResourceInfo::ProcessMemoryInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ProcessMemoryInfoImpl)
	friend class ProcessMemoryInfoImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ProcessMemoryInfoImpl ();

	virtual ~ProcessMemoryInfoImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ResourceInfo::ProcessMemoryInfo
	// ������� ���������� ������������ ������ (� ������)
	virtual ACE_UINT64 get_current_usage () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::ProcessMemoryInfo
	// ������������ ���������� ������������ ������ (� ������)
	virtual ACE_UINT64 get_max_usage () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::ProcessMemoryInfo
	// ���������� � ������ ���������� ���������
	virtual const ResourceInfo::ProcessMemoryData get_memory_info () const;

	// implemented method from ResourceInfo::ProcessMemoryInfo
	// ������� ������� �������
	virtual unsigned long get_page_fault_count () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::ProcessMemoryInfo
	// ������ ��������� ������������, ���������� �������� (� ������)
	virtual ACE_UINT64 get_vm_usage () const
		/*throw (ResourceInfo::ResourceSystemError)*/;
}; // class ProcessMemoryInfoImpl

} // namespace ResourceInfoImpl
} // namespace GCI


#endif //!WIN32
#endif //__SHARED_GCI_RESOURCEINFOIMPL_PROCESSMEMORYINFOIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
