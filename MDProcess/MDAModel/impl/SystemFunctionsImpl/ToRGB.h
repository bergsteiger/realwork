////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToRGB
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _to_rgb
// _to_rgb(������, �������������) - ����������� ���� �������� ������ � ������ RGB, ����������
// �������, ������������� - ����������� ������������ ��� ��������� ������ (�� ���������
// ������������ ","), ��������:
// %f_to_rgb(100) - ����� 100,0,0
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TORGB_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TORGB_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ToRGB; // self forward Var
typedef ::Core::Var<ToRGB> ToRGB_var;
typedef ::Core::Var<const ToRGB> ToRGB_cvar;

class ToRGB_factory;

// ���������� ���������� ������� ���������� _to_rgb
// _to_rgb(������, �������������) - ����������� ���� �������� ������ � ������ RGB, ����������
// �������, ������������� - ����������� ������������ ��� ��������� ������ (�� ���������
// ������������ ","), ��������:
// %f_to_rgb(100) - ����� 100,0,0
class ToRGB:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToRGB)
	friend class ToRGB_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToRGB ();

	virtual ~ToRGB ();

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
}; // class ToRGB

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TORGB_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
