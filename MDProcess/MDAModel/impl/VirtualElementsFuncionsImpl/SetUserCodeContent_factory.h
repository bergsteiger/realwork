////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetUserCodeContent
// �������� ���������� ������ ���������  ��� �������� SetUserCodeContent
//
// %S%f_set_uc_content(gen_id, uc_id,content) - ��������� ���������� ���������� ��� ����������
// gen_id
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETUSERCODECONTENT_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETUSERCODECONTENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for SetUserCodeContent
class SetUserCodeContent_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	SetUserCodeContent_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<SetUserCodeContent_factory> SetUserCodeContent_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETUSERCODECONTENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

