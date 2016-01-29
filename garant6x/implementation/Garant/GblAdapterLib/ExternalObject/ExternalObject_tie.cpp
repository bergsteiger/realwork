////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID ExternalLink_tie::s_com_iid = {0x533104AC, 0x5A1B, 0x41B9, {0x8A, 0xCC, 0xC9, 0x29, 0xC2, 0xB9, 0x66, 0x78}};

ExternalLink_tie::IidRegistrator ExternalLink_tie::s_iid_registrator;

ExternalLink_tie::ExternalLink_tie () : m_impl(NULL) {
}

unsigned long __stdcall ExternalLink_tie::query_interface (
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
unsigned long __stdcall ExternalLink_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ExternalLink_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ExternalLink_tie* const>(this));
	}
	return counter;
}

void ExternalLink_tie::init () {
		m_counter = 1;
	}

void ExternalLink_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ExternalLink_tie::cast (::Core::IObject* obj) {
	ExternalLink* ret = dynamic_cast<ExternalLink*>(obj);
	if (ret) {
		ret->addref();
	}
	IExternalLink_tie* ret_ = NULL;
	ExternalLink_tie::make_tie (ret, ret_);
	return ret_;
}

void ExternalLink_tie::make_cpp (const IExternalLink_tie* obj, ExternalLink*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ExternalLink*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ExternalLink_tie::make_tie (const ExternalLink* obj, IExternalLink_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ExternalLink_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ExternalLink*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ExternalLink_tie::make_tie (const ExternalLink& obj, IExternalLink_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ExternalLink_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ExternalLink*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ExternalLink_tie::get_impl () const {
	return m_impl;
}


void __stdcall ExternalLink_tie::get_url (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_url(), ret_);
_DLL_CATCH
}



const ::Core::ComIID ExternalObject_tie::s_com_iid = {0xA57F5CFD, 0xDA48, 0x4769, {0x97, 0xD6, 0xB6, 0x3F, 0xEF, 0x94, 0xB8, 0x1C}};

ExternalObject_tie::IidRegistrator ExternalObject_tie::s_iid_registrator;

ExternalObject_tie::ExternalObject_tie () : m_impl(NULL) {
}

unsigned long __stdcall ExternalObject_tie::query_interface (
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
unsigned long __stdcall ExternalObject_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ExternalObject_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ExternalObject_tie* const>(this));
	}
	return counter;
}

void ExternalObject_tie::init () {
		m_counter = 1;
	}

void ExternalObject_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ExternalObject_tie::cast (::Core::IObject* obj) {
	ExternalObject* ret = dynamic_cast<ExternalObject*>(obj);
	if (ret) {
		ret->addref();
	}
	IExternalObject_tie* ret_ = NULL;
	ExternalObject_tie::make_tie (ret, ret_);
	return ret_;
}

void ExternalObject_tie::make_cpp (const IExternalObject_tie* obj, ExternalObject*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ExternalObject*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ExternalObject_tie::make_tie (const ExternalObject* obj, IExternalObject_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ExternalObject_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ExternalObject*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ExternalObject_tie::make_tie (const ExternalObject& obj, IExternalObject_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ExternalObject_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ExternalObject*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ExternalObject_tie::get_impl () const {
	return m_impl;
}


const void* __stdcall ExternalObject_tie::get_data_pointer () const {
_DLL_TRY
	return m_impl->get_data_pointer();
_DLL_CATCH
}


unsigned long __stdcall ExternalObject_tie::get_data_size () const {
_DLL_TRY
	return m_impl->get_data_size();
_DLL_CATCH
}


ExternalObjectType __stdcall ExternalObject_tie::get_data_type () const {
_DLL_TRY
	return m_impl->get_data_type();
_DLL_CATCH
}


void __stdcall ExternalObject_tie::get_extension (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_extension(), ret_);
_DLL_CATCH
}


void __stdcall ExternalObject_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_);
_DLL_CATCH
}



const ::Core::ComIID SplashScreen_tie::s_com_iid = {0x6F8DC97E, 0x13B6, 0x446A, {0xA5, 0x5D, 0xB2, 0x4A, 0x52, 0x32, 0xF5, 0x2E}};

SplashScreen_tie::IidRegistrator SplashScreen_tie::s_iid_registrator;

SplashScreen_tie::SplashScreen_tie () : m_impl(NULL) {
}

unsigned long __stdcall SplashScreen_tie::query_interface (
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
unsigned long __stdcall SplashScreen_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SplashScreen_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SplashScreen_tie* const>(this));
	}
	return counter;
}

void SplashScreen_tie::init () {
		m_counter = 1;
	}

void SplashScreen_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* SplashScreen_tie::cast (::Core::IObject* obj) {
	SplashScreen* ret = dynamic_cast<SplashScreen*>(obj);
	if (ret) {
		ret->addref();
	}
	ISplashScreen_tie* ret_ = NULL;
	SplashScreen_tie::make_tie (ret, ret_);
	return ret_;
}

void SplashScreen_tie::make_cpp (const ISplashScreen_tie* obj, SplashScreen*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<SplashScreen*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void SplashScreen_tie::make_tie (const SplashScreen* obj, ISplashScreen_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		SplashScreen_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<SplashScreen*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void SplashScreen_tie::make_tie (const SplashScreen& obj, ISplashScreen_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	SplashScreen_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<SplashScreen*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* SplashScreen_tie::get_impl () const {
	return m_impl;
}


unsigned long __stdcall SplashScreen_tie::get_data_size () const {
_DLL_TRY
	return m_impl->get_data_size();
_DLL_CATCH
}


const void* __stdcall SplashScreen_tie::get_data_pointer () const {
_DLL_TRY
	return m_impl->get_data_pointer();
_DLL_CATCH
}


void __stdcall SplashScreen_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_);
_DLL_CATCH
}


void __stdcall SplashScreen_tie::get_extension (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_extension(), ret_);
_DLL_CATCH
}


ExternalObjectType __stdcall SplashScreen_tie::get_data_type () const {
_DLL_TRY
	return m_impl->get_data_type();
_DLL_CATCH
}

void __stdcall SplashScreen_tie::get_owner (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_owner(), ret_);
_DLL_CATCH
}


void __stdcall SplashScreen_tie::get_owner_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_owner_caption(), ret_);
_DLL_CATCH
}


short __stdcall SplashScreen_tie::get_show_time () const {
_DLL_TRY
	return m_impl->get_show_time();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

