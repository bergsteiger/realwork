////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::StartLocal
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_STARTLOCAL_H__
#define __GARANT6X_GBLADAPTERLIB_STARTLOCAL_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GblAdapterLib {
namespace StartLocal {

class BaseUpdateChecker;
typedef ::Core::Var<BaseUpdateChecker> BaseUpdateChecker_var;
typedef ::Core::Var<const BaseUpdateChecker> BaseUpdateChecker_cvar;
// �������� ���� ��� ���������� ����.
// ����� � ��������������� �������, ����������� ������� ��� ���������� ����,  ������������� ��
// BaseUpdateChecker � ���������� �� ��� �����:
// void clear_cache () const;
// ��� ������ ���� ��� (���������) ���������� ���� �������� "check_update_and_clear_cache"
class BaseUpdateChecker
	: virtual public ::Core::IObject
{
public:
	// ����� ���������� ��� ���������� ����
	virtual void check_update_and_clear_cache () const = 0;
};

} // namespace StartLocal
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_STARTLOCAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
