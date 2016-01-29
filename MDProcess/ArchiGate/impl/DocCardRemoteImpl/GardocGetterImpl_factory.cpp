////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::GardocGetterImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl.h"
#include "MDProcess/ArchiGate/LibHome.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

GardocGetterImpl_factory::GardocGetterImpl_factory () {
}

void GardocGetterImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocCardRemote::GardocGetterFactoryManager::register_factory (this, priority);
}

const char* GardocGetterImpl_factory::key () const {
	return "GardocGetterImpl";
}

DocCardRemote::GardocGetter* GardocGetterImpl_factory::make () {
	GardocGetterImpl_var ret = new GardocGetterImpl ();
	return ret->_this ();
}

} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

