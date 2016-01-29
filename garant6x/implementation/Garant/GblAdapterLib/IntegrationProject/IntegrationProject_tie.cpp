////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// Пакет для проекта интеграции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID Integration_tie::s_com_iid = {0x7D2AE9F6, 0xBB67, 0x44E2, {0xB9, 0xAC, 0x70, 0x5E, 0x22, 0x93, 0x17, 0x8D}};

Integration_tie::IidRegistrator Integration_tie::s_iid_registrator;

Integration_tie::Integration_tie () : m_impl(NULL) {
}

unsigned long __stdcall Integration_tie::query_interface (
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
unsigned long __stdcall Integration_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Integration_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Integration_tie* const>(this));
	}
	return counter;
}

void Integration_tie::init () {
		m_counter = 1;
	}

void Integration_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Integration_tie::cast (::Core::IObject* obj) {
	Integration* ret = dynamic_cast<Integration*>(obj);
	if (ret) {
		ret->addref();
	}
	IIntegration_tie* ret_ = NULL;
	Integration_tie::make_tie (ret, ret_);
	return ret_;
}

void Integration_tie::make_cpp (const IIntegration_tie* obj, Integration*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Integration*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Integration_tie::make_tie (const Integration* obj, IIntegration_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Integration_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Integration*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Integration_tie::make_tie (const Integration& obj, IIntegration_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Integration_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Integration*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Integration_tie::get_impl () const {
	return m_impl;
}

void __stdcall Integration_tie::get_integration_complect_id_463F4FA3006D (
	GCI::IO::IString_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_integration_complect_id();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

IntegrationType __stdcall Integration_tie::get_object_by_xml_463F4FF5032C (
	const char* xml
	, Core::IIObject_tie*& result
) const /*throw (CanNotFindData_tie, InvalidXMLType_tie, CantCreateObject_tie)*/ {
_DLL_TRY
	Core::IObject* result_ = 0;

	IntegrationType ret = m_impl->get_object_by_xml(xml, result_);
	Core::IObject_tie::make_tie(result_, result);
	return ret;
_DLL_CATCH
}


const bool __stdcall Integration_tie::get_integration_enabled () const {
_DLL_TRY
	return m_impl->get_integration_enabled();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

