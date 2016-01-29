////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::SearcherImpl
// Заголовк реализации фабрик интерфеса Searcher для серванта SearcherImpl
//
// SearcherImpl - Сишный адаптер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHERIMPL_FCTR_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

/// Interface-factory implementation for SearcherImpl
class SearcherImpl_factory: virtual public ::Core::RefCountObjectBase, virtual public Gardocs::SearcherAbstractFactory {
public:
	SearcherImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Gardocs::Searcher* get ();

};

typedef ::Core::Var<SearcherImpl_factory> SearcherImpl_factory_var;

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

