////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::MetadataFunctionsImpl::AddMetadatas
//
// ������� ���������� ���������� � ��������, ��� ���������� ��������� ��� ���������� �����
// ��������� � ��������, ��������� � ���������.
// _add_metadatas (�������, ����� �����������, �������������� ������ � �����������). ���� ������
// � �������������� ������ � ����������� �� ������, �� ���� �������� ���������������� ���
// ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas_factory.h"
#include "MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas.h"

namespace MetadataFunctionsImpl {

AddMetadatas_factory::AddMetadatas_factory () {
}

void AddMetadatas_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddMetadatas_factory::key () const {
	return "_add_metadatas";
}

TemplateFunctions::InternalFunction* AddMetadatas_factory::make () {
	AddMetadatas_var ret = new AddMetadatas ();
	return ret._retn ();
}

} // namespace MetadataFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

