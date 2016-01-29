////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// Интерфейсы для взаимодействия с отделом Пащака
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces_tie.h"

namespace HCAdapterLib {
namespace HCInterfaces {

const ::Core::ComIID ConsultingData_tie::s_com_iid = {0xE92828ED, 0x9B9A, 0x4302, {0x8D, 0x42, 0x37, 0xE4, 0x13, 0xC6, 0xF4, 0x34}};

ConsultingData_tie::IidRegistrator ConsultingData_tie::s_iid_registrator;

ConsultingData_tie::ConsultingData_tie () : m_impl(NULL) {
}

unsigned long __stdcall ConsultingData_tie::query_interface (
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
unsigned long __stdcall ConsultingData_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ConsultingData_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ConsultingData_tie* const>(this));
	}
	return counter;
}

void ConsultingData_tie::init () {
		m_counter = 1;
	}

void ConsultingData_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ConsultingData_tie::cast (::Core::IObject* obj) {
	ConsultingData* ret = dynamic_cast<ConsultingData*>(obj);
	if (ret) {
		ret->addref();
	}
	IConsultingData_tie* ret_ = NULL;
	ConsultingData_tie::make_tie (ret, ret_);
	return ret_;
}

void ConsultingData_tie::make_cpp (const IConsultingData_tie* obj, ConsultingData*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ConsultingData*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ConsultingData_tie::make_tie (const ConsultingData* obj, IConsultingData_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ConsultingData_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ConsultingData*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ConsultingData_tie::make_tie (const ConsultingData& obj, IConsultingData_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ConsultingData_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ConsultingData*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ConsultingData_tie::get_impl () const {
	return m_impl;
}

void __stdcall ConsultingData_tie::data_received_442BFEEF0399 () const {
_DLL_TRY

	m_impl->data_received();
_DLL_CATCH
}

void __stdcall ConsultingData_tie::get_data_442BF015006D (
	GCI::IO::IStream_tie*& ret_
) {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_data();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID OnlineData_tie::s_com_iid = {0x43387100, 0x5C41, 0x4CCB, {0x83, 0xEB, 0x4E, 0xE5, 0xBB, 0x99, 0xC4, 0x43}};

OnlineData_tie::IidRegistrator OnlineData_tie::s_iid_registrator;

OnlineData_tie::OnlineData_tie () : m_impl(NULL) {
}

unsigned long __stdcall OnlineData_tie::query_interface (
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
unsigned long __stdcall OnlineData_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall OnlineData_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<OnlineData_tie* const>(this));
	}
	return counter;
}

void OnlineData_tie::init () {
		m_counter = 1;
	}

void OnlineData_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* OnlineData_tie::cast (::Core::IObject* obj) {
	OnlineData* ret = dynamic_cast<OnlineData*>(obj);
	if (ret) {
		ret->addref();
	}
	IOnlineData_tie* ret_ = NULL;
	OnlineData_tie::make_tie (ret, ret_);
	return ret_;
}

void OnlineData_tie::make_cpp (const IOnlineData_tie* obj, OnlineData*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<OnlineData*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void OnlineData_tie::make_tie (const OnlineData* obj, IOnlineData_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		OnlineData_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<OnlineData*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void OnlineData_tie::make_tie (const OnlineData& obj, IOnlineData_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	OnlineData_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<OnlineData*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* OnlineData_tie::get_impl () const {
	return m_impl;
}

void __stdcall OnlineData_tie::get_data_442BF015006D (
	GCI::IO::IStream_tie*& ret_
) {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_data();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall OnlineData_tie::data_received_442BFEEF0399 () const {
_DLL_TRY

	m_impl->data_received();
_DLL_CATCH
}


const ::Core::ComIID BusinessLogicLifeCycle_tie::s_com_iid = {0xAC92D75F, 0x442C, 0x4FFE, {0x89, 0x7D, 0x23, 0x49, 0x9B, 0x1B, 0xBC, 0x34}};

BusinessLogicLifeCycle_tie::IidRegistrator BusinessLogicLifeCycle_tie::s_iid_registrator;

BusinessLogicLifeCycle_tie::BusinessLogicLifeCycle_tie () : m_impl(NULL) {
}

unsigned long __stdcall BusinessLogicLifeCycle_tie::query_interface (
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
unsigned long __stdcall BusinessLogicLifeCycle_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall BusinessLogicLifeCycle_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<BusinessLogicLifeCycle_tie* const>(this));
	}
	return counter;
}

void BusinessLogicLifeCycle_tie::init () {
		m_counter = 1;
	}

void BusinessLogicLifeCycle_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* BusinessLogicLifeCycle_tie::cast (::Core::IObject* obj) {
	BusinessLogicLifeCycle* ret = dynamic_cast<BusinessLogicLifeCycle*>(obj);
	if (ret) {
		ret->addref();
	}
	IBusinessLogicLifeCycle_tie* ret_ = NULL;
	BusinessLogicLifeCycle_tie::make_tie (ret, ret_);
	return ret_;
}

void BusinessLogicLifeCycle_tie::make_cpp (const IBusinessLogicLifeCycle_tie* obj, BusinessLogicLifeCycle*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<BusinessLogicLifeCycle*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void BusinessLogicLifeCycle_tie::make_tie (const BusinessLogicLifeCycle* obj, IBusinessLogicLifeCycle_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		BusinessLogicLifeCycle_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<BusinessLogicLifeCycle*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void BusinessLogicLifeCycle_tie::make_tie (const BusinessLogicLifeCycle& obj, IBusinessLogicLifeCycle_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	BusinessLogicLifeCycle_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<BusinessLogicLifeCycle*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* BusinessLogicLifeCycle_tie::get_impl () const {
	return m_impl;
}

void __stdcall BusinessLogicLifeCycle_tie::start_478619CE0231 () {
_DLL_TRY

	m_impl->start();
_DLL_CATCH
}

void __stdcall BusinessLogicLifeCycle_tie::stop_478619F80225 () {
_DLL_TRY

	m_impl->stop();
_DLL_CATCH
}



const ::Core::ComIID ConsultingRequests_tie::s_com_iid = {0xEB5AE11E, 0x74DA, 0x4DFE, {0x95, 0x0B, 0xCE, 0x68, 0x58, 0x6C, 0x28, 0xF1}};

ConsultingRequests_tie::IidRegistrator ConsultingRequests_tie::s_iid_registrator;

ConsultingRequests_tie::ConsultingRequests_tie () : m_impl(NULL) {
}

unsigned long __stdcall ConsultingRequests_tie::query_interface (
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
unsigned long __stdcall ConsultingRequests_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ConsultingRequests_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ConsultingRequests_tie* const>(this));
	}
	return counter;
}

void ConsultingRequests_tie::init () {
		m_counter = 1;
	}

void ConsultingRequests_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ConsultingRequests_tie::cast (::Core::IObject* obj) {
	ConsultingRequests* ret = dynamic_cast<ConsultingRequests*>(obj);
	if (ret) {
		ret->addref();
	}
	IConsultingRequests_tie* ret_ = NULL;
	ConsultingRequests_tie::make_tie (ret, ret_);
	return ret_;
}

void ConsultingRequests_tie::make_cpp (const IConsultingRequests_tie* obj, ConsultingRequests*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ConsultingRequests*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ConsultingRequests_tie::make_tie (const ConsultingRequests* obj, IConsultingRequests_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ConsultingRequests_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ConsultingRequests*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ConsultingRequests_tie::make_tie (const ConsultingRequests& obj, IConsultingRequests_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ConsultingRequests_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ConsultingRequests*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ConsultingRequests_tie::get_impl () const {
	return m_impl;
}

ResultValue __stdcall ConsultingRequests_tie::erase_queries_by_id_47B0663F0363 (
	GCI::IO::IStream_tie* query
	, GCI::IO::IStream_tie*& result
) const {
_DLL_TRY
	GCI::IO::Stream* query_;
	GCI::IO::Stream_tie::make_cpp(query, query_);
	GCI::IO::Stream* result_ = 0;

	ResultValue ret = m_impl->erase_queries_by_id(query_, result_);
	GCI::IO::Stream_tie::make_tie(result_, result);
	return ret;
_DLL_CATCH
}

ResultValue __stdcall ConsultingRequests_tie::get_list_of_new_queries_4EE08E2C0010 (
	GCI::IO::IStream_tie*& result
) const {
_DLL_TRY
	GCI::IO::Stream* result_ = 0;

	ResultValue ret = m_impl->get_list_of_new_queries(result_);
	GCI::IO::Stream_tie::make_tie(result_, result);
	return ret;
_DLL_CATCH
}

ResultValue __stdcall ConsultingRequests_tie::get_next_mark_442BFFFE038A (
	IConsultingData_tie*& data
) const {
_DLL_TRY
	ConsultingData* data_ = 0;

	ResultValue ret = m_impl->get_next_mark(data_);
	ConsultingData_tie::make_tie(data_, data);
	return ret;
_DLL_CATCH
}

ResultValue __stdcall ConsultingRequests_tie::get_query_by_id_442BFF9202EE (
	const QueryID query_id
	, IConsultingData_tie*& data
) const {
_DLL_TRY
	ConsultingData* data_ = 0;

	ResultValue ret = m_impl->get_query_by_id(query_id, data_);
	ConsultingData_tie::make_tie(data_, data);
	return ret;
_DLL_CATCH
}

ResultValue __stdcall ConsultingRequests_tie::get_status_statistic_45B49CBD03B9 (
	GCI::IO::IStream_tie* query
	, GCI::IO::IStream_tie*& result
) const {
_DLL_TRY
	GCI::IO::Stream* query_;
	GCI::IO::Stream_tie::make_cpp(query, query_);
	GCI::IO::Stream* result_ = 0;

	ResultValue ret = m_impl->get_status_statistic(query_, result_);
	GCI::IO::Stream_tie::make_tie(result_, result);
	return ret;
_DLL_CATCH
}

ResultValue __stdcall ConsultingRequests_tie::set_answer_442C007702FD (
	GCI::IO::IStream_tie* answer
) const {
_DLL_TRY
	GCI::IO::Stream* answer_;
	GCI::IO::Stream_tie::make_cpp(answer, answer_);

	ResultValue ret = m_impl->set_answer(answer_);
	return ret;
_DLL_CATCH
}

ResultValue __stdcall ConsultingRequests_tie::sign_query_484402BF023D (
	GCI::IO::IStream_tie* query
	, GCI::IO::IStream_tie*& signed_query
) const {
_DLL_TRY
	GCI::IO::Stream* query_;
	GCI::IO::Stream_tie::make_cpp(query, query_);
	GCI::IO::Stream* signed_query_ = 0;

	ResultValue ret = m_impl->sign_query(query_, signed_query_);
	GCI::IO::Stream_tie::make_tie(signed_query_, signed_query);
	return ret;
_DLL_CATCH
}



} // namespace HCInterfaces
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

