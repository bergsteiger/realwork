////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/ResourceInfoImpl/CPUInfo.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::CPUInfo
// ��������� ���������� ������ �������� ��� ��������� CPUInfo
//
// ��������� ���������� � ���������� �� ������� ��
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOIMPL_CPUINFO_H__
#define __SHARED_GCI_RESOURCEINFOIMPL_CPUINFO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

class CPUInfo; // self forward Var
typedef ::Core::Var<CPUInfo> CPUInfo_var;
typedef ::Core::Var<const CPUInfo> CPUInfo_cvar;

class CPUInfo_factory;

// ��������� ���������� � ���������� �� ������� ��
class CPUInfo:
	virtual public ResourceInfo::CPUInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CPUInfo)
	friend class CPUInfo_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CPUInfo ();

	virtual ~CPUInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ResourceInfo::CPUInfo
	// ������� ���������� � MHz.
	virtual unsigned long get_frequency () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::CPUInfo
	// ������������� ����������
	virtual const std::string get_identifier () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::CPUInfo
	// ��� ����������
	virtual const std::string get_name () const
		/*throw (ResourceInfo::ResourceSystemError)*/;
}; // class CPUInfo

} // namespace ResourceInfoImpl
} // namespace GCI


#endif //!WIN32
#endif //__SHARED_GCI_RESOURCEINFOIMPL_CPUINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
