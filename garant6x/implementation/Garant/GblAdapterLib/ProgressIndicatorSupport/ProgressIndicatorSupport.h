////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GblAdapterLib {

class ProgressIndicator;
typedef ::Core::Var<ProgressIndicator> ProgressIndicator_var;
typedef ::Core::Var<const ProgressIndicator> ProgressIndicator_cvar;
// ��������� ��� �������� ����� ��� ���������� ��������� �� �������.
// ������ ��������������� ������������� ��������.
class ProgressIndicator
	: virtual public ::Core::IObject
{
public:
	virtual long get_max_count () const = 0;

	// ��������� ��������� ����������� ��������.
	// � �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, �����������
	// ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %).
	virtual void set_current (long cur_count, long arg) const = 0;
};

class CancelLongProcess;
typedef ::Core::Var<CancelLongProcess> CancelLongProcess_var;
typedef ::Core::Var<const CancelLongProcess> CancelLongProcess_cvar;
// ��������� ��� ����������� ���������� ���������� �������� �� �������. ������������ � ����������
// IProgressIndicator.
class CancelLongProcess
	: virtual public ::Core::IObject
{
public:
	// ���������� ��� ���������� ����������� ��������.
	virtual void cancel_process () const = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
