////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::BigFileIteratorImpl
// Заголовк реализации фабрик интерфеса BigFileIterator для серванта BigFileIteratorImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_BIGFILEITERATORIMPL_FCTR_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_BIGFILEITERATORIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

/// Interface-factory implementation for BigFileIteratorImpl
class BigFileIteratorImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocCardRemote::BigFileIteratorAbstractFactory
{
public:
	BigFileIteratorImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocCardRemote::BigFileIterator* make ();

};

typedef ::Core::Var<BigFileIteratorImpl_factory> BigFileIteratorImpl_factory_var;

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_BIGFILEITERATORIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

