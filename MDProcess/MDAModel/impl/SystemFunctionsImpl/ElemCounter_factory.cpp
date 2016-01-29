////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ElemCounter_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ElemCounter
//
// ���������� ���������� ������� ���������� "_elem_counter".
// _elem_counter (�counter id�,�value�) - �������� ����� �������� � ����������� ������������������.
// ������� ��������� � ������������������ ������������ �������� ������� ������ ������ ������� ��
// ������ �� ���������. ��������:<%f_elem_counter(NUM_IN_PARTENT,C)>
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ElemCounter_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ElemCounter.h"

namespace SystemFunctionsImpl {

ElemCounter_factory::ElemCounter_factory () {
}

void ElemCounter_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ElemCounter_factory::key () const {
	return "_elem_counter";
}

TemplateFunctions::InternalFunction* ElemCounter_factory::make () {
	ElemCounter_var ret = new ElemCounter ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

