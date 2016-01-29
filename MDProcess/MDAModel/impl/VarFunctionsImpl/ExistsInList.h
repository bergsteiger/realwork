////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ExistsInList
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _exists_in_list.
// _exists_in_list (�������������, ���������) - ��������� ������� � ������ � ��������
// ��������������� �������� (����� ���� ������� ������ ��� ������), ���������� true ��� false
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_EXISTSINLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_EXISTSINLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class ExistsInList; // self forward Var
typedef ::Core::Var<ExistsInList> ExistsInList_var;
typedef ::Core::Var<const ExistsInList> ExistsInList_cvar;

class ExistsInList_factory;

// ���������� ���������� ������� ���������� _exists_in_list.
// _exists_in_list (�������������, ���������) - ��������� ������� � ������ � ��������
// ��������������� �������� (����� ���� ������� ������ ��� ������), ���������� true ��� false
class ExistsInList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (ExistsInList)
	friend class ExistsInList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExistsInList ();

	virtual ~ExistsInList ();

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
}; // class ExistsInList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_EXISTSINLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
