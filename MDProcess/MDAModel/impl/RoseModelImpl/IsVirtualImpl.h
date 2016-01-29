////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::IsVirtualImpl
// ��������� ���������� ������ �������� ��� ��������� IsVirtual
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_ISVIRTUALIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_ISVIRTUALIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class IsVirtualImpl; // self forward Var
typedef ::Core::Var<IsVirtualImpl> IsVirtualImpl_var;
typedef ::Core::Var<const IsVirtualImpl> IsVirtualImpl_cvar;

class IsVirtualImpl_factory;

// ����������
class IsVirtualImpl:
	virtual public IsVirtual
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (IsVirtualImpl)
	friend class IsVirtualImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	IsVirtualImpl ();

	virtual ~IsVirtualImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IsVirtual
	// ���������� true, ���� ������� �����������
	virtual bool execute (IRoseElementPtr elem) const;
}; // class IsVirtualImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_ISVIRTUALIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
