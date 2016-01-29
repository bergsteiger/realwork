////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToBorland_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToBorland
//
// ���������� ���������� ������� ���������� "_to_borland"
// _to_borland (<������>) - ������������ ������ <������> � ����� �Borland� - ��������� �����
// ������� � ���������� � ��������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToBorland_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToBorland.h"

namespace SystemFunctionsImpl {

ToBorland_factory::ToBorland_factory () {
}

void ToBorland_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ToBorland_factory::key () const {
	return "_to_borland";
}

TemplateFunctions::InternalFunction* ToBorland_factory::make () {
	ToBorland_var ret = new ToBorland ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

