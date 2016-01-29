////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::PropertyHelperImpl
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl.h"

namespace RoseModelImpl {

PropertyHelperImpl_factory::PropertyHelperImpl_factory () {
}

void PropertyHelperImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PropertyHelperFactoryManager::register_factory (this, priority);
}

const char* PropertyHelperImpl_factory::key () const {
	return "PropertyHelperImpl";
}

PropertyHelper* PropertyHelperImpl_factory::get () {
	PropertyHelperImpl_var ret = new PropertyHelperImpl ();
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

