////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::SearcherImpl
// Заголовк реализации фабрик интерфеса Searcher для серванта SearcherImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHERIMPL_FCTR_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

/// Interface-factory implementation for SearcherImpl
class SearcherImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocCardRemote::SearcherAbstractFactory
{
public:
	SearcherImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocCardRemote::Searcher* make ();

};

typedef ::Core::Var<SearcherImpl_factory> SearcherImpl_factory_var;

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

