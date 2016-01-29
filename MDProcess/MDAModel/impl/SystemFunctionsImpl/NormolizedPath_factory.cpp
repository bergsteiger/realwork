////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NormolizedPath
//
// ���������� ���������� ������� ���������� "_normolized_path".
// _normolized_path(�������� ���������,��������), ��������:
// %f_normolized_path(dll.h,C)
// - ������� ���� � ��� ����� ��������� ��� �������� ��������, ������������ ���� � ����� ���������
// �������� ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath.h"

namespace SystemFunctionsImpl {

NormolizedPath_factory::NormolizedPath_factory () {
}

void NormolizedPath_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string NormolizedPath_factory::key () const {
	return "_normolized_path";
}

TemplateFunctions::InternalFunction* NormolizedPath_factory::make () {
	NormolizedPath_var ret = new NormolizedPath ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

