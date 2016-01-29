////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::SearcherImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl.h"
#include "MDProcess/ArchiGate/LibHome.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

SearcherImpl_factory::SearcherImpl_factory () {
}

void SearcherImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocCardRemote::SearcherFactoryManager::register_factory (this, priority);
}

const char* SearcherImpl_factory::key () const {
	return "SearcherImpl";
}

DocCardRemote::Searcher* SearcherImpl_factory::make () {
	SearcherImpl_var ret = new SearcherImpl ();
	return ret->_this ();
}

} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

