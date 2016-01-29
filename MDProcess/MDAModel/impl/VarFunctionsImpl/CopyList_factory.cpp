////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CopyList
//
// ���������� ���������� ������� ���������� _copy_list
// _copy_list(�������������� ������1�, �������������� ������2�) - �������� ������1 � ������2.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList.h"

namespace VarFunctionsImpl {

CopyList_factory::CopyList_factory () {
}

void CopyList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string CopyList_factory::key () const {
	return "_copy_list";
}

TemplateFunctions::InternalFunction* CopyList_factory::make () {
	CopyList_var ret = new CopyList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

