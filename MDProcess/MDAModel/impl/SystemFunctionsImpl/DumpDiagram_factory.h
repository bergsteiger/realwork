////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DumpDiagram
// �������� ���������� ������ ���������  ��� �������� DumpDiagram
//
// ���������� ���������� ������� ���������� "_dump_diagram".
// _dump_diagram(���������) - �������� �������� �������� ��� ��������� - �������� � � ��������
// ����� � ������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DUMPDIAGRAM_FCTR_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DUMPDIAGRAM_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace SystemFunctionsImpl {

/// Interface-factory implementation for DumpDiagram
class DumpDiagram_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	DumpDiagram_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<DumpDiagram_factory> DumpDiagram_factory_var;

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DUMPDIAGRAM_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

