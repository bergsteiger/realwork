////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::SearchProgressIndicator
//
// Прогрессиндикаторы для поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator_tie.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator {

const ::Core::ComIID CancelSearch_tie::s_com_iid = {0x77C1D94F, 0x084E, 0x4430, {0x8F, 0xE6, 0x79, 0x6A, 0x98, 0x17, 0xD9, 0x90}};

CancelSearch_tie::IidRegistrator CancelSearch_tie::s_iid_registrator;

CancelSearch_tie::CancelSearch_tie () : m_impl(NULL) {
}

unsigned long __stdcall CancelSearch_tie::query_interface (
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
unsigned long __stdcall CancelSearch_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall CancelSearch_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<CancelSearch_tie* const>(this));
	}
	return counter;
}

void CancelSearch_tie::init () {
		m_counter = 1;
	}

void CancelSearch_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* CancelSearch_tie::cast (::Core::IObject* obj) {
	CancelSearch* ret = dynamic_cast<CancelSearch*>(obj);
	if (ret) {
		ret->addref();
	}
	ICancelSearch_tie* ret_ = NULL;
	CancelSearch_tie::make_tie (ret, ret_);
	return ret_;
}

void CancelSearch_tie::make_cpp (const ICancelSearch_tie* obj, CancelSearch*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<CancelSearch*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void CancelSearch_tie::make_tie (const CancelSearch* obj, ICancelSearch_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		CancelSearch_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<CancelSearch*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void CancelSearch_tie::make_tie (const CancelSearch& obj, ICancelSearch_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	CancelSearch_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<CancelSearch*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* CancelSearch_tie::get_impl () const {
	return m_impl;
}

void __stdcall CancelSearch_tie::cancel_process_45EEE00D032A () const {
_DLL_TRY

	m_impl->cancel_process();
_DLL_CATCH
}



long ProgressIndicatorForSearch_callback_tie::get_max_count () const {
_DLL_TRY
	return m_impl->get_max_count();
_DLL_CATCH
}

void ProgressIndicatorForSearch_callback_tie::set_current (long cur_count, long arg) const {

	m_impl->set_current_45EEE00A025D(cur_count, arg);


}
void ProgressIndicatorForSearch_callback_tie::finish_process (const SearchEntity* entity) const {
	::Core::Var<ISearchEntity_tie> entity_;
	SearchEntity_tie::make_tie(entity, entity_.out(), true /*addref*/);

	m_impl->finish_process_462741D0012E(entity_.in());


}



ProgressIndicatorForSearch_callback_tie::ProgressIndicatorForSearch_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long ProgressIndicatorForSearch_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<ProgressIndicatorForSearch_callback_tie* const>(this));
	}
	return counter;
}

unsigned long ProgressIndicatorForSearch_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long ProgressIndicatorForSearch_callback_tie::ref_count () const {
	return m_counter.value ();
}

void ProgressIndicatorForSearch_callback_tie::init () {
}

void ProgressIndicatorForSearch_callback_tie::done () {
	m_impl = NULL;
}

void IProgressIndicatorForSearch_tie::make_cpp (const IProgressIndicatorForSearch_tie* obj, ProgressIndicatorForSearch*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		ProgressIndicatorForSearch_callback_tie* ret = ProgressIndicatorForSearch_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<IProgressIndicatorForSearch_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void IProgressIndicatorForSearch_tie::make_tie (IProgressIndicatorForSearch_tie* obj, ProgressIndicatorForSearch_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}

} // namespace SearchProgressIndicator
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

