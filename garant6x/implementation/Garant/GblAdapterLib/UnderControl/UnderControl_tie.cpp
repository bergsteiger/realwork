////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl_tie.h"

namespace GblAdapterLib {

void ControlledChangeNotifier_callback_tie::fire () const {

	m_impl->fire_45F118D40054();


}



ControlledChangeNotifier_callback_tie::ControlledChangeNotifier_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long ControlledChangeNotifier_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<ControlledChangeNotifier_callback_tie* const>(this));
	}
	return counter;
}

unsigned long ControlledChangeNotifier_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long ControlledChangeNotifier_callback_tie::ref_count () const {
	return m_counter.value ();
}

void ControlledChangeNotifier_callback_tie::init () {
}

void ControlledChangeNotifier_callback_tie::done () {
	m_impl = NULL;
}

void IControlledChangeNotifier_tie::make_cpp (const IControlledChangeNotifier_tie* obj, ControlledChangeNotifier*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		ControlledChangeNotifier_callback_tie* ret = ControlledChangeNotifier_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<IControlledChangeNotifier_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void IControlledChangeNotifier_tie::make_tie (IControlledChangeNotifier_tie* obj, ControlledChangeNotifier_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}

const ::Core::ComIID Controllable_tie::s_com_iid = {0x1E74D154, 0x2B48, 0x4F83, {0xA5, 0x02, 0xB3, 0x9E, 0x3C, 0xA7, 0x21, 0x18}};

Controllable_tie::IidRegistrator Controllable_tie::s_iid_registrator;

Controllable_tie::Controllable_tie () : m_impl(NULL) {
}

unsigned long __stdcall Controllable_tie::query_interface (
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
unsigned long __stdcall Controllable_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Controllable_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Controllable_tie* const>(this));
	}
	return counter;
}

void Controllable_tie::init () {
		m_counter = 1;
	}

void Controllable_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Controllable_tie::cast (::Core::IObject* obj) {
	Controllable* ret = dynamic_cast<Controllable*>(obj);
	if (ret) {
		ret->addref();
	}
	IControllable_tie* ret_ = NULL;
	Controllable_tie::make_tie (ret, ret_);
	return ret_;
}

void Controllable_tie::make_cpp (const IControllable_tie* obj, Controllable*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Controllable*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Controllable_tie::make_tie (const Controllable* obj, IControllable_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Controllable_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Controllable*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Controllable_tie::make_tie (const Controllable& obj, IControllable_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Controllable_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Controllable*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Controllable_tie::get_impl () const {
	return m_impl;
}


const bool __stdcall Controllable_tie::get_can_set_to_control () const {
_DLL_TRY
	return m_impl->get_can_set_to_control();
_DLL_CATCH
}


bool __stdcall Controllable_tie::get_controlled () const {
_DLL_TRY
	return m_impl->get_controlled();
_DLL_CATCH
}
void __stdcall Controllable_tie::set_controlled (bool controlled) {
_DLL_TRY
	m_impl->set_controlled(controlled);
_DLL_CATCH
}

unsigned long __stdcall Controllable_tie::get_control_status_45EEC17501B6 () {
_DLL_TRY
	return m_impl->get_control_status ();
_DLL_CATCH
}

bool __stdcall Controllable_tie::is_same_controllable_45EEC17501B9 (
	const IControllable_tie* other
) {
_DLL_TRY
	Controllable* other_;
	Controllable_tie::make_cpp(other, other_);

	bool ret = m_impl->is_same_controllable(other_);
	return ret;
_DLL_CATCH
}


void __stdcall Controllable_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}

void __stdcall Controllable_tie::open_45EEC17501B8 (
	Core::IIObject_tie*& ret_
) {
_DLL_TRY

	Core::IObject* ret = m_impl->open();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Controllable_tie::reset_control_status_45EEC17501B7 () {
_DLL_TRY

	m_impl->reset_control_status();
_DLL_CATCH
}


void __stdcall Controllable_tie::get_short_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_short_name(), ret_, this);
_DLL_CATCH
}


ControlledItemType __stdcall Controllable_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}



const ::Core::ComIID ControlledObjects_tie::s_com_iid = {0x9AF178A2, 0x7F24, 0x4517, {0xAC, 0xFF, 0x5D, 0xD0, 0xEB, 0xB8, 0x50, 0xD4}};

