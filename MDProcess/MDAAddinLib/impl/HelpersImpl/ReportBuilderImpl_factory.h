////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::ReportBuilderImpl
// �������� ���������� ������ ��������� ReportBuilder ��� �������� ReportBuilderImpl
//
// ���������� ������������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"

namespace HelpersImpl {

/// Interface-factory implementation for ReportBuilderImpl
class ReportBuilderImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Helpers::ReportBuilderAbstractFactory
{
public:
	ReportBuilderImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Helpers::ReportBuilder* make ();

};

typedef ::Core::Var<ReportBuilderImpl_factory> ReportBuilderImpl_factory_var;

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

