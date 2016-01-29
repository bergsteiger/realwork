////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOperation
//
// 1. %S%f_add_operation(<GUID ������ ��������>,<���������>, <��� ��������>,<��� ����������>,<���
// ����������>) - ������� ����� ������� - �������� � �������� ������ � �����������, ��������� ��� �
// ���������� � ��������� ��� ������� � �������� ��������, ��� �������� �������� ���� ������
// ������������� ��������, ���� ������ ������ ���� - � ���� ������ � ������ ����� �������� �������
// � ����� ������.
// 2. %S%f_add_operation(<GUID ������ ��������>, <���������>,<��� �������� � ���������� �
// �����������>,<��� ����������>) - ������� ����� ������� - �������� ��� �������� ��� ����������, �
// ����� ��������� �������� ������ ����������, � �������: <��� ��������> (<������������ ���������>
// <��� ���������> : <��� ��������� (GUID ��� ������) = <�������� �� ��������� (GUID ���
// ������)>>):<GUID ��� ��� ������������ ���������>
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation.h"

namespace VirtualElementsFuncionsImpl {

AddOperation_factory::AddOperation_factory () {
}

void AddOperation_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddOperation_factory::key () const {
	return "_add_operation";
}

TemplateFunctions::InternalStereotypeFunction* AddOperation_factory::make () {
	AddOperation_var ret = new AddOperation ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