unsigned long __stdcall ControlledObjects_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return 0x80004002UL;
	}
}

unsigned long __stdcall ControlledObjects_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ControlledObjects_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ControlledObjects_tie* const>(this));
	}
	return counter;
}

void ControlledObjects_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ControlledObjects_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ControlledObjects_tie::ControlledObjects_tie () : m_impl(NULL), m_orphan(true) {
}

void ControlledObjects_tie::make_cpp (const ControlledObjects_tie* obj, ControlledObjects*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ControlledObjects_tie::new_tie (ControlledObjects* obj, ControlledObjects_tie*& ret_) {
	Core::Aptr<ControlledObjects> obj_aptr (obj);
	if (obj_aptr.is_nil ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}

void ControlledObjects_tie::make_tie (ControlledObjects* obj, ControlledObjects_tie*& ret_) {
	Core::Aptr<ControlledObjects> obj_aptr (obj);
	if (obj_aptr.is_nil () || obj_aptr->empty ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}
	
void ControlledObjects_tie::make_tie (const ControlledObjects& obj, ControlledObjects_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ControlledObjects (obj);
	} else {
		ret_ = NULL;
	}
}

void ControlledObjects_tie::make_tie (const ControlledObjects& obj, ControlledObjects_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ControlledObjects*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ControlledObjects_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ControlledObjects_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ControlledObjects_tie::clear () {
	m_impl->clear();
}

void __stdcall ControlledObjects_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ControlledObjects_tie::get_item (size_t index, IControllable_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		Controllable_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ControlledObjects_tie::set_item (size_t index, const IControllable_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Controllable* item_;
		Controllable_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ControlledObjects_tie::add (const IControllable_tie* item) {
	Controllable* item_;
	Controllable_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall ControlledObjects_tie::insert (size_t index, const IControllable_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Controllable* item_;
		Controllable_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID ControlManager_tie::s_com_iid = {0x5EB9D0A5, 0xC7D0, 0x4E98, {0x85, 0xD3, 0x44, 0x38, 0xB5, 0xE9, 0x8A, 0xAB}};

ControlManager_tie::IidRegistrator ControlManager_tie::s_iid_registrator;

ControlManager_tie::ControlManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall ControlManager_tie::query_interface (
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
unsigned long __stdcall ControlManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ControlManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ControlManager_tie* const>(this));
	}
	return counter;
}

void ControlManager_tie::init () {
		m_counter = 1;
	}

void ControlManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ControlManager_tie::cast (::Core::IObject* obj) {
	ControlManager* ret = dynamic_cast<ControlManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IControlManager_tie* ret_ = NULL;
	ControlManager_tie::make_tie (ret, ret_);
	return ret_;
}

void ControlManager_tie::make_cpp (const IControlManager_tie* obj, ControlManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ControlManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ControlManager_tie::make_tie (const ControlManager* obj, IControlManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ControlManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ControlManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ControlManager_tie::make_tie (const ControlManager& obj, IControlManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ControlManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ControlManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ControlManager_tie::get_impl () const {
	return m_impl;
}


void __stdcall ControlManager_tie::get_changed_doc (ICatalogBase_tie*& ret_) {
_DLL_TRY
	CatalogBase_tie::make_tie (m_impl->get_changed_doc(), ret_);
_DLL_CATCH
}


void __stdcall ControlManager_tie::set_controlled_change_notifier (IControlledChangeNotifier_tie* controlled_change_notifier) {
_DLL_TRY
	ControlledChangeNotifier_var controlled_change_notifier_;
	IControlledChangeNotifier_tie::make_cpp(controlled_change_notifier, controlled_change_notifier_.out());
	m_impl->set_controlled_change_notifier(controlled_change_notifier_.in ());
_DLL_CATCH
}

void __stdcall ControlManager_tie::get_controlled_objects_48733C8703E3 (
	ControlledObjects_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<ControlledObjects> ret = m_impl->get_controlled_objects();
	ControlledObjects_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall ControlManager_tie::update_status_45F118B90278 (
	bool force
) {
_DLL_TRY

	m_impl->update_status(force);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

