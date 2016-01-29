////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::ArchiEventsListenerImpl
// Заголовок реализации класса серванта для интерфеса ArchiEventsListener
//
// ArchiEventsListenerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_ARCHIEVENTSLISTENERIMPL_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_ARCHIEVENTSLISTENERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

class ArchiEventsListenerImpl; // self forward Var
typedef ::Core::Var<ArchiEventsListenerImpl> ArchiEventsListenerImpl_var;
typedef ::Core::Var<const ArchiEventsListenerImpl> ArchiEventsListenerImpl_cvar;

class ArchiEventsListenerImpl_factory;

// ArchiEventsListenerImpl
class ArchiEventsListenerImpl:
	virtual public POA_ArchiGate::DocCardRemote::ArchiEventsListener
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (ArchiEventsListenerImpl)
	friend class ArchiEventsListenerImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ArchiEventsListenerImpl ();

	virtual void release () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual void release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual ~ArchiEventsListenerImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocCardRemote::ArchiEventsListener
	// в арчи появился новый документ или обновился старый
	virtual void on_event (const DocCardRemote::ArchiEvent& event) throw (CORBA::SystemException);
}; // class ArchiEventsListenerImpl

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_ARCHIEVENTSLISTENERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
