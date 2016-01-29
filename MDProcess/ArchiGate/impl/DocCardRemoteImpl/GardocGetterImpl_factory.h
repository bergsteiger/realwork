////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::GardocGetterImpl
// Заголовк реализации фабрик интерфеса GardocGetter для серванта GardocGetterImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_GARDOCGETTERIMPL_FCTR_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_GARDOCGETTERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

/// Interface-factory implementation for GardocGetterImpl
class GardocGetterImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocCardRemote::GardocGetterAbstractFactory
{
public:
	GardocGetterImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocCardRemote::GardocGetter* make ();

};

typedef ::Core::Var<GardocGetterImpl_factory> GardocGetterImpl_factory_var;

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_GARDOCGETTERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

