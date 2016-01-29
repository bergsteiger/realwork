////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Banner/Banner_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// Баннеры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID Banner_tie::s_com_iid = {0xB869F2FF, 0x7971, 0x44F1, {0xBA, 0xA5, 0xF6, 0x64, 0xC9, 0x78, 0xEF, 0x7F}};

Banner_tie::IidRegistrator Banner_tie::s_iid_registrator;

Banner_tie::Banner_tie () : m_impl(NULL) {
}

unsigned long __stdcall Banner_tie::query_interface (
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
unsigned long __stdcall Banner_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Banner_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Banner_tie* const>(this));
	}
	return counter;
}

void Banner_tie::init () {
		m_counter = 1;
	}

void Banner_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Banner_tie::cast (::Core::IObject* obj) {
	Banner* ret = dynamic_cast<Banner*>(obj);
	if (ret) {
		ret->addref();
	}
	IBanner_tie* ret_ = NULL;
	Banner_tie::make_tie (ret, ret_);
	return ret_;
}

void Banner_tie::make_cpp (const IBanner_tie* obj, Banner*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Banner*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Banner_tie::make_tie (const Banner* obj, IBanner_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Banner_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Banner*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Banner_tie::make_tie (const Banner& obj, IBanner_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Banner_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Banner*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Banner_tie::get_impl () const {
	return m_impl;
}

void __stdcall Banner_tie::get_picture_4ACC85A303E1 (
	IExternalObject_tie*& ret_
) const {
_DLL_TRY

	ExternalObject* ret = m_impl->get_picture();
	ExternalObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Banner_tie::open_link_4ACC6E5F00E5 (
	Core::IIObject_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	Core::IObject* ret = m_impl->open_link();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

