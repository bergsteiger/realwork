////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Notify/Notify_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"

namespace GblAdapterLib {

class INotification_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_data (IVariant_tie*& ret_) = 0;


	virtual NotifyType __stdcall get_id () const = 0;
};

class __declspec (dllexport) Notification_tie: public INotification_tie {
	SET_OBJECT_COUNTER (Notification_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Notification_tie ();

	typedef ::Core::PoolObjectManager<Notification_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Notification_tie> Pool;
	friend class ::Core::PoolObjectManager<Notification_tie>;
	typedef ::Core::IidMapRegistrator<Notification_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INotification_tie* obj, Notification*& ret_, bool interface_addref = false);

	static void make_tie (const Notification* obj, INotification_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Notification& obj, INotification_tie*& ret_, const Core::TIEBase* owner);

	Notification* m_impl;

protected:

	virtual void __stdcall get_data (IVariant_tie*& ret_);


	virtual NotifyType __stdcall get_id () const;
};


class IListener_tie;

// callback only cpp-wraper
class Listener_callback_tie : virtual public Listener, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (Listener_callback_tie)
	friend class IListener_tie;
protected:
	virtual unsigned long addref () const;

	virtual unsigned long ref_count () const;

public:
	virtual unsigned long release () const;
	virtual void fire (const Notification* notify) const;

	Listener_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<Listener_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Listener_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<Listener_callback_tie>;
	
public:
	mutable IListener_tie* m_impl;
};

// callback only abstarct interface
class IListener_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;

	virtual void __stdcall fire_45EEDE9D01C5 (
		const INotification_tie* notify
	) const = 0;

	static void make_cpp (const IListener_tie* obj, Listener*& ret_, bool interface_addref = false);

	static void make_tie (IListener_tie* obj, Listener_callback_tie*& ret_);
};


class INotifyManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall register_listener_for_notify_45EEDE9A0261 (
		NotifyType notify_id
		, IListener_tie* listener
	) = 0;
};

class __declspec (dllexport) NotifyManager_tie: public INotifyManager_tie {
	SET_OBJECT_COUNTER (NotifyManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	NotifyManager_tie ();

	typedef ::Core::PoolObjectManager<NotifyManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NotifyManager_tie> Pool;
	friend class ::Core::PoolObjectManager<NotifyManager_tie>;
	typedef ::Core::IidMapRegistrator<NotifyManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INotifyManager_tie* obj, NotifyManager*& ret_, bool interface_addref = false);

	static void make_tie (const NotifyManager* obj, INotifyManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const NotifyManager& obj, INotifyManager_tie*& ret_, const Core::TIEBase* owner);

	NotifyManager* m_impl;

protected:
	virtual void __stdcall register_listener_for_notify_45EEDE9A0261 (
		NotifyType notify_id
		, IListener_tie* listener
	);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

