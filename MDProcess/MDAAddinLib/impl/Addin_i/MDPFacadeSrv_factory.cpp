////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::MDPFacadeSrv
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv.h"


MDPFacadeSrv_factory::MDPFacadeSrv_factory () {
}

void MDPFacadeSrv_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MDPSupport::MDPFacadeFactoryManager::register_factory (this, priority);
}

const char* MDPFacadeSrv_factory::key () const {
	return "MDPFacadeSrv";
}

MDPSupport::MDPFacade* MDPFacadeSrv_factory::get () {
	MDPFacadeSrv_var ret = new MDPFacadeSrv ();
	return ret._retn ();
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

