////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddParameter
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_add_parameter(<GUID ������ ��������>, ,<���������>,<��������� ���������>,<��� ����������>) -
// ���������� _add_attribute, �� ��������� ����� �������� .
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDPARAMETER_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDPARAMETER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddParameter; // self forward Var
typedef ::Core::Var<AddParameter> AddParameter_var;
typedef ::Core::Var<const AddParameter> AddParameter_cvar;

class AddParameter_factory;

// %S%f_add_parameter(<GUID ������ ��������>, ,<���������>,<��������� ���������>,<��� ����������>) -
// ���������� _add_attribute, �� ��������� ����� �������� .
class AddParameter:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddParameter)
	friend class AddParameter_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddParameter ();

	virtual ~AddParameter ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddParameter

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDPARAMETER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
