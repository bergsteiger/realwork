////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::SetGenID
// �������� ���������� ������ ���������  ��� �������� SetGenID
//
// ���������� ���������� ������� ���������� "_set_gen_id"
// _set_gen_id(�gen id�) - ������������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETGENID_FCTR_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETGENID_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace SystemFunctionsImpl {

/// Interface-factory implementation for SetGenID
class SetGenID_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	SetGenID_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<SetGenID_factory> SetGenID_factory_var;

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETGENID_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

