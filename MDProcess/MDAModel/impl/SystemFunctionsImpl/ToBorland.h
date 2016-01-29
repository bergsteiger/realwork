////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToBorland.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToBorland
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_to_borland"
// _to_borland (<������>) - ������������ ������ <������> � ����� �Borland� - ��������� �����
// ������� � ���������� � ��������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOBORLAND_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOBORLAND_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ToBorland; // self forward Var
typedef ::Core::Var<ToBorland> ToBorland_var;
typedef ::Core::Var<const ToBorland> ToBorland_cvar;

class ToBorland_factory;

// ���������� ���������� ������� ���������� "_to_borland"
// _to_borland (<������>) - ������������ ������ <������> � ����� �Borland� - ��������� �����
// ������� � ���������� � ��������� ����
class ToBorland:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToBorland)
	friend class ToBorland_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToBorland ();

	virtual ~ToBorland ();

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
}; // class ToBorland

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOBORLAND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
