////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::DefaultLogManagerImpl
//
// ���������� ��������� ������������, ����� ��������� � ����. �������� � ���� � ��������� �� �
// �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl.h"

namespace GenSupportImpl {

DefaultLogManagerImpl_factory::DefaultLogManagerImpl_factory () {
}

void DefaultLogManagerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GenSupport::LogManagerFactoryManager::register_factory (this, priority);
}

const char* DefaultLogManagerImpl_factory::key () const {
	return "DefaultLogManagerImpl";
}

GenSupport::LogManager* DefaultLogManagerImpl_factory::get () {
	DefaultLogManagerImpl_var ret = new DefaultLogManagerImpl ();
	return ret._retn ();
}

} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

