////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::NotifyManager_i
// Заголовок реализации класса серванта для интерфеса NotifyManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFYMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFYMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"

namespace GblAdapterLib {

class NotifyManager_i; // self forward Var
typedef ::Core::Var<NotifyManager_i> NotifyManager_i_var;
typedef ::Core::Var<const NotifyManager_i> NotifyManager_i_cvar;

class NotifyManager_i_factory;

class NotifyManager_i:
	virtual public NotifyManager
	, virtual public ::Core::RefCountObjectBase
	, virtual public GSI::NotifyService_i::Consumer_i
{
	SET_OBJECT_COUNTER (NotifyManager_i)
	friend class NotifyManager_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	typedef std::map < NotifyType, DataTransformer_var > TransformerList;

	typedef std::multimap < NotifyType, Listener_var > ListenerList;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NotifyManager_i ();

	virtual ~NotifyManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void send_notify_to_all (NotifyType notify_id, const CORBA::Any& data_in_any);

	virtual void timestamp_changed (const CORBA::Any& data);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	TransformerList m_data_transformers;

	ListenerList m_listeners;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NotifyManager
	virtual void listen_for_all ();

	// implemented method from NotifyManager
	virtual void listen_only_for_me ();

	// implemented method from NotifyManager
	virtual void register_listener_for_notify (NotifyType notify_id, Listener* listener);

	// implemented method from NotifyManager
	virtual void register_transformer (NotifyType type, DataTransformer* transformer);

	// implemented method from NotifyManager
	virtual void stop_listen_me ();
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from GSI::NotifyService::Consumer
	// Для получения сообщений реализация перекрывает этот метод.
	virtual void fire_event (const CORBA::Any& event);

}; // class NotifyManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFYMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
