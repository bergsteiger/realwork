////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::UpsToList
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _ups_to_list.
// _ups_to_list (��������, ��������������) - ��������� � ������ c �������� ���������������
// ���������������� ���������� � �������: ���� �������� = ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_UPSTOLIST_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_UPSTOLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class UpsToList; // self forward Var
typedef ::Core::Var<UpsToList> UpsToList_var;
typedef ::Core::Var<const UpsToList> UpsToList_cvar;

class UpsToList_factory;

// ���������� ���������� ������� ���������� _ups_to_list.
// _ups_to_list (��������, ��������������) - ��������� � ������ c �������� ���������������
// ���������������� ���������� � �������: ���� �������� = ���������
class UpsToList:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (UpsToList)
	friend class UpsToList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UpsToList ();

	virtual ~UpsToList ();

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
}; // class UpsToList

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_UPSTOLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
