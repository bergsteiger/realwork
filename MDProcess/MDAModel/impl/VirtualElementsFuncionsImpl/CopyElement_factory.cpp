////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyElement
//
// %S%f_copy_element(<��� ������ ��������>, <��� ��� ��� ��������>,<��������� ������ ��������>,<���
// ������ ��������>,<������ ����������� (� ������) ��� ���>,<��� ���������� � ������� ���������
// ����� �������>) - ������� ����������� ��������, ���� ������ ������ ����������� - �� ����������
// ��� ���� �������� ����������. ������ �������������:
// {code}
// %S%f_copy_element(_COPY,,factory,new_make,true,VAR) - ��������� ������� � �������� �����������
// ��������, � ������������ ���� �����
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement.h"

namespace VirtualElementsFuncionsImpl {

CopyElement_factory::CopyElement_factory () {
}

void CopyElement_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string CopyElement_factory::key () const {
	return "_copy_element";
}

TemplateFunctions::InternalStereotypeFunction* CopyElement_factory::make () {
	CopyElement_var ret = new CopyElement ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

