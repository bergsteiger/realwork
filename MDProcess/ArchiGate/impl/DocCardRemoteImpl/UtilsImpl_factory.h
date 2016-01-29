////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::UtilsImpl
// Заголовк реализации фабрик интерфеса Utils для серванта UtilsImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_FCTR_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

/// Interface-factory implementation for UtilsImpl
class UtilsImpl_factory: virtual public ::Core::RefCountObjectBase, virtual public DocCardRemote::UtilsAbstractFactory {
public:
	UtilsImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocCardRemote::Utils* make ();

};

typedef ::Core::Var<UtilsImpl_factory> UtilsImpl_factory_var;

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

