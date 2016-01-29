////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::ArchiEventsListenerImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

ArchiEventsListenerImpl_factory::ArchiEventsListenerImpl_factory () {
}

void ArchiEventsListenerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Gardocs::ArchiEventsListenerFactoryManager::register_factory (this, priority);
}

const char* ArchiEventsListenerImpl_factory::key () const {
	return "ArchiEventsListenerImpl";
}

Gardocs::ArchiEventsListener* ArchiEventsListenerImpl_factory::get () {
	ArchiEventsListenerImpl_var ret = new ArchiEventsListenerImpl ();
	return ret._retn ();
}

} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

