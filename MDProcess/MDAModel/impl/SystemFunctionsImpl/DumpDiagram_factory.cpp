////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DumpDiagram
//
// ���������� ���������� ������� ���������� "_dump_diagram".
// _dump_diagram(���������) - �������� �������� �������� ��� ��������� - �������� � � ��������
// ����� � ������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram.h"

namespace SystemFunctionsImpl {

DumpDiagram_factory::DumpDiagram_factory () {
}

void DumpDiagram_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string DumpDiagram_factory::key () const {
	return "_dump_diagram";
}

TemplateFunctions::InternalFunction* DumpDiagram_factory::make () {
	DumpDiagram_var ret = new DumpDiagram ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

