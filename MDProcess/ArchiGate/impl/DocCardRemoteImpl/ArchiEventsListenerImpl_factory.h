////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::ArchiEventsListenerImpl
// Заголовк реализации фабрик интерфеса ArchiEventsListener для серванта ArchiEventsListenerImpl
//
// ArchiEventsListenerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_ARCHIEVENTSLISTENERIMPL_FCTR_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_ARCHIEVENTSLISTENERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

/// Interface-factory implementation for ArchiEventsListenerImpl
class ArchiEventsListenerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocCardRemote::ArchiEventsListenerAbstractFactory
{
public:
	ArchiEventsListenerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocCardRemote::ArchiEventsListener* make ();

};

typedef ::Core::Var<ArchiEventsListenerImpl_factory> ArchiEventsListenerImpl_factory_var;

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_ARCHIEVENTSLISTENERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

