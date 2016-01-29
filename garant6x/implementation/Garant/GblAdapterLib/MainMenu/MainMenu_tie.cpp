////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID SectionItem_tie::s_com_iid = {0x257ACC4A, 0x9B2A, 0x4AD1, {0xB2, 0x38, 0x0C, 0xDC, 0xE6, 0xA5, 0x40, 0x6E}};

SectionItem_tie::IidRegistrator SectionItem_tie::s_iid_registrator;

SectionItem_tie::SectionItem_tie () : m_impl(NULL) {
}

unsigned long __stdcall SectionItem_tie::query_interface (
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
unsigned long __stdcall SectionItem_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SectionItem_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SectionItem_tie* const>(this));
	}
	return counter;
}

void SectionItem_tie::init () {
		m_counter = 1;
	}

void SectionItem_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* SectionItem_tie::cast (::Core::IObject* obj) {
	SectionItem* ret = dynamic_cast<SectionItem*>(obj);
	if (ret) {
		ret->addref();
	}
	ISectionItem_tie* ret_ = NULL;
	SectionItem_tie::make_tie (ret, ret_);
	return ret_;
}

void SectionItem_tie::make_cpp (const ISectionItem_tie* obj, SectionItem*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<SectionItem*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void SectionItem_tie::make_tie (const SectionItem* obj, ISectionItem_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		SectionItem_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<SectionItem*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void SectionItem_tie::make_tie (const SectionItem& obj, ISectionItem_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	SectionItem_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<SectionItem*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* SectionItem_tie::get_impl () const {
	return m_impl;
}


void __stdcall SectionItem_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_);
_DLL_CATCH
}

void __stdcall SectionItem_tie::open_4E36C80302E6 (
	Core::IIObject_tie*& ret_
) const {
_DLL_TRY

	Core::IObject* ret = m_impl->open();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID SectionItemList_tie::s_com_iid = {0xF4314383, 0x3A43, 0x4E2F, {0x90, 0x8F, 0x25, 0x7A, 0xE0, 0xA6, 0x7C, 0x62}};

unsigned long __stdcall SectionItemList_tie::query_interface (
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

unsigned long __stdcall SectionItemList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SectionItemList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SectionItemList_tie* const>(this));
	}
	return counter;
}

void SectionItemList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void SectionItemList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

SectionItemList_tie::SectionItemList_tie () : m_impl(NULL), m_orphan(true) {
}

void SectionItemList_tie::make_cpp (const SectionItemList_tie* obj, SectionItemList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void SectionItemList_tie::new_tie (SectionItemList* obj, SectionItemList_tie*& ret_) {
	Core::Aptr<SectionItemList> obj_aptr (obj);
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

void SectionItemList_tie::make_tie (SectionItemList* obj, SectionItemList_tie*& ret_) {
	Core::Aptr<SectionItemList> obj_aptr (obj);
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
	
void SectionItemList_tie::make_tie (const SectionItemList& obj, SectionItemList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new SectionItemList (obj);
	} else {
		ret_ = NULL;
	}
}

void SectionItemList_tie::make_tie (const SectionItemList& obj, SectionItemList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<SectionItemList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall SectionItemList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall SectionItemList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall SectionItemList_tie::clear () {
	m_impl->clear();
}

void __stdcall SectionItemList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall SectionItemList_tie::get_item (size_t index, ISectionItem_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		SectionItem_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall SectionItemList_tie::set_item (size_t index, const ISectionItem_tie* item) {
	if ((size_t)index < m_impl->size()) {
		SectionItem* item_;
		SectionItem_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall SectionItemList_tie::add (const ISectionItem_tie* item) {
	SectionItem* item_;
	SectionItem_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall SectionItemList_tie::insert (size_t index, const ISectionItem_tie* item) {
	if ((size_t)index < m_impl->size()) {
		SectionItem* item_;
		SectionItem_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Section_tie::s_com_iid = {0xBBB2D3C6, 0x226C, 0x4A9F, {0xAA, 0xC6, 0x32, 0x77, 0x5E, 0x30, 0xB7, 0xC7}};

Section_tie::IidRegistrator Section_tie::s_iid_registrator;

Section_tie::Section_tie () : m_impl(NULL) {
}

unsigned long __stdcall Section_tie::query_interface (
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
unsigned long __stdcall Section_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Section_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Section_tie* const>(this));
	}
	return counter;
}

void Section_tie::init () {
		m_counter = 1;
	}

void Section_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Section_tie::cast (::Core::IObject* obj) {
	Section* ret = dynamic_cast<Section*>(obj);
	if (ret) {
		ret->addref();
	}
	ISection_tie* ret_ = NULL;
	Section_tie::make_tie (ret, ret_);
	return ret_;
}

void Section_tie::make_cpp (const ISection_tie* obj, Section*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Section*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Section_tie::make_tie (const Section* obj, ISection_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Section_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Section*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Section_tie::make_tie (const Section& obj, ISection_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Section_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Section*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Section_tie::get_impl () const {
	return m_impl;
}


void __stdcall Section_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_);
_DLL_CATCH
}

void __stdcall Section_tie::get_items_4E37CA4300B7 (
	SectionItemList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<SectionItemList> ret = m_impl->get_items();
	SectionItemList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}



const ::Core::ComIID MainMenu_tie::s_com_iid = {0x7EAB7EE0, 0x39FB, 0x42FD, {0xBE, 0x38, 0xAF, 0x66, 0x7A, 0xE0, 0x46, 0x6E}};

MainMenu_tie::IidRegistrator MainMenu_tie::s_iid_registrator;

MainMenu_tie::MainMenu_tie () : m_impl(NULL) {
}

unsigned long __stdcall MainMenu_tie::query_interface (
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
unsigned long __stdcall MainMenu_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MainMenu_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MainMenu_tie* const>(this));
	}
	return counter;
}

void MainMenu_tie::init () {
		m_counter = 1;
	}

void MainMenu_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* MainMenu_tie::cast (::Core::IObject* obj) {
	MainMenu* ret = dynamic_cast<MainMenu*>(obj);
	if (ret) {
		ret->addref();
	}
	IMainMenu_tie* ret_ = NULL;
	MainMenu_tie::make_tie (ret, ret_);
	return ret_;
}

void MainMenu_tie::make_cpp (const IMainMenu_tie* obj, MainMenu*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<MainMenu*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void MainMenu_tie::make_tie (const MainMenu* obj, IMainMenu_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		MainMenu_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<MainMenu*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void MainMenu_tie::make_tie (const MainMenu& obj, IMainMenu_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	MainMenu_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<MainMenu*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* MainMenu_tie::get_impl () const {
	return m_impl;
}

void __stdcall MainMenu_tie::get_base_search_panes_4DD24C3000F5 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_base_search_panes();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall MainMenu_tie::get_section_4E3012910002 (
	SectionType type
	, ISection_tie*& ret_
) const {
_DLL_TRY

	const Section& ret = m_impl->get_section(type);
	Section_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

