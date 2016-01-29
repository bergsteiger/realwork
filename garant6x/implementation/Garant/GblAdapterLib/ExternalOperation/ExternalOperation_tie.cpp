////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID ExternalOperation_tie::s_com_iid = {0x71ECDD4A, 0x0455, 0x4800, {0xBD, 0x55, 0x7E, 0xCB, 0x73, 0x99, 0x49, 0xA7}};

ExternalOperation_tie::IidRegistrator ExternalOperation_tie::s_iid_registrator;

ExternalOperation_tie::ExternalOperation_tie () : m_impl(NULL) {
}

unsigned long __stdcall ExternalOperation_tie::query_interface (
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
unsigned long __stdcall ExternalOperation_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ExternalOperation_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ExternalOperation_tie* const>(this));
	}
	return counter;
}

void ExternalOperation_tie::init () {
		m_counter = 1;
	}

void ExternalOperation_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ExternalOperation_tie::cast (::Core::IObject* obj) {
	ExternalOperation* ret = dynamic_cast<ExternalOperation*>(obj);
	if (ret) {
		ret->addref();
	}
	IExternalOperation_tie* ret_ = NULL;
	ExternalOperation_tie::make_tie (ret, ret_);
	return ret_;
}

void ExternalOperation_tie::make_cpp (const IExternalOperation_tie* obj, ExternalOperation*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ExternalOperation*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ExternalOperation_tie::make_tie (const ExternalOperation* obj, IExternalOperation_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ExternalOperation_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ExternalOperation*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ExternalOperation_tie::make_tie (const ExternalOperation& obj, IExternalOperation_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ExternalOperation_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ExternalOperation*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ExternalOperation_tie::get_impl () const {
	return m_impl;
}


ObjectId __stdcall ExternalOperation_tie::get_id () const {
_DLL_TRY
	return m_impl->get_id();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

