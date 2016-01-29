////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::StereotypeManagerImpl
// �������� ���������� ������ ��������� StereotypeManager ��� �������� StereotypeManagerImpl
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"

namespace HelpersImpl {

/// Interface-factory implementation for StereotypeManagerImpl
class StereotypeManagerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Helpers::StereotypeManagerAbstractFactory
{
public:
	StereotypeManagerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Helpers::StereotypeManager* make ();

};

typedef ::Core::Var<StereotypeManagerImpl_factory> StereotypeManagerImpl_factory_var;

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

