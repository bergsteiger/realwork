////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::Searcher2Impl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

Searcher2Impl_factory::Searcher2Impl_factory () {
}

void Searcher2Impl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Gardocs::Searcher2FactoryManager::register_factory (this, priority);
}

const char* Searcher2Impl_factory::key () const {
	return "Searcher2Impl";
}

Gardocs::Searcher2* Searcher2Impl_factory::get () {
	Searcher2Impl_var ret = new Searcher2Impl ();
	return ret._retn ();
}

} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

