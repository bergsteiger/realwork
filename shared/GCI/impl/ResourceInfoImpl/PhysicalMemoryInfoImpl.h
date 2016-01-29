////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::PhysicalMemoryInfoImpl
// ��������� ���������� ������ �������� ��� ��������� PhysicalMemoryInfo
//
// �������� ���������� � ��������� ������ ��������� API windows
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOIMPL_PHYSICALMEMORYINFOIMPL_H__
#define __SHARED_GCI_RESOURCEINFOIMPL_PHYSICALMEMORYINFOIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

class PhysicalMemoryInfoImpl; // self forward Var
typedef ::Core::Var<PhysicalMemoryInfoImpl> PhysicalMemoryInfoImpl_var;
typedef ::Core::Var<const PhysicalMemoryInfoImpl> PhysicalMemoryInfoImpl_cvar;

class PhysicalMemoryInfoImpl_factory;

// �������� ���������� � ��������� ������ ��������� API windows
class PhysicalMemoryInfoImpl:
	virtual public ResourceInfo::PhysicalMemoryInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PhysicalMemoryInfoImpl)
	friend class PhysicalMemoryInfoImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PhysicalMemoryInfoImpl ();

	virtual ~PhysicalMemoryInfoImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// ��������� ������ ���������� ������ �� ������ (� ������)
	virtual ACE_UINT64 get_available_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// ��������� ����� ����������� ������ �� ���������� (� ������)
	virtual const ACE_UINT64 get_available_page_file_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// ������ ���������� ���������� ������������ ��� �������� �� ������ (� ������)
	virtual ACE_UINT64 get_available_virtual_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// ����� ������ ���������� ������ �� ������ (� ������)
	virtual ACE_UINT64 get_full_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// ���������� � ������ � �������
	virtual const ResourceInfo::SystemMemoryData get_memory_info () const;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// ����� ����� ����������� ������ �� ���������� (� ������)
	virtual const ACE_UINT64 get_total_page_file_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// ������ ���������� ������������ ��� �������� �� ������ (� ������)
	virtual ACE_UINT64 get_virtual_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;
}; // class PhysicalMemoryInfoImpl

} // namespace ResourceInfoImpl
} // namespace GCI


#endif //!WIN32
#endif //__SHARED_GCI_RESOURCEINFOIMPL_PHYSICALMEMORYINFOIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
