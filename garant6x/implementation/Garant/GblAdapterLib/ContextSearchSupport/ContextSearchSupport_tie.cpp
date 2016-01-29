////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ContextSearchSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID HighlightPositionList_tie::s_com_iid = {0x0311883B, 0x7352, 0x4AA9, {0x8B, 0x38, 0xB8, 0x53, 0xD9, 0xB3, 0x7F, 0xF8}};

unsigned long __stdcall HighlightPositionList_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return 0x80004002UL;
	}
}

unsigned long __stdcall HighlightPositionList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall HighlightPositionList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<HighlightPositionList_tie* const>(this));
	}
	return counter;
}

void HighlightPositionList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void HighlightPositionList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

HighlightPositionList_tie::HighlightPositionList_tie () : m_impl(NULL), m_orphan(true) {
}

void HighlightPositionList_tie::make_cpp (const HighlightPositionList_tie* obj, HighlightPositionList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void HighlightPositionList_tie::new_tie (HighlightPositionList* obj, HighlightPositionList_tie*& ret_) {
	Core::Aptr<HighlightPositionList> obj_aptr (obj);
	if (obj_aptr.is_nil ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}

void HighlightPositionList_tie::make_tie (HighlightPositionList* obj, HighlightPositionList_tie*& ret_) {
	Core::Aptr<HighlightPositionList> obj_aptr (obj);
	if (obj_aptr.is_nil () || obj_aptr->empty ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}
	
void HighlightPositionList_tie::make_tie (const HighlightPositionList& obj, HighlightPositionList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new HighlightPositionList (obj);
	} else {
		ret_ = NULL;
	}
}

void HighlightPositionList_tie::make_tie (const HighlightPositionList& obj, HighlightPositionList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<HighlightPositionList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall HighlightPositionList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall HighlightPositionList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall HighlightPositionList_tie::clear () {
	m_impl->clear();
}

void __stdcall HighlightPositionList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall HighlightPositionList_tie::get_item (size_t index, HighlightPosition& ret_) {
	if ((size_t)index < m_impl->size()) {
		ret_ = *(*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall HighlightPositionList_tie::set_item (size_t index, const HighlightPosition& item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall HighlightPositionList_tie::add (const HighlightPosition& item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall HighlightPositionList_tie::insert (size_t index, const HighlightPosition& item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void ContextSearchResult_tie::make_cpp (const ContextSearchResult_tie& obj, ContextSearchResult& ret_) {
		ret_.item_index = obj.item_index;
		HighlightPositionList* ret_positions_;
		HighlightPositionList_tie::make_cpp (obj.positions, ret_positions_);
		ret_.positions = *ret_positions_;
}

void ContextSearchResult_tie::make_tie (const ContextSearchResult& obj, ContextSearchResult_tie& ret_) {
		ret_.item_index = obj.item_index;
		ret_.positions = 0;
		HighlightPositionList_tie::make_tie (obj.positions, ret_.positions);
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

