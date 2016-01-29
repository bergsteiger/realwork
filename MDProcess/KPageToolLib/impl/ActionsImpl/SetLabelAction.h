////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SetLabelAction.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::SetLabelAction
// ��������� ���������� ������ �������� ��� ��������� KPageAction
//
// ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETLABELACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETLABELACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class SetLabelAction; // self forward Var
typedef ::Core::Var<SetLabelAction> SetLabelAction_var;
typedef ::Core::Var<const SetLabelAction> SetLabelAction_cvar;

class SetLabelAction_factory;

// ���������� ������
class SetLabelAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SetLabelAction)
	friend class SetLabelAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetLabelAction ();

	virtual ~SetLabelAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
	// (����������� � ���������� ����).
	// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class SetLabelAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETLABELACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
