////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::Searcher2Impl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl.h"
#include "MDProcess/ArchiGate/LibHome.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

Searcher2Impl_factory::Searcher2Impl_factory () {
}

void Searcher2Impl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocCardRemote::Searcher2FactoryManager::register_factory (this, priority);
}

const char* Searcher2Impl_factory::key () const {
	return "Searcher2Impl";
}

DocCardRemote::Searcher2* Searcher2Impl_factory::make () {
	Searcher2Impl_var ret = new Searcher2Impl ();
	return ret->_this ();
}

} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

