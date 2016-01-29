////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Tips/Tips_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// Совет дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/Tips_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID TipsManager_tie::s_com_iid = {0xE7AFD5DA, 0x77C8, 0x4E4E, {0x95, 0xC3, 0xD5, 0x4C, 0xBB, 0x8C, 0xD5, 0xD7}};

TipsManager_tie::IidRegistrator TipsManager_tie::s_iid_registrator;

TipsManager_tie::TipsManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall TipsManager_tie::query_interface (
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
unsigned long __stdcall TipsManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall TipsManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<TipsManager_tie* const>(this));
	}
	return counter;
}

void TipsManager_tie::init () {
		m_counter = 1;
	}

void TipsManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* TipsManager_tie::cast (::Core::IObject* obj) {
	TipsManager* ret = dynamic_cast<TipsManager*>(obj);
	if (ret) {
		ret->addref();
	}
	ITipsManager_tie* ret_ = NULL;
	TipsManager_tie::make_tie (ret, ret_);
	return ret_;
}

void TipsManager_tie::make_cpp (const ITipsManager_tie* obj, TipsManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<TipsManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void TipsManager_tie::make_tie (const TipsManager* obj, ITipsManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		TipsManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<TipsManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void TipsManager_tie::make_tie (const TipsManager& obj, ITipsManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	TipsManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<TipsManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* TipsManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall TipsManager_tie::get_current_tip_47B572E3010B (
	NodeIndexPath_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<NodeIndexPath> ret = m_impl->get_current_tip();
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

bool __stdcall TipsManager_tie::is_exist_47B93A910257 () const {
_DLL_TRY
	return m_impl->is_exist ();
_DLL_CATCH
}


void __stdcall TipsManager_tie::get_tips_tree_root (INodeBase_tie*& ret_) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_tips_tree_root(), ret_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

