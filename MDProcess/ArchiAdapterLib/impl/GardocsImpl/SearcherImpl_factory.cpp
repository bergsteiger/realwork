////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::SearcherImpl
//
// SearcherImpl - Сишный адаптер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

SearcherImpl_factory::SearcherImpl_factory () {
}

void SearcherImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Gardocs::SearcherFactoryManager::register_factory (this, priority);
}

const char* SearcherImpl_factory::key () const {
	return "SearcherImpl";
}

Gardocs::Searcher* SearcherImpl_factory::get () {
	SearcherImpl_var ret = new SearcherImpl ();
	return ret._retn ();
}

} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

