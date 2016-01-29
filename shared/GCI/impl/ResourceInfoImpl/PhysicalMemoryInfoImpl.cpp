////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::PhysicalMemoryInfoImpl
//
// �������� ���������� � ��������� ������ ��������� API windows
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PhysicalMemoryInfoImpl::PhysicalMemoryInfoImpl ()
//#UC START# *46DE964F02FD_49990CEB0074_4999175A010D_BASE_INIT*
//#UC END# *46DE964F02FD_49990CEB0074_4999175A010D_BASE_INIT*
{
	//#UC START# *46DE964F02FD_49990CEB0074_4999175A010D_BODY*
	throw GCI::ResourceInfo::NotSupported ();
	//#UC END# *46DE964F02FD_49990CEB0074_4999175A010D_BODY*
}

PhysicalMemoryInfoImpl::~PhysicalMemoryInfoImpl () {
	//#UC START# *4999175A010D_DESTR_BODY*
	//#UC END# *4999175A010D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ResourceInfo::PhysicalMemoryInfo
// ��������� ������ ���������� ������ �� ������ (� ������)
ACE_UINT64 PhysicalMemoryInfoImpl::get_available_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE995C006D_4999175A010D_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46DE995C006D_4999175A010D_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// ��������� ����� ����������� ������ �� ���������� (� ������)
const ACE_UINT64 PhysicalMemoryInfoImpl::get_available_page_file_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49A7CCD4005C_4999175A010D_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49A7CCD4005C_4999175A010D_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// ������ ���������� ���������� ������������ ��� �������� �� ������ (� ������)
ACE_UINT64 PhysicalMemoryInfoImpl::get_available_virtual_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE9A25006D_4999175A010D_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46DE9A25006D_4999175A010D_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// ����� ������ ���������� ������ �� ������ (� ������)
ACE_UINT64 PhysicalMemoryInfoImpl::get_full_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE98840242_4999175A010D_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46DE98840242_4999175A010D_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// ���������� � ������ � �������
const ResourceInfo::SystemMemoryData PhysicalMemoryInfoImpl::get_memory_info () const {
	//#UC START# *499955D302CC_4999175A010D_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *499955D302CC_4999175A010D_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// ����� ����� ����������� ������ �� ���������� (� ������)
const ACE_UINT64 PhysicalMemoryInfoImpl::get_total_page_file_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49A7CCAB03DB_4999175A010D_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49A7CCAB03DB_4999175A010D_GET*
}

// implemented method from ResourceInfo::PhysicalMemoryInfo
// ������ ���������� ������������ ��� �������� �� ������ (� ������)
ACE_UINT64 PhysicalMemoryInfoImpl::get_virtual_memory_size () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DE997601A5_4999175A010D_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46DE997601A5_4999175A010D_GET*
}
} // namespace ResourceInfoImpl
} // namespace GCI

#endif //!WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

