////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Logging/Logging_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Logging
//
// Операции логирования действий пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID LogEventData_tie::s_com_iid = {0x4B1A4AE4, 0x7B43, 0x471C, {0x8F, 0xC0, 0x94, 0x16, 0x7B, 0x57, 0x06, 0xBC}};

LogEventData_tie::IidRegistrator LogEventData_tie::s_iid_registrator;

LogEventData_tie::LogEventData_tie () : m_impl(NULL) {
}

unsigned long __stdcall LogEventData_tie::query_interface (
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
unsigned long __stdcall LogEventData_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall LogEventData_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<LogEventData_tie* const>(this));
	}
	return counter;
}

void LogEventData_tie::init () {
		m_counter = 1;
	}

void LogEventData_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* LogEventData_tie::cast (::Core::IObject* obj) {
	LogEventData* ret = dynamic_cast<LogEventData*>(obj);
	if (ret) {
		ret->addref();
	}
	ILogEventData_tie* ret_ = NULL;
	LogEventData_tie::make_tie (ret, ret_);
	return ret_;
}

void LogEventData_tie::make_cpp (const ILogEventData_tie* obj, LogEventData*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<LogEventData*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void LogEventData_tie::make_tie (const LogEventData* obj, ILogEventData_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		LogEventData_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<LogEventData*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void LogEventData_tie::make_tie (const LogEventData& obj, ILogEventData_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	LogEventData_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<LogEventData*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* LogEventData_tie::get_impl () const {
	return m_impl;
}

void __stdcall LogEventData_tie::add_date_4746DDAB022F (
	const Date& data
) {
_DLL_TRY

	m_impl->add_date(data);
_DLL_CATCH
}

void __stdcall LogEventData_tie::add_object_45ED5973006A (
	const Core::IIObject_tie* data
) {
_DLL_TRY
	Core::IObject* data_;
	Core::IObject_tie::make_cpp(data, data_);

	m_impl->add_object(data_);
_DLL_CATCH
}

void __stdcall LogEventData_tie::add_string_45ED5973006C (
	const char* data
) {
_DLL_TRY

	m_impl->add_string(data);
_DLL_CATCH
}

void __stdcall LogEventData_tie::add_ulong_4746DD60023E (
	unsigned long data
) {
_DLL_TRY

	m_impl->add_ulong(data);
_DLL_CATCH
}



const ::Core::ComIID LogManager_tie::s_com_iid = {0x23621F05, 0xBC03, 0x409D, {0x8E, 0xBB, 0x53, 0xD5, 0xBB, 0x3E, 0x1D, 0x95}};

LogManager_tie::IidRegistrator LogManager_tie::s_iid_registrator;

LogManager_tie::LogManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall LogManager_tie::query_interface (
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
unsigned long __stdcall LogManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall LogManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<LogManager_tie* const>(this));
	}
	return counter;
}

void LogManager_tie::init () {
		m_counter = 1;
	}

void LogManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* LogManager_tie::cast (::Core::IObject* obj) {
	LogManager* ret = dynamic_cast<LogManager*>(obj);
	if (ret) {
		ret->addref();
	}
	ILogManager_tie* ret_ = NULL;
	LogManager_tie::make_tie (ret, ret_);
	return ret_;
}

void LogManager_tie::make_cpp (const ILogManager_tie* obj, LogManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<LogManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void LogManager_tie::make_tie (const LogManager* obj, ILogManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		LogManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<LogManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void LogManager_tie::make_tie (const LogManager& obj, ILogManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	LogManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<LogManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* LogManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall LogManager_tie::add_event_45ED59950192 (
	LogEvent log_event
	, ILogEventData_tie* data
) {
_DLL_TRY
	LogEventData* data_;
	LogEventData_tie::make_cpp(data, data_);

	m_impl->add_event(log_event, data_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

