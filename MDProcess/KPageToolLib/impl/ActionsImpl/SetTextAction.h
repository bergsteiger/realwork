////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::SetTextAction
// ��������� ���������� ������ �������� ��� ��������� KPageAction
//
// ���������� ������� SET. ������ ����� �������� �� ����� � ���������� ��� � ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETTEXTACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETTEXTACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class SetTextAction; // self forward Var
typedef ::Core::Var<SetTextAction> SetTextAction_var;
typedef ::Core::Var<const SetTextAction> SetTextAction_cvar;

class SetTextAction_factory;

// ���������� ������� SET. ������ ����� �������� �� ����� � ���������� ��� � ��������.
class SetTextAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SetTextAction)
	friend class SetTextAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetTextAction ();

	virtual ~SetTextAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
	// (����������� � ���������� ����).
	// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class SetTextAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETTEXTACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
