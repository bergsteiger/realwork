////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::ArchiEventsListenerImpl
// Заголовок реализации класса серванта для интерфеса ArchiEventsListener
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_ARCHIEVENTSLISTENERIMPL_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_ARCHIEVENTSLISTENERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

class ArchiEventsListenerImpl; // self forward Var
typedef ::Core::Var<ArchiEventsListenerImpl> ArchiEventsListenerImpl_var;
typedef ::Core::Var<const ArchiEventsListenerImpl> ArchiEventsListenerImpl_cvar;

class ArchiEventsListenerImpl_factory;

class ArchiEventsListenerImpl:
	virtual public Gardocs::ArchiEventsListener
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ArchiEventsListenerImpl)
	friend class ArchiEventsListenerImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ArchiEventsListenerImpl ();

	virtual ~ArchiEventsListenerImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Gardocs::ArchiEventsListener
	// проинформировать К о наступлении события
	virtual void on_event (const Gardocs::ArchiEvent& event) const /*throw (Gardocs::CommunicationFailure)*/;
}; // class ArchiEventsListenerImpl

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_ARCHIEVENTSLISTENERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
