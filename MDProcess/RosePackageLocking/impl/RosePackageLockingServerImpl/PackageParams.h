////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageParams.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::PackageParams
//
// ��������� ��� ���������� ���������� � ����������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGEPARAMS_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGEPARAMS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

// ��������� ��� ���������� ���������� � ����������� �������
class PackageParams {

// static member methods and data
public:
	// ������� � ��������, ����� ������� ������ ����� ��������� ���������� � �������� � ����.
	static const CORBA::ULong get_flush_timeout () /* throw (Core::ParameterIsMissing) */;
	static void set_flush_timeout (CORBA::ULong value);
	static const char* flush_timeout_param_name ();

	// ��� �����-��������� � ����������� � ���������� �������.
	static const std::string get_storage_file () /* throw (Core::ParameterIsMissing) */;
	static void set_storage_file (const std::string& value);
	static const char* storage_file_param_name ();

}; // class PackageParams

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGEPARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

