////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddParameter
// �������� ���������� ������ ���������  ��� �������� AddParameter
//
// %S%f_add_parameter(<GUID ������ ��������>, ,<���������>,<��������� ���������>,<��� ����������>) -
// ���������� _add_attribute, �� ��������� ����� �������� .
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDPARAMETER_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDPARAMETER_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for AddParameter
class AddParameter_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	AddParameter_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<AddParameter_factory> AddParameter_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDPARAMETER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

