////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::BigFileIteratorImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl.h"
#include "MDProcess/ArchiGate/LibHome.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

BigFileIteratorImpl_factory::BigFileIteratorImpl_factory () {
}

void BigFileIteratorImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocCardRemote::BigFileIteratorFactoryManager::register_factory (this, priority);
}

const char* BigFileIteratorImpl_factory::key () const {
	return "BigFileIteratorImpl";
}

DocCardRemote::BigFileIterator* BigFileIteratorImpl_factory::make () {
	BigFileIteratorImpl_var ret = new BigFileIteratorImpl ();
	return ret->_this ();
}

} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

