////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/IsEqualList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::IsEqualList
// ��������� ���������� ������ �������� ��� ��������� 
//
// ������� ��������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEQUALLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEQUALLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class IsEqualList; // self forward Var
typedef ::Core::Var<IsEqualList> IsEqualList_var;
typedef ::Core::Var<const IsEqualList> IsEqualList_cvar;

class IsEqualList_factory;

// ������� ��������� �������
class IsEqualList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (IsEqualList)
	friend class IsEqualList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	IsEqualList ();

	virtual ~IsEqualList ();

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
}; // class IsEqualList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEQUALLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
