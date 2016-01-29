////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::PageProxyImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl.h"

namespace GenSupportImpl {

PageProxyImpl_factory::PageProxyImpl_factory () {
}

void PageProxyImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GenSupport::PageProxyFactoryManager::register_factory (this, priority);
}

const char* PageProxyImpl_factory::key () const {
	return "PageProxyImpl";
}

GenSupport::PageProxy* PageProxyImpl_factory::get (ServerGate::GenerationContents::ModelElementId_const page_guid) {
	PageProxyImpl_var ret = new PageProxyImpl (page_guid);
	return ret._retn ();
}

} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

