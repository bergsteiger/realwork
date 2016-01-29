////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Notify/Notify_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID Notification_tie::s_com_iid = {0x30BDF2EC, 0xFBC4, 0x4477, {0xAC, 0x3B, 0x5B, 0xB8, 0xCB, 0xFC, 0x8A, 0x4D}};

Notification_tie::IidRegistrator Notification_tie::s_iid_registrator;

Notification_tie::Notification_tie () : m_impl(NULL) {
}

unsigned long __stdcall Notification_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall Notification_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Notification_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Notification_tie* const>(this));
	}
	return counter;
}

void Notification_tie::init () {
		m_counter = 1;
	}

void Notification_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Notification_tie::cast (::Core::IObject* obj) {
	Notification* ret = dynamic_cast<Notification*>(obj);
	if (ret) {
		ret->addref();
	}
	INotification_tie* ret_ = NULL;
	Notification_tie::make_tie (ret, ret_);
	return ret_;
}

void Notification_tie::make_cpp (const INotification_tie* obj, Notification*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Notification*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Notification_tie::make_tie (const Notification* obj, INotification_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Notification_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Notification*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Notification_tie::make_tie (const Notification& obj, INotification_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Notification_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Notification*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Notification_tie::get_impl () const {
	return m_impl;
}


void __stdcall Notification_tie::get_data (IVariant_tie*& ret_) {
_DLL_TRY
	Variant_tie::make_tie (m_impl->get_data(), ret_, this);
_DLL_CATCH
}


NotifyType __stdcall Notification_tie::get_id () const {
_DLL_TRY
	return m_impl->get_id();
_DLL_CATCH
}



void Listener_callback_tie::fire (const Notification* notify) const {
	::Core::Var<INotification_tie> notify_;
	Notification_tie::make_tie(notify, notify_.out(), true /*addref*/);

	m_impl->fire_45EEDE9D01C5(notify_.in());


}



Listener_callback_tie::Listener_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long Listener_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<Listener_callback_tie* const>(this));
	}
	return counter;
}

unsigned long Listener_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long Listener_callback_tie::ref_count () const {
	return m_counter.value ();
}

void Listener_callback_tie::init () {
}

void Listener_callback_tie::done () {
	m_impl = NULL;
}

void IListener_tie::make_cpp (const IListener_tie* obj, Listener*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		Listener_callback_tie* ret = Listener_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<IListener_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void IListener_tie::make_tie (IListener_tie* obj, Listener_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}

const ::Core::ComIID NotifyManager_tie::s_com_iid = {0x4E4282C5, 0x1F27, 0x4A9E, {0x8F, 0x8D, 0x3C, 0xC8, 0xB0, 0x0F, 0xDA, 0x97}};

NotifyManager_tie::IidRegistrator NotifyManager_tie::s_iid_registrator;

NotifyManager_tie::NotifyManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall NotifyManager_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall NotifyManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NotifyManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NotifyManager_tie* const>(this));
	}
	return counter;
}

void NotifyManager_tie::init () {
		m_counter = 1;
	}

void NotifyManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* NotifyManager_tie::cast (::Core::IObject* obj) {
	NotifyManager* ret = dynamic_cast<NotifyManager*>(obj);
	if (ret) {
		ret->addref();
	}
	INotifyManager_tie* ret_ = NULL;
	NotifyManager_tie::make_tie (ret, ret_);
	return ret_;
}

void NotifyManager_tie::make_cpp (const INotifyManager_tie* obj, NotifyManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<NotifyManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void NotifyManager_tie::make_tie (const NotifyManager* obj, INotifyManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		NotifyManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<NotifyManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void NotifyManager_tie::make_tie (const NotifyManager& obj, INotifyManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	NotifyManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<NotifyManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* NotifyManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall NotifyManager_tie::register_listener_for_notify_45EEDE9A0261 (
	NotifyType notify_id
	, IListener_tie* listener
) {
_DLL_TRY
	Listener_var listener_;
	IListener_tie::make_cpp(listener, listener_.out ());

	m_impl->register_listener_for_notify(notify_id, listener_.in ());
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

