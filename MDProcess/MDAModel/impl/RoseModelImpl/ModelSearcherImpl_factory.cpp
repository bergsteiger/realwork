////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelSearcherImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl.h"

namespace RoseModelImpl {

ModelSearcherImpl_factory::ModelSearcherImpl_factory () {
}

void ModelSearcherImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ModelSearcherFactoryManager::register_factory (this, priority);
}

const char* ModelSearcherImpl_factory::key () const {
	return "ModelSearcherImpl";
}

ModelSearcher* ModelSearcherImpl_factory::get () {
	ModelSearcherImpl_var ret = new ModelSearcherImpl ();
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

