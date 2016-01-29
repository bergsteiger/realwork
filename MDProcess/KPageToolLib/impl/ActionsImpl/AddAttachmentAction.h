////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AddAttachmentAction
// ��������� ���������� ������ �������� ��� ��������� KPageAction
//
// AddAttachmentAction
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class AddAttachmentAction; // self forward Var
typedef ::Core::Var<AddAttachmentAction> AddAttachmentAction_var;
typedef ::Core::Var<const AddAttachmentAction> AddAttachmentAction_cvar;

class AddAttachmentAction_factory;

// AddAttachmentAction
class AddAttachmentAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AddAttachmentAction)
	friend class AddAttachmentAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddAttachmentAction ();

	virtual ~AddAttachmentAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
	// (����������� � ���������� ����).
	// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class AddAttachmentAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
