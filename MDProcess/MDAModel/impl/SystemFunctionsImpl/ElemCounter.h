////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ElemCounter.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ElemCounter
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_elem_counter".
// _elem_counter (�counter id�,�value�) - �������� ����� �������� � ����������� ������������������.
// ������� ��������� � ������������������ ������������ �������� ������� ������ ������ ������� ��
// ������ �� ���������. ��������:<%f_elem_counter(NUM_IN_PARTENT,C)>
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ELEMCOUNTER_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ELEMCOUNTER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ElemCounter; // self forward Var
typedef ::Core::Var<ElemCounter> ElemCounter_var;
typedef ::Core::Var<const ElemCounter> ElemCounter_cvar;

class ElemCounter_factory;

// ���������� ���������� ������� ���������� "_elem_counter".
// _elem_counter (�counter id�,�value�) - �������� ����� �������� � ����������� ������������������.
// ������� ��������� � ������������������ ������������ �������� ������� ������ ������ ������� ��
// ������ �� ���������. ��������:<%f_elem_counter(NUM_IN_PARTENT,C)>
class ElemCounter:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ElemCounter)
	friend class ElemCounter_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ElemCounter ();

	virtual ~ElemCounter ();

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
}; // class ElemCounter

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ELEMCOUNTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
