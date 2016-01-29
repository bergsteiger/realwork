////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/ResourceInfo/ResourceInfo.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::ResourceInfo
//
// ����� ����������� ��� �������������� ���������� � �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFO_H__
#define __SHARED_GCI_RESOURCEINFO_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace ResourceInfo {

// �� ������ �������� ��������� ���������� � ��������
class ResourceSystemError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����� �� ������ �� ��� �� ����������
class NotSupported : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class CPUInfo;
typedef ::Core::Var<CPUInfo> CPUInfo_var;
typedef ::Core::Var<const CPUInfo> CPUInfo_cvar;
// ���������� � �������� ����������
class CPUInfo
	: virtual public ::Core::IObject
{
public:
	// ������� ���������� � MHz.
	virtual unsigned long get_frequency () const
		/*throw (ResourceSystemError)*/ = 0;

	// ������������� ����������
	virtual const std::string get_identifier () const
		/*throw (ResourceSystemError)*/ = 0;

	// ��� ����������
	virtual const std::string get_name () const
		/*throw (ResourceSystemError)*/ = 0;
};

/// factory interface for CPUInfo
class CPUInfoFactory {
public:
	// �������� ������
	static CPUInfo& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/;
};

#pragma pack (push, 1)

// ���������� � ������ � �������
struct SystemMemoryData {
	// ��������� ������ ���������� ������ �� ������ (� ������)
	ACE_UINT64 available_memory_size;
	// ������ ���������� ���������� ������������ ��� �������� �� ������ (� ������)
	ACE_UINT64 available_virtual_memory_size;
	// ����� ������ ���������� ������ �� ������ (� ������)
	ACE_UINT64 full_memory_size;
	// ������ ���������� ������������ ��� �������� �� ������ (� ������)
	ACE_UINT64 virtual_memory_size;
	// ����� ����� ����������� ������ �� ���������� (� ������)
	ACE_UINT64 total_page_file_size;
	// ��������� ����� ����������� ������ �� ���������� (� ������)
	ACE_UINT64 available_page_file_size;
};

#pragma pack (pop)

#pragma pack (push, 1)

// ���������� � ���������� ������
struct ProcessMemoryData {
	// ������� ���������� ������������ ������ (� ������)
	ACE_UINT64 current_usage;
	// ������������ ���������� ������������ ������ (� ������)
	ACE_UINT64 max_usage;
	// ������� ������� �������
	unsigned long page_fault_count;
	// ������ ��������� ������������, ���������� �������� (� ������)
	ACE_UINT64 vm_usage;
};

#pragma pack (pop)

class ProcessMemoryInfo;
typedef ::Core::Var<ProcessMemoryInfo> ProcessMemoryInfo_var;
typedef ::Core::Var<const ProcessMemoryInfo> ProcessMemoryInfo_cvar;
// ������ � ������, ������������ ���������
class ProcessMemoryInfo
	: virtual public ::Core::IObject
{
public:
	// ������� ���������� ������������ ������ (� ������)
	virtual ACE_UINT64 get_current_usage () const
		/*throw (ResourceSystemError)*/ = 0;

	// ������������ ���������� ������������ ������ (� ������)
	virtual ACE_UINT64 get_max_usage () const
		/*throw (ResourceSystemError)*/ = 0;

	// ������ ��������� ������������, ���������� �������� (� ������)
	virtual ACE_UINT64 get_vm_usage () const
		/*throw (ResourceSystemError)*/ = 0;

	// ������� ������� �������
	virtual unsigned long get_page_fault_count () const
		/*throw (ResourceSystemError)*/ = 0;

	// ���������� � ������ ���������� ���������
	virtual const ProcessMemoryData get_memory_info () const = 0;
};

/// factory interface for ProcessMemoryInfo
class ProcessMemoryInfoFactory {
public:
	// �������� ������
	static ProcessMemoryInfo& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/;
};

class PhysicalMemoryInfo;
typedef ::Core::Var<PhysicalMemoryInfo> PhysicalMemoryInfo_var;
typedef ::Core::Var<const PhysicalMemoryInfo> PhysicalMemoryInfo_cvar;
// ���������� � ���������� ������ �� ������
class PhysicalMemoryInfo
	: virtual public ::Core::IObject
{
public:
	// ����� ������ ���������� ������ �� ������ (� ������)
	virtual ACE_UINT64 get_full_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// ��������� ������ ���������� ������ �� ������ (� ������)
	virtual ACE_UINT64 get_available_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// ������ ���������� ������������ ��� �������� �� ������ (� ������)
	virtual ACE_UINT64 get_virtual_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// ������ ���������� ���������� ������������ ��� �������� �� ������ (� ������)
	virtual ACE_UINT64 get_available_virtual_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// ���������� � ������ � �������
	virtual const SystemMemoryData get_memory_info () const = 0;

	// ����� ����� ����������� ������ �� ���������� (� ������)
	virtual const ACE_UINT64 get_total_page_file_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// ��������� ����� ����������� ������ �� ���������� (� ������)
	virtual const ACE_UINT64 get_available_page_file_size () const
		/*throw (ResourceSystemError)*/ = 0;
};

/// factory interface for PhysicalMemoryInfo
class PhysicalMemoryInfoFactory {
public:
	// �������� ������
	static PhysicalMemoryInfo& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/;
};

} // namespace ResourceInfo
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::ResourceInfo::CPUInfo> {
	typedef GCI::ResourceInfo::CPUInfoFactory Factory;
};
template <>
struct TypeTraits <GCI::ResourceInfo::ProcessMemoryInfo> {
	typedef GCI::ResourceInfo::ProcessMemoryInfoFactory Factory;
};
template <>
struct TypeTraits <GCI::ResourceInfo::PhysicalMemoryInfo> {
	typedef GCI::ResourceInfo::PhysicalMemoryInfoFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_RESOURCEINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
