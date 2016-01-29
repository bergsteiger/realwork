////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"

namespace GblAdapterLib {


class IControlledChangeNotifier_tie;

// callback only cpp-wraper
class ControlledChangeNotifier_callback_tie : virtual public ControlledChangeNotifier, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (ControlledChangeNotifier_callback_tie)
	friend class IControlledChangeNotifier_tie;
protected:
	virtual unsigned long addref () const;

	virtual unsigned long ref_count () const;

public:
	virtual unsigned long release () const;
	// сообщает о том что контролируемые объекты изменились.
	virtual void fire () const;

	ControlledChangeNotifier_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<ControlledChangeNotifier_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ControlledChangeNotifier_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<ControlledChangeNotifier_callback_tie>;
	
public:
	mutable IControlledChangeNotifier_tie* m_impl;
};

// callback only abstarct interface
class IControlledChangeNotifier_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;

	virtual void __stdcall fire_45F118D40054 () const = 0;

	static void make_cpp (const IControlledChangeNotifier_tie* obj, ControlledChangeNotifier*& ret_, bool interface_addref = false);

	static void make_tie (IControlledChangeNotifier_tie* obj, ControlledChangeNotifier_callback_tie*& ret_);
};


class IControllable_tie: public ::Core::IIObject_tie {
public:

	virtual const bool __stdcall get_can_set_to_control () const = 0;


	virtual bool __stdcall get_controlled () const = 0;
	virtual void __stdcall set_controlled (bool controlled) = 0;

	virtual unsigned long __stdcall get_control_status_45EEC17501B6 () = 0;

	virtual bool __stdcall is_same_controllable_45EEC17501B9 (
		const IControllable_tie* other
	) = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;

	virtual void __stdcall open_45EEC17501B8 (
		Core::IIObject_tie*& ret_
	) = 0;

	virtual void __stdcall reset_control_status_45EEC17501B7 () = 0;


	virtual void __stdcall get_short_name (GCI::IO::IString_tie*& ret_) = 0;


	virtual ControlledItemType __stdcall get_type () const = 0;
};

class __declspec (dllexport) Controllable_tie: public IControllable_tie {
	SET_OBJECT_COUNTER (Controllable_tie)
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
	Controllable_tie ();

	typedef ::Core::PoolObjectManager<Controllable_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Controllable_tie> Pool;
	friend class ::Core::PoolObjectManager<Controllable_tie>;
	typedef ::Core::IidMapRegistrator<Controllable_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IControllable_tie* obj, Controllable*& ret_, bool interface_addref = false);

	static void make_tie (const Controllable* obj, IControllable_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Controllable& obj, IControllable_tie*& ret_, const Core::TIEBase* owner);

	Controllable* m_impl;

protected:

	virtual const bool __stdcall get_can_set_to_control () const;


	virtual bool __stdcall get_controlled () const;
	virtual void __stdcall set_controlled (bool controlled);

	virtual unsigned long __stdcall get_control_status_45EEC17501B6 ();

	virtual bool __stdcall is_same_controllable_45EEC17501B9 (
		const IControllable_tie* other
	);


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);

	virtual void __stdcall open_45EEC17501B8 (
		Core::IIObject_tie*& ret_
	);

	virtual void __stdcall reset_control_status_45EEC17501B7 ();


	virtual void __stdcall get_short_name (GCI::IO::IString_tie*& ret_);


	virtual ControlledItemType __stdcall get_type () const;
};

class ControlledObjects_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ControlledObjects_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ControlledObjects_tie ();

	typedef ::Core::PoolObjectManager<ControlledObjects_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ControlledObjects_tie> Pool;
	friend class ::Core::PoolObjectManager<ControlledObjects_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ControlledObjects_tie* obj, ControlledObjects*& ret_);

	static void make_tie (ControlledObjects* obj, ControlledObjects_tie*& ret_);
	
	static void make_tie (const ControlledObjects& obj, ControlledObjects_tie*& ret_);

	static void make_tie (const ControlledObjects& obj, ControlledObjects_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ControlledObjects* obj, ControlledObjects_tie*& ret_);

	ControlledObjects* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IControllable_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IControllable_tie* item);
	virtual size_t __stdcall add (const IControllable_tie* item);
	virtual size_t __stdcall insert (size_t index, const IControllable_tie* item);
};

class IControlManager_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_changed_doc (ICatalogBase_tie*& ret_) = 0;


	virtual void __stdcall set_controlled_change_notifier (IControlledChangeNotifier_tie* controlled_change_notifier) = 0;

	virtual void __stdcall get_controlled_objects_48733C8703E3 (
		ControlledObjects_tie*& ret_
	) const = 0;

	virtual void __stdcall update_status_45F118B90278 (
		bool force
	) = 0;
};

class __declspec (dllexport) ControlManager_tie: public IControlManager_tie {
	SET_OBJECT_COUNTER (ControlManager_tie)
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
	ControlManager_tie ();

	typedef ::Core::PoolObjectManager<ControlManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ControlManager_tie> Pool;
	friend class ::Core::PoolObjectManager<ControlManager_tie>;
	typedef ::Core::IidMapRegistrator<ControlManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IControlManager_tie* obj, ControlManager*& ret_, bool interface_addref = false);

	static void make_tie (const ControlManager* obj, IControlManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ControlManager& obj, IControlManager_tie*& ret_, const Core::TIEBase* owner);

	ControlManager* m_impl;

protected:

	virtual void __stdcall get_changed_doc (ICatalogBase_tie*& ret_);


	virtual void __stdcall set_controlled_change_notifier (IControlledChangeNotifier_tie* controlled_change_notifier);

	virtual void __stdcall get_controlled_objects_48733C8703E3 (
		ControlledObjects_tie*& ret_
	) const;

	virtual void __stdcall update_status_45F118B90278 (
		bool force
	);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_UNDERCONTROL_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

