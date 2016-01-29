////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::ReportBuilderImpl
// ��������� ���������� ������ �������� ��� ��������� ReportBuilder
//
// ���������� ������������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"

namespace HelpersImpl {

class ReportBuilderImpl; // self forward Var
typedef ::Core::Var<ReportBuilderImpl> ReportBuilderImpl_var;
typedef ::Core::Var<const ReportBuilderImpl> ReportBuilderImpl_cvar;

class ReportBuilderImpl_factory;

// ���������� ������������ ������
class ReportBuilderImpl:
	virtual public Helpers::ReportBuilder
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ReportBuilderImpl)
	friend class ReportBuilderImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ReportBuilderImpl ();

	virtual ~ReportBuilderImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Helpers::ReportBuilder
	// ��������� ������ ������ � �������� � ���� ��� �����
	virtual Helpers::ReportResult* build (
		const RoseAbstractDumper* from
		, const AbstractDumperBase::ReportsTreeItem* report
	) const;
}; // class ReportBuilderImpl

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
