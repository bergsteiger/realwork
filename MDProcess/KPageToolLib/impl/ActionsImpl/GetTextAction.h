////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetTextAction
// ��������� ���������� ������ �������� ��� ��������� KPageAction
//
// ���������� ������� GET. ������ ����� �������� � � ���������� ��� � ����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class GetTextAction; // self forward Var
typedef ::Core::Var<GetTextAction> GetTextAction_var;
typedef ::Core::Var<const GetTextAction> GetTextAction_cvar;

class GetTextAction_factory;

// ���������� ������� GET. ������ ����� �������� � � ���������� ��� � ����.
class GetTextAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (GetTextAction)
	friend class GetTextAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GetTextAction ();

	virtual ~GetTextAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
	// (����������� � ���������� ����).
	// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class GetTextAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
