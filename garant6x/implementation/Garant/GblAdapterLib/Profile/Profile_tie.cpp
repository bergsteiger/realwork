////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Profile/Profile_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Profile
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/Profile_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID StopWatch_tie::s_com_iid = {0xB162C5E6, 0x8FE2, 0x44B5, {0xB8, 0x06, 0xF1, 0xE6, 0x5F, 0x17, 0x58, 0x7E}};

StopWatch_tie::IidRegistrator StopWatch_tie::s_iid_registrator;

StopWatch_tie::StopWatch_tie () : m_impl(NULL) {
}

unsigned long __stdcall StopWatch_tie::query_interface (
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
unsigned long __stdcall StopWatch_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall StopWatch_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<StopWatch_tie* const>(this));
	}
	return counter;
}

void StopWatch_tie::init () {
		m_counter = 1;
	}

void StopWatch_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* StopWatch_tie::cast (::Core::IObject* obj) {
	StopWatch* ret = dynamic_cast<StopWatch*>(obj);
	if (ret) {
		ret->addref();
	}
	IStopWatch_tie* ret_ = NULL;
	StopWatch_tie::make_tie (ret, ret_);
	return ret_;
}

void StopWatch_tie::make_cpp (const IStopWatch_tie* obj, StopWatch*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<StopWatch*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void StopWatch_tie::make_tie (const StopWatch* obj, IStopWatch_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		StopWatch_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<StopWatch*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void StopWatch_tie::make_tie (const StopWatch& obj, IStopWatch_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	StopWatch_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<StopWatch*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* StopWatch_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID StopWatchEx_tie::s_com_iid = {0x266C0FFA, 0x01E6, 0x4FA4, {0xA4, 0xD6, 0xBC, 0x62, 0x0B, 0x8B, 0x7F, 0x76}};

StopWatchEx_tie::IidRegistrator StopWatchEx_tie::s_iid_registrator;

StopWatchEx_tie::StopWatchEx_tie () : m_impl(NULL) {
}

unsigned long __stdcall StopWatchEx_tie::query_interface (
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
unsigned long __stdcall StopWatchEx_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall StopWatchEx_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<StopWatchEx_tie* const>(this));
	}
	return counter;
}

void StopWatchEx_tie::init () {
		m_counter = 1;
	}

void StopWatchEx_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* StopWatchEx_tie::cast (::Core::IObject* obj) {
	StopWatchEx* ret = dynamic_cast<StopWatchEx*>(obj);
	if (ret) {
		ret->addref();
	}
	IStopWatchEx_tie* ret_ = NULL;
	StopWatchEx_tie::make_tie (ret, ret_);
	return ret_;
}

void StopWatchEx_tie::make_cpp (const IStopWatchEx_tie* obj, StopWatchEx*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<StopWatchEx*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void StopWatchEx_tie::make_tie (const StopWatchEx* obj, IStopWatchEx_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		StopWatchEx_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<StopWatchEx*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void StopWatchEx_tie::make_tie (const StopWatchEx& obj, IStopWatchEx_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	StopWatchEx_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<StopWatchEx*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* StopWatchEx_tie::get_impl () const {
	return m_impl;
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

