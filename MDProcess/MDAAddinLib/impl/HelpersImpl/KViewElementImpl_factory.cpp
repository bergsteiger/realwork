////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::KViewElementImpl
//
// ��������� �������� �������� � � ��������� ��������� ������� ShellExecute
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl.h"

namespace HelpersImpl {

KViewElementImpl_factory::KViewElementImpl_factory () {
}

void KViewElementImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Helpers::KViewElementFactoryManager::register_factory (this, priority);
}

const char* KViewElementImpl_factory::key () const {
	return "KViewElementImpl";
}

Helpers::KViewElement* KViewElementImpl_factory::get () {
	KViewElementImpl_var ret = new KViewElementImpl ();
	return ret._retn ();
}

} // namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

