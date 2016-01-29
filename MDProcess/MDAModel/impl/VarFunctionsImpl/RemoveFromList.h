////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::RemoveFromList
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _remove_from_list.
// _remove_from_list (�������������, ���������) - ������� �� ������ c �������� ���������������
// ������� (����� ���� ������� ������ ��� ������).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_REMOVEFROMLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_REMOVEFROMLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class RemoveFromList; // self forward Var
typedef ::Core::Var<RemoveFromList> RemoveFromList_var;
typedef ::Core::Var<const RemoveFromList> RemoveFromList_cvar;

class RemoveFromList_factory;

// ���������� ���������� ������� ���������� _remove_from_list.
// _remove_from_list (�������������, ���������) - ������� �� ������ c �������� ���������������
// ������� (����� ���� ������� ������ ��� ������).
class RemoveFromList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (RemoveFromList)
	friend class RemoveFromList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveFromList ();

	virtual ~RemoveFromList ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class RemoveFromList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_REMOVEFROMLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
