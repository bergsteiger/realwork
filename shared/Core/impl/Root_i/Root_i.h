////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/impl/Root_i/Root_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::Core::Root_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_H__
#define __SHARED_CORE_ROOT_I_H__

#include "ace/ACE.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/Params/Params.h"


namespace Core {
namespace Root_i {

class LibHomeLocal;
typedef ::Core::Var<LibHomeLocal> LibHomeLocal_var;
typedef ::Core::Var<const LibHomeLocal> LibHomeLocal_cvar;
// ��������� ���������, ����� ��� �������������� ����������������, ��������� ������ ����������
// ����������.
class LibHomeLocal
	: virtual public Root::LibHome
{
public:
	// ��������� ���������� ��� ������� ���� ������������ ��������� � �����������
	virtual void execute () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/ = 0;

	// ���������� ����������� ��� ������������ ���� �������� ��������� � ���������� ��-
	// ����������������� ��������, ����� ��������� ���������
	virtual void finalize () = 0;

	// ���������� ���������� ��� ������������ �����������
	virtual void initialize () = 0;

	// ��������� ��������� ���������� (������� ������������ ����������)
	virtual bool check_params () const = 0;

	// ������� �������� ���������� ���������� � ����������� �����
	virtual void print_usage () const = 0;

	// ���������� ����������� ��� ����������� ������ ���� ��������� ������������ � ���������
	virtual void registrate_all_factories () const = 0;
};

} //namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

