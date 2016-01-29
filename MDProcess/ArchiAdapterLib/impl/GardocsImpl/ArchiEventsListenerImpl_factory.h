////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::ArchiEventsListenerImpl
// Заголовк реализации фабрик интерфеса ArchiEventsListener для серванта ArchiEventsListenerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_ARCHIEVENTSLISTENERIMPL_FCTR_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_ARCHIEVENTSLISTENERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

/// Interface-factory implementation for ArchiEventsListenerImpl
class ArchiEventsListenerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Gardocs::ArchiEventsListenerAbstractFactory
{
public:
	ArchiEventsListenerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Gardocs::ArchiEventsListener* get ();

};

typedef ::Core::Var<ArchiEventsListenerImpl_factory> ArchiEventsListenerImpl_factory_var;

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_ARCHIEVENTSLISTENERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

