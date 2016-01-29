////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AppendTextAction
// ��������� ���������� ������ �������� ��� ��������� KPageAction
//
// ���������� ������� APPEND. ������ ����� �������� �� ����� � ���������� ��� � ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_APPENDTEXTACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_APPENDTEXTACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class AppendTextAction; // self forward Var
typedef ::Core::Var<AppendTextAction> AppendTextAction_var;
typedef ::Core::Var<const AppendTextAction> AppendTextAction_cvar;

class AppendTextAction_factory;

// ���������� ������� APPEND. ������ ����� �������� �� ����� � ���������� ��� � ��������.
class AppendTextAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AppendTextAction)
	friend class AppendTextAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AppendTextAction ();

	virtual ~AppendTextAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
	// (����������� � ���������� ����).
	// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class AppendTextAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_APPENDTEXTACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
