////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// Список фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID PharmFirmListEntry_tie::s_com_iid = {0x7408C436, 0x42FD, 0x4AD7, {0x87, 0x9D, 0x5C, 0x26, 0x25, 0xEF, 0xAE, 0x18}};

PharmFirmListEntry_tie::IidRegistrator PharmFirmListEntry_tie::s_iid_registrator;

PharmFirmListEntry_tie::PharmFirmListEntry_tie () : m_impl(NULL) {
}

unsigned long __stdcall PharmFirmListEntry_tie::query_interface (
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
unsigned long __stdcall PharmFirmListEntry_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PharmFirmListEntry_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PharmFirmListEntry_tie* const>(this));
	}
	return counter;
}

void PharmFirmListEntry_tie::init () {
		m_counter = 1;
	}

void PharmFirmListEntry_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* PharmFirmListEntry_tie::cast (::Core::IObject* obj) {
	PharmFirmListEntry* ret = dynamic_cast<PharmFirmListEntry*>(obj);
	if (ret) {
		ret->addref();
	}
	IPharmFirmListEntry_tie* ret_ = NULL;
	PharmFirmListEntry_tie::make_tie (ret, ret_);
	return ret_;
}

void PharmFirmListEntry_tie::make_cpp (const IPharmFirmListEntry_tie* obj, PharmFirmListEntry*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<PharmFirmListEntry*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void PharmFirmListEntry_tie::make_tie (const PharmFirmListEntry* obj, IPharmFirmListEntry_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		PharmFirmListEntry_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<PharmFirmListEntry*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void PharmFirmListEntry_tie::make_tie (const PharmFirmListEntry& obj, IPharmFirmListEntry_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	PharmFirmListEntry_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<PharmFirmListEntry*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* PharmFirmListEntry_tie::get_impl () const {
	return m_impl;
}


bool __stdcall PharmFirmListEntry_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall PharmFirmListEntry_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall PharmFirmListEntry_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall PharmFirmListEntry_tie::save_to_456EB3E10178 (
	IEntityStorage_tie* storage
	, IEntityStorage_tie*& ret_
) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/ {
_DLL_TRY
	EntityStorage* storage_;
	EntityStorage_tie::make_cpp(storage, storage_);

	EntityStorage* ret = m_impl->save_to(storage_);
	EntityStorage_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall PharmFirmListEntry_tie::append_to_456EB3E1017A (
	IEntityStorage_tie* storage
	, IEntityStorage_tie*& ret_
) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/ {
_DLL_TRY
	EntityStorage* storage_;
	EntityStorage_tie::make_cpp(storage, storage_);

	EntityStorage* ret = m_impl->append_to(storage_);
	EntityStorage_tie::make_tie(ret, ret_);
_DLL_CATCH
}
void __stdcall PharmFirmListEntry_tie::get_document_47E8E09A02D3 (
	IDocument_tie*& ret_
) const {
_DLL_TRY

	Document* ret = m_impl->get_document();
	Document_tie::make_tie(ret, ret_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

