////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::KViewElementImpl
// �������� ���������� ������ ��������� KViewElement ��� �������� KViewElementImpl
//
// ��������� �������� �������� � � ��������� ��������� ������� ShellExecute
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"

namespace HelpersImpl {

/// Interface-factory implementation for KViewElementImpl
class KViewElementImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Helpers::KViewElementAbstractFactory
{
public:
	KViewElementImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Helpers::KViewElement* get ();

};

typedef ::Core::Var<KViewElementImpl_factory> KViewElementImpl_factory_var;

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

