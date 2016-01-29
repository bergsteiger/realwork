////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::FindElement
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _find_element.
// _find_element(��������������|����, ������������) - ������� ������� �� ����� ��� ��
// �������������� � ���������� ��� � ����������. ������ �������� ������� ���������������� ���
// ������������� ��������, ���� ������� � ����� ��������������� �� ��� ������, �� ��������
// ���������������� ��� ��� ��������, ������ ��� ����� ����������� � ������ ���� �� ���� ��
// �������� (��� ��������� ������). ���� � ���������� ������ �� ����� ������� ����� ������ ��������
// - ������������� ����������. ��������:
// {code}
// %S%f_find_element(%SU, SELF)  - ���������� SELF ���� ��������� �� ������� ������� (S)
// %S%f_set_var (A::B::attr, ATTR)  - ���������� ATTR ����� ��������� �� �������, �� ��������
// ������ ���� �� ���� ������������� �� "A::B::attr"
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace VarFunctionsImpl {

class FindElement; // self forward Var
typedef ::Core::Var<FindElement> FindElement_var;
typedef ::Core::Var<const FindElement> FindElement_cvar;

class FindElement_factory;

// ���������� ���������� ������� ���������� _find_element.
// _find_element(��������������|����, ������������) - ������� ������� �� ����� ��� ��
// �������������� � ���������� ��� � ����������. ������ �������� ������� ���������������� ���
// ������������� ��������, ���� ������� � ����� ��������������� �� ��� ������, �� ��������
// ���������������� ��� ��� ��������, ������ ��� ����� ����������� � ������ ���� �� ���� ��
// �������� (��� ��������� ������). ���� � ���������� ������ �� ����� ������� ����� ������ ��������
// - ������������� ����������. ��������:
// {code}
// %S%f_find_element(%SU, SELF)  - ���������� SELF ���� ��������� �� ������� ������� (S)
// %S%f_set_var (A::B::attr, ATTR)  - ���������� ATTR ����� ��������� �� �������, �� ��������
// ������ ���� �� ���� ������������� �� "A::B::attr"
// {code}
class FindElement:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (FindElement)
	friend class FindElement_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FindElement ();

	virtual ~FindElement ();

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
}; // class FindElement

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
