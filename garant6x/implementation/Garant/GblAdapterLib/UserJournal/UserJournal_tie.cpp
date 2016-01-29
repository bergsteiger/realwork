////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID UserJournal_tie::s_com_iid = {0x30769E5F, 0x13F7, 0x406E, {0x8E, 0x2A, 0x2D, 0x35, 0xB8, 0xBE, 0x51, 0x92}};

UserJournal_tie::IidRegistrator UserJournal_tie::s_iid_registrator;

UserJournal_tie::UserJournal_tie () : m_impl(NULL) {
}

unsigned long __stdcall UserJournal_tie::query_interface (
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
unsigned long __stdcall UserJournal_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall UserJournal_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<UserJournal_tie* const>(this));
	}
	return counter;
}

void UserJournal_tie::init () {
		m_counter = 1;
	}

void UserJournal_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* UserJournal_tie::cast (::Core::IObject* obj) {
	UserJournal* ret = dynamic_cast<UserJournal*>(obj);
	if (ret) {
		ret->addref();
	}
	IUserJournal_tie* ret_ = NULL;
	UserJournal_tie::make_tie (ret, ret_);
	return ret_;
}

void UserJournal_tie::make_cpp (const IUserJournal_tie* obj, UserJournal*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<UserJournal*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void UserJournal_tie::make_tie (const UserJournal* obj, IUserJournal_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		UserJournal_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<UserJournal*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void UserJournal_tie::make_tie (const UserJournal& obj, IUserJournal_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	UserJournal_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<UserJournal*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* UserJournal_tie::get_impl () const {
	return m_impl;
}

void __stdcall UserJournal_tie::clear_4A7FFA7B03B3 () const {
_DLL_TRY

	m_impl->clear();
_DLL_CATCH
}

void __stdcall UserJournal_tie::get_bookmark_history_4A8000BD0335 (
	BookmarkJournalType type
	, long max_count
	, JournalBookmarkList_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<JournalBookmarkList> ret = m_impl->get_bookmark_history(type, max_count);
	JournalBookmarkList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall UserJournal_tie::get_query_history_4A8000D00269 (
	QueryType query_type
	, long max_count
	, QueryList_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<QueryList> ret = m_impl->get_query_history(query_type, max_count);
	QueryList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall UserJournal_tie::get_user_jornal_tree_4A7FFAB30168 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_user_jornal_tree();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall UserJournal_tie::remove_4A7FF9CA0176 (
	const INodeBase_tie* obj
) const {
_DLL_TRY
	NodeBase* obj_;
	NodeBase_tie::make_cpp(obj, obj_);

	m_impl->remove(obj_);
_DLL_CATCH
}

void __stdcall UserJournal_tie::save_4A7FF7B40013 (
	const Core::IIObject_tie* obj
	, JournalObjectType object_type
) const {
_DLL_TRY
	Core::IObject* obj_;
	Core::IObject_tie::make_cpp(obj, obj_);

	m_impl->save(obj_, object_type);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

