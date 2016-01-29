////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport_tie.h"

namespace GblAdapterLib {


long ProgressIndicator_callback_tie::get_max_count () const {
_DLL_TRY
	return m_impl->get_max_count();
_DLL_CATCH
}

void ProgressIndicator_callback_tie::set_current (long cur_count, long arg) const {

	m_impl->set_current_45EEE00A025D(cur_count, arg);


}



ProgressIndicator_callback_tie::ProgressIndicator_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long ProgressIndicator_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<ProgressIndicator_callback_tie* const>(this));
	}
	return counter;
}

unsigned long ProgressIndicator_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long ProgressIndicator_callback_tie::ref_count () const {
	return m_counter.value ();
}

void ProgressIndicator_callback_tie::init () {
}

void ProgressIndicator_callback_tie::done () {
	m_impl = NULL;
}

void IProgressIndicator_tie::make_cpp (const IProgressIndicator_tie* obj, ProgressIndicator*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		ProgressIndicator_callback_tie* ret = ProgressIndicator_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<IProgressIndicator_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void IProgressIndicator_tie::make_tie (IProgressIndicator_tie* obj, ProgressIndicator_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}

const ::Core::ComIID CancelLongProcess_tie::s_com_iid = {0xCD915CB2, 0x6E7A, 0x4788, {0xA5, 0xB0, 0xED, 0x90, 0x95, 0x9D, 0x83, 0x99}};

CancelLongProcess_tie::IidRegistrator CancelLongProcess_tie::s_iid_registrator;

CancelLongProcess_tie::CancelLongProcess_tie () : m_impl(NULL) {
}

unsigned long __stdcall CancelLongProcess_tie::query_interface (
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
unsigned long __stdcall CancelLongProcess_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall CancelLongProcess_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<CancelLongProcess_tie* const>(this));
	}
	return counter;
}

void CancelLongProcess_tie::init () {
		m_counter = 1;
	}

void CancelLongProcess_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* CancelLongProcess_tie::cast (::Core::IObject* obj) {
	CancelLongProcess* ret = dynamic_cast<CancelLongProcess*>(obj);
	if (ret) {
		ret->addref();
	}
	ICancelLongProcess_tie* ret_ = NULL;
	CancelLongProcess_tie::make_tie (ret, ret_);
	return ret_;
}

void CancelLongProcess_tie::make_cpp (const ICancelLongProcess_tie* obj, CancelLongProcess*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<CancelLongProcess*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void CancelLongProcess_tie::make_tie (const CancelLongProcess* obj, ICancelLongProcess_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		CancelLongProcess_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<CancelLongProcess*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void CancelLongProcess_tie::make_tie (const CancelLongProcess& obj, ICancelLongProcess_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	CancelLongProcess_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<CancelLongProcess*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* CancelLongProcess_tie::get_impl () const {
	return m_impl;
}

void __stdcall CancelLongProcess_tie::cancel_process_45EEE00D032A () const {
_DLL_TRY

	m_impl->cancel_process();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

