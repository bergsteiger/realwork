////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// Возможности, доступные через интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID InternetSupport_tie::s_com_iid = {0x7DF56131, 0xCBD6, 0x47F5, {0xB8, 0xB1, 0x49, 0x54, 0x09, 0xAF, 0xE6, 0xE4}};

InternetSupport_tie::IidRegistrator InternetSupport_tie::s_iid_registrator;

InternetSupport_tie::InternetSupport_tie () : m_impl(NULL) {
}

unsigned long __stdcall InternetSupport_tie::query_interface (
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
unsigned long __stdcall InternetSupport_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall InternetSupport_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<InternetSupport_tie* const>(this));
	}
	return counter;
}

void InternetSupport_tie::init () {
		m_counter = 1;
	}

void InternetSupport_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* InternetSupport_tie::cast (::Core::IObject* obj) {
	InternetSupport* ret = dynamic_cast<InternetSupport*>(obj);
	if (ret) {
		ret->addref();
	}
	IInternetSupport_tie* ret_ = NULL;
	InternetSupport_tie::make_tie (ret, ret_);
	return ret_;
}

void InternetSupport_tie::make_cpp (const IInternetSupport_tie* obj, InternetSupport*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<InternetSupport*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void InternetSupport_tie::make_tie (const InternetSupport* obj, IInternetSupport_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		InternetSupport_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<InternetSupport*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void InternetSupport_tie::make_tie (const InternetSupport& obj, IInternetSupport_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	InternetSupport_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<InternetSupport*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* InternetSupport_tie::get_impl () const {
	return m_impl;
}

void __stdcall InternetSupport_tie::get_url_for_document_4BD133E40285 (
	unsigned long doc_id
	, unsigned long para_id
	, GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_url_for_document(doc_id, para_id);
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall InternetSupport_tie::get_url_for_internet_version_4BD1456303BC (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_url_for_internet_version();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall InternetSupport_tie::is_internet_agent_enabled_4BD1396400A3 () const {
_DLL_TRY
	return m_impl->is_internet_agent_enabled ();
_DLL_CATCH
}

bool __stdcall InternetSupport_tie::revision_check_enabled_4BD133C102AD () const {
_DLL_TRY
	return m_impl->revision_check_enabled ();
_DLL_CATCH
}

bool __stdcall InternetSupport_tie::show_warning_4D6648D000C3 () const {
_DLL_TRY
	return m_impl->show_warning ();
_DLL_CATCH
}



const ::Core::ComIID DecisionsArchiveSupport_tie::s_com_iid = {0xCD81011E, 0x549D, 0x406A, {0x96, 0x4C, 0x9F, 0xE2, 0x91, 0x55, 0x2E, 0xB4}};

DecisionsArchiveSupport_tie::IidRegistrator DecisionsArchiveSupport_tie::s_iid_registrator;

DecisionsArchiveSupport_tie::DecisionsArchiveSupport_tie () : m_impl(NULL) {
}

unsigned long __stdcall DecisionsArchiveSupport_tie::query_interface (
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
unsigned long __stdcall DecisionsArchiveSupport_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DecisionsArchiveSupport_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DecisionsArchiveSupport_tie* const>(this));
	}
	return counter;
}

void DecisionsArchiveSupport_tie::init () {
		m_counter = 1;
	}

void DecisionsArchiveSupport_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DecisionsArchiveSupport_tie::cast (::Core::IObject* obj) {
	DecisionsArchiveSupport* ret = dynamic_cast<DecisionsArchiveSupport*>(obj);
	if (ret) {
		ret->addref();
	}
	IDecisionsArchiveSupport_tie* ret_ = NULL;
	DecisionsArchiveSupport_tie::make_tie (ret, ret_);
	return ret_;
}

void DecisionsArchiveSupport_tie::make_cpp (const IDecisionsArchiveSupport_tie* obj, DecisionsArchiveSupport*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DecisionsArchiveSupport*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DecisionsArchiveSupport_tie::make_tie (const DecisionsArchiveSupport* obj, IDecisionsArchiveSupport_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DecisionsArchiveSupport_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DecisionsArchiveSupport*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DecisionsArchiveSupport_tie::make_tie (const DecisionsArchiveSupport& obj, IDecisionsArchiveSupport_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DecisionsArchiveSupport_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DecisionsArchiveSupport*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DecisionsArchiveSupport_tie::get_impl () const {
	return m_impl;
}

bool __stdcall DecisionsArchiveSupport_tie::archive_available_4F71DD6B03AA () const {
_DLL_TRY
	return m_impl->archive_available ();
_DLL_CATCH
}

void __stdcall DecisionsArchiveSupport_tie::get_archive_url_4F71D47D0086 (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_archive_url();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

