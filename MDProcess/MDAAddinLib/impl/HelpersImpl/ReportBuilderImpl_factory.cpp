////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::ReportBuilderImpl
//
// ���������� ������������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl.h"

namespace HelpersImpl {

ReportBuilderImpl_factory::ReportBuilderImpl_factory () {
}

void ReportBuilderImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Helpers::ReportBuilderFactoryManager::register_factory (this, priority);
}

const char* ReportBuilderImpl_factory::key () const {
	return "ReportBuilderImpl";
}

Helpers::ReportBuilder* ReportBuilderImpl_factory::make () {
	ReportBuilderImpl_var ret = new ReportBuilderImpl ();
	return ret._retn ();
}

} // namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

