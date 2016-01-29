////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/ResourceInfoWin32Impl/CPUInfo.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::CPUInfo
// ��������� ���������� ������ �������� ��� ��������� CPUInfo
//
// ��������� ���������� � ���������� �� ������� ��
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOWIN32IMPL_CPUINFO_H__
#define __SHARED_GCI_RESOURCEINFOWIN32IMPL_CPUINFO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

#if defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

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
// nested declorations
private:
	// ��������� � ������� ��� ��������� ���������� � ����������.
	static const char* CPU_REG_SUBKEY; // ����� �������, � ������� ��������� ���������� � ��������
	static const char* CPU_IDENTIFIER; // ���� � �������, �� �������� ������ ������������� ����������
	static const char* CPU_NAME; // ���� � �������, �� �������� ������� ��� ����������.
	static const char* CPU_FREQUENCY; // ���� � �������, �� �������� ������� ������� ����������

	// auto ptr ��� HKEY
	struct HKEY_aptr {
		// ����������
		HKEY h_key;

		~HKEY_aptr ();

		HKEY_aptr (HKEY key);
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CPUInfo ();

	virtual ~CPUInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������� ����� � �������, � ������ ������ ���������� ���������� �����, � ������ ������� ������
	// ����������.
	virtual HKEY open_cpu_reg_key () const /*throw (ResourceInfo::ResourceSystemError)*/;

	// ������ ������ � ������� �� �����
	virtual const std::string read_string_from_reg (
		HKEY h_key
		, const char* key
	) const /*throw (
		ResourceInfo::ResourceSystemError
	)*/;


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

} // namespace ResourceInfoWin32Impl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_RESOURCEINFOWIN32IMPL_CPUINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
