////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetPreUserCodeContent
// �������� ���������� ������ ���������  ��� �������� SetPreUserCodeContent
//
// %S%f_set_pre_uc_content(gen_id, uc_id,content) - ��������� �������������� ��� ����� �����������
// �������� uc_id ��� ���������� gen_id
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPREUSERCODECONTENT_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPREUSERCODECONTENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for SetPreUserCodeContent
class SetPreUserCodeContent_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	SetPreUserCodeContent_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<SetPreUserCodeContent_factory> SetPreUserCodeContent_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPREUSERCODECONTENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

