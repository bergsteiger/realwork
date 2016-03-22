////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID MissingInfo_tie::s_com_iid = {0x5553DE6A, 0x23C5, 0x4B12, {0x8A, 0x98, 0x35, 0x8C, 0xF0, 0x8F, 0x6E, 0x59}};

MissingInfo_tie::IidRegistrator MissingInfo_tie::s_iid_registrator;

MissingInfo_tie::MissingInfo_tie () : m_impl(NULL) {
}

unsigned long __stdcall MissingInfo_tie::query_interface (
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
unsigned long __stdcall MissingInfo_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MissingInfo_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MissingInfo_tie* const>(this));
	}
	return counter;
}

void MissingInfo_tie::init () {
		m_counter = 1;
	}

void MissingInfo_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* MissingInfo_tie::cast (::Core::IObject* obj) {
	MissingInfo* ret = dynamic_cast<MissingInfo*>(obj);
	if (ret) {
		ret->addref();
	}
	IMissingInfo_tie* ret_ = NULL;
	MissingInfo_tie::make_tie (ret, ret_);
	return ret_;
}

void MissingInfo_tie::make_cpp (const IMissingInfo_tie* obj, MissingInfo*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<MissingInfo*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void MissingInfo_tie::make_tie (const MissingInfo* obj, IMissingInfo_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		MissingInfo_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<MissingInfo*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void MissingInfo_tie::make_tie (const MissingInfo& obj, IMissingInfo_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	MissingInfo_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<MissingInfo*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* MissingInfo_tie::get_impl () const {
	return m_impl;
}


void __stdcall MissingInfo_tie::get_blocks_info (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_blocks_info(), ret_, this);
_DLL_CATCH
}

bool __stdcall MissingInfo_tie::is_one_block_45EEB652030A () const {
_DLL_TRY
	return m_impl->is_one_block ();
_DLL_CATCH
}


void __stdcall MissingInfo_tie::get_obj_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_obj_name(), ret_, this);
_DLL_CATCH
}



void TimeMachineWarning_tie::make_cpp (const TimeMachineWarning_tie& obj, TimeMachineWarning& ret_) {
		GCI::IO::String_tie::make_cpp (obj.warning, ret_.warning.out (), true);
		ret_.type = obj.type;
}

void TimeMachineWarning_tie::make_tie (const TimeMachineWarning& obj, TimeMachineWarning_tie& ret_) {
		ret_.warning = 0;
		GCI::IO::String_tie::make_tie (obj.warning.in (), ret_.warning, true);
		ret_.type = obj.type;
}


const ::Core::ComIID PositionList_tie::s_com_iid = {0x4C6C46F0, 0xB4AF, 0x4099, {0xBF, 0xA3, 0x21, 0xB6, 0x31, 0xF6, 0x72, 0xF6}};

unsigned long __stdcall PositionList_tie::query_interface (
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

unsigned long __stdcall PositionList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PositionList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PositionList_tie* const>(this));
	}
	return counter;
}

void PositionList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void PositionList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

PositionList_tie::PositionList_tie () : m_impl(NULL), m_orphan(true) {
}

void PositionList_tie::make_cpp (const PositionList_tie* obj, PositionList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void PositionList_tie::new_tie (PositionList* obj, PositionList_tie*& ret_) {
	Core::Aptr<PositionList> obj_aptr (obj);
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

void PositionList_tie::make_tie (PositionList* obj, PositionList_tie*& ret_) {
	Core::Aptr<PositionList> obj_aptr (obj);
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
	
void PositionList_tie::make_tie (const PositionList& obj, PositionList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new PositionList (obj);
	} else {
		ret_ = NULL;
	}
}

void PositionList_tie::make_tie (const PositionList& obj, PositionList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<PositionList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall PositionList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall PositionList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall PositionList_tie::clear () {
	m_impl->clear();
}

void __stdcall PositionList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall PositionList_tie::get_item (size_t index, Position& ret_) {
	if ((size_t)index < m_impl->size()) {
		ret_ = (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall PositionList_tie::set_item (size_t index, const Position& item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall PositionList_tie::add (const Position& item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall PositionList_tie::insert (size_t index, const Position& item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID ActiveIntervalList_tie::s_com_iid = {0xA47493FA, 0x0883, 0x40CB, {0x9D, 0x8C, 0xE0, 0x10, 0x0F, 0x2F, 0xFE, 0x69}};

unsigned long __stdcall ActiveIntervalList_tie::query_interface (
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

unsigned long __stdcall ActiveIntervalList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ActiveIntervalList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ActiveIntervalList_tie* const>(this));
	}
	return counter;
}

void ActiveIntervalList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ActiveIntervalList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ActiveIntervalList_tie::ActiveIntervalList_tie () : m_impl(NULL), m_orphan(true) {
}

void ActiveIntervalList_tie::make_cpp (const ActiveIntervalList_tie* obj, ActiveIntervalList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ActiveIntervalList_tie::new_tie (ActiveIntervalList* obj, ActiveIntervalList_tie*& ret_) {
	Core::Aptr<ActiveIntervalList> obj_aptr (obj);
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

void ActiveIntervalList_tie::make_tie (ActiveIntervalList* obj, ActiveIntervalList_tie*& ret_) {
	Core::Aptr<ActiveIntervalList> obj_aptr (obj);
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
	
void ActiveIntervalList_tie::make_tie (const ActiveIntervalList& obj, ActiveIntervalList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ActiveIntervalList (obj);
	} else {
		ret_ = NULL;
	}
}

void ActiveIntervalList_tie::make_tie (const ActiveIntervalList& obj, ActiveIntervalList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ActiveIntervalList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ActiveIntervalList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ActiveIntervalList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ActiveIntervalList_tie::clear () {
	m_impl->clear();
}

void __stdcall ActiveIntervalList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ActiveIntervalList_tie::get_item (size_t index, DateInterval& ret_) {
	if ((size_t)index < m_impl->size()) {
		ret_ = (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ActiveIntervalList_tie::set_item (size_t index, const DateInterval& item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ActiveIntervalList_tie::add (const DateInterval& item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall ActiveIntervalList_tie::insert (size_t index, const DateInterval& item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void NotSureInfo_tie::make_cpp (const NotSureInfo_tie& obj, NotSureInfo& ret_) {
		GCI::IO::String_tie::make_cpp (obj.warning, ret_.warning.out (), true);
		ret_.interval = obj.interval;
}

void NotSureInfo_tie::make_tie (const NotSureInfo& obj, NotSureInfo_tie& ret_) {
		ret_.warning = 0;
		GCI::IO::String_tie::make_tie (obj.warning.in (), ret_.warning, true);
		ret_.interval = obj.interval;
}


const ::Core::ComIID NotSureIntervalList_tie::s_com_iid = {0xC5D28F6C, 0x4EDE, 0x4083, {0x88, 0x9D, 0xC5, 0xD2, 0xA4, 0xD4, 0x76, 0xD4}};

unsigned long __stdcall NotSureIntervalList_tie::query_interface (
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

unsigned long __stdcall NotSureIntervalList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NotSureIntervalList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NotSureIntervalList_tie* const>(this));
	}
	return counter;
}

void NotSureIntervalList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void NotSureIntervalList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

NotSureIntervalList_tie::NotSureIntervalList_tie () : m_impl(NULL), m_orphan(true) {
}

void NotSureIntervalList_tie::make_cpp (const NotSureIntervalList_tie* obj, NotSureIntervalList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void NotSureIntervalList_tie::new_tie (NotSureIntervalList* obj, NotSureIntervalList_tie*& ret_) {
	Core::Aptr<NotSureIntervalList> obj_aptr (obj);
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

void NotSureIntervalList_tie::make_tie (NotSureIntervalList* obj, NotSureIntervalList_tie*& ret_) {
	Core::Aptr<NotSureIntervalList> obj_aptr (obj);
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
	
void NotSureIntervalList_tie::make_tie (const NotSureIntervalList& obj, NotSureIntervalList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new NotSureIntervalList (obj);
	} else {
		ret_ = NULL;
	}
}

void NotSureIntervalList_tie::make_tie (const NotSureIntervalList& obj, NotSureIntervalList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<NotSureIntervalList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall NotSureIntervalList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall NotSureIntervalList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall NotSureIntervalList_tie::clear () {
	m_impl->clear();
}

void __stdcall NotSureIntervalList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall NotSureIntervalList_tie::get_item (size_t index, NotSureInfo_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		NotSureInfo_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall NotSureIntervalList_tie::set_item (size_t index, const NotSureInfo_tie& item) {
	if ((size_t)index < m_impl->size()) {
		NotSureInfo item_;
		NotSureInfo_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall NotSureIntervalList_tie::add (const NotSureInfo_tie& item) {
	NotSureInfo item_;
	NotSureInfo_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall NotSureIntervalList_tie::insert (size_t index, const NotSureInfo_tie& item) {
	if ((size_t)index < m_impl->size()) {
		NotSureInfo item_;
		NotSureInfo_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void RedactionSourceDocumentInfo_tie::make_cpp (const RedactionSourceDocumentInfo_tie& obj, RedactionSourceDocumentInfo& ret_) {
		GCI::IO::String_tie::make_cpp (obj.display_name, ret_.display_name.out (), true);
		ret_.doc_topic = obj.doc_topic;
}

void RedactionSourceDocumentInfo_tie::make_tie (const RedactionSourceDocumentInfo& obj, RedactionSourceDocumentInfo_tie& ret_) {
		ret_.display_name = 0;
		GCI::IO::String_tie::make_tie (obj.display_name.in (), ret_.display_name, true);
		ret_.doc_topic = obj.doc_topic;
}


const ::Core::ComIID RedactionSourceDocumentInfoList_tie::s_com_iid = {0xB5DAB5E0, 0xADA1, 0x4FD3, {0xAE, 0xD4, 0x88, 0x47, 0xE3, 0x4E, 0xF3, 0x01}};

unsigned long __stdcall RedactionSourceDocumentInfoList_tie::query_interface (
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

unsigned long __stdcall RedactionSourceDocumentInfoList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall RedactionSourceDocumentInfoList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<RedactionSourceDocumentInfoList_tie* const>(this));
	}
	return counter;
}

void RedactionSourceDocumentInfoList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void RedactionSourceDocumentInfoList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

RedactionSourceDocumentInfoList_tie::RedactionSourceDocumentInfoList_tie () : m_impl(NULL), m_orphan(true) {
}

void RedactionSourceDocumentInfoList_tie::make_cpp (const RedactionSourceDocumentInfoList_tie* obj, RedactionSourceDocumentInfoList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void RedactionSourceDocumentInfoList_tie::new_tie (RedactionSourceDocumentInfoList* obj, RedactionSourceDocumentInfoList_tie*& ret_) {
	Core::Aptr<RedactionSourceDocumentInfoList> obj_aptr (obj);
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

void RedactionSourceDocumentInfoList_tie::make_tie (RedactionSourceDocumentInfoList* obj, RedactionSourceDocumentInfoList_tie*& ret_) {
	Core::Aptr<RedactionSourceDocumentInfoList> obj_aptr (obj);
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
	
void RedactionSourceDocumentInfoList_tie::make_tie (const RedactionSourceDocumentInfoList& obj, RedactionSourceDocumentInfoList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new RedactionSourceDocumentInfoList (obj);
	} else {
		ret_ = NULL;
	}
}

void RedactionSourceDocumentInfoList_tie::make_tie (const RedactionSourceDocumentInfoList& obj, RedactionSourceDocumentInfoList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<RedactionSourceDocumentInfoList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall RedactionSourceDocumentInfoList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall RedactionSourceDocumentInfoList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall RedactionSourceDocumentInfoList_tie::clear () {
	m_impl->clear();
}

void __stdcall RedactionSourceDocumentInfoList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall RedactionSourceDocumentInfoList_tie::get_item (size_t index, RedactionSourceDocumentInfo_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		RedactionSourceDocumentInfo_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall RedactionSourceDocumentInfoList_tie::set_item (size_t index, const RedactionSourceDocumentInfo_tie& item) {
	if ((size_t)index < m_impl->size()) {
		RedactionSourceDocumentInfo item_;
		RedactionSourceDocumentInfo_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall RedactionSourceDocumentInfoList_tie::add (const RedactionSourceDocumentInfo_tie& item) {
	RedactionSourceDocumentInfo item_;
	RedactionSourceDocumentInfo_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall RedactionSourceDocumentInfoList_tie::insert (size_t index, const RedactionSourceDocumentInfo_tie& item) {
	if ((size_t)index < m_impl->size()) {
		RedactionSourceDocumentInfo item_;
		RedactionSourceDocumentInfo_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void LinkInfo_tie::make_cpp (const LinkInfo_tie& obj, LinkInfo& ret_) {
		ret_.kind = obj.kind;
		GCI::IO::String_tie::make_cpp (obj.hint, ret_.hint.out (), true);
}

void LinkInfo_tie::make_tie (const LinkInfo& obj, LinkInfo_tie& ret_) {
		ret_.kind = obj.kind;
		ret_.hint = 0;
		GCI::IO::String_tie::make_tie (obj.hint.in (), ret_.hint, true);
}


const ::Core::ComIID DiffIterator_tie::s_com_iid = {0xA9AA18D9, 0xF87F, 0x4A47, {0x98, 0x8B, 0x78, 0x9A, 0xA0, 0x69, 0xEE, 0xE0}};

DiffIterator_tie::IidRegistrator DiffIterator_tie::s_iid_registrator;

DiffIterator_tie::DiffIterator_tie () : m_impl(NULL) {
}

unsigned long __stdcall DiffIterator_tie::query_interface (
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
unsigned long __stdcall DiffIterator_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DiffIterator_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DiffIterator_tie* const>(this));
	}
	return counter;
}

void DiffIterator_tie::init () {
		m_counter = 1;
	}

void DiffIterator_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DiffIterator_tie::cast (::Core::IObject* obj) {
	DiffIterator* ret = dynamic_cast<DiffIterator*>(obj);
	if (ret) {
		ret->addref();
	}
	IDiffIterator_tie* ret_ = NULL;
	DiffIterator_tie::make_tie (ret, ret_);
	return ret_;
}

void DiffIterator_tie::make_cpp (const IDiffIterator_tie* obj, DiffIterator*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DiffIterator*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DiffIterator_tie::make_tie (const DiffIterator* obj, IDiffIterator_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DiffIterator_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DiffIterator*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DiffIterator_tie::make_tie (const DiffIterator& obj, IDiffIterator_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DiffIterator_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DiffIterator*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DiffIterator_tie::get_impl () const {
	return m_impl;
}

ParaNum __stdcall DiffIterator_tie::acquire_next_4B601C0800C3 () const {
_DLL_TRY
	return m_impl->acquire_next ();
_DLL_CATCH
}

ParaNum __stdcall DiffIterator_tie::acquire_prev_4B62D7640025 () const {
_DLL_TRY
	return m_impl->acquire_prev ();
_DLL_CATCH
}

bool __stdcall DiffIterator_tie::has_next_4B4EE0E000B0 () const {
_DLL_TRY
	return m_impl->has_next ();
_DLL_CATCH
}

bool __stdcall DiffIterator_tie::has_prev_4B4EE1060152 () const {
_DLL_TRY
	return m_impl->has_prev ();
_DLL_CATCH
}

void __stdcall DiffIterator_tie::move_to_4B4EE16E00EC (
	ParaNum para
) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	m_impl->move_to(para);
_DLL_CATCH
}

ParaNum __stdcall DiffIterator_tie::next_4B4EE1330087 () /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	return m_impl->next ();
_DLL_CATCH
}

ParaNum __stdcall DiffIterator_tie::prev_4B4EE156033B () /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	return m_impl->prev ();
_DLL_CATCH
}



void Context_tie::make_cpp (const Context_tie& obj, Context& ret_) {
		NodeIndexPath* ret_path_;
		NodeIndexPath_tie::make_cpp (obj.path, ret_path_);
		ret_.path = *ret_path_;
		ret_.start = obj.start;
		ret_.finish = obj.finish;
}

void Context_tie::make_tie (const Context& obj, Context_tie& ret_) {
		ret_.path = 0;
		NodeIndexPath_tie::make_tie (obj.path, ret_.path);
		ret_.start = obj.start;
		ret_.finish = obj.finish;
}


void Bookmark2_tie::make_cpp (const Bookmark2_tie& obj, Bookmark2& ret_) {
		ret_.para_id = obj.para_id;
		ret_.eid = obj.eid;
		GCI::IO::String_tie::make_cpp (obj.name, ret_.name.out (), true);
}

void Bookmark2_tie::make_tie (const Bookmark2& obj, Bookmark2_tie& ret_) {
		ret_.para_id = obj.para_id;
		ret_.eid = obj.eid;
		ret_.name = 0;
		GCI::IO::String_tie::make_tie (obj.name.in (), ret_.name, true);
}


const ::Core::ComIID BookmarkList_tie::s_com_iid = {0xC3264FF1, 0x7781, 0x4EF6, {0xA2, 0x0B, 0x35, 0xD6, 0x97, 0xC0, 0x14, 0xB9}};

unsigned long __stdcall BookmarkList_tie::query_interface (
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

unsigned long __stdcall BookmarkList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall BookmarkList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<BookmarkList_tie* const>(this));
	}
	return counter;
}

void BookmarkList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void BookmarkList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

BookmarkList_tie::BookmarkList_tie () : m_impl(NULL), m_orphan(true) {
}

void BookmarkList_tie::make_cpp (const BookmarkList_tie* obj, BookmarkList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void BookmarkList_tie::new_tie (BookmarkList* obj, BookmarkList_tie*& ret_) {
	Core::Aptr<BookmarkList> obj_aptr (obj);
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

void BookmarkList_tie::make_tie (BookmarkList* obj, BookmarkList_tie*& ret_) {
	Core::Aptr<BookmarkList> obj_aptr (obj);
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
	
void BookmarkList_tie::make_tie (const BookmarkList& obj, BookmarkList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new BookmarkList (obj);
	} else {
		ret_ = NULL;
	}
}

void BookmarkList_tie::make_tie (const BookmarkList& obj, BookmarkList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<BookmarkList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall BookmarkList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall BookmarkList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall BookmarkList_tie::clear () {
	m_impl->clear();
}

void __stdcall BookmarkList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall BookmarkList_tie::get_item (size_t index, Bookmark2_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		Bookmark2_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall BookmarkList_tie::set_item (size_t index, const Bookmark2_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Bookmark2 item_;
		Bookmark2_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall BookmarkList_tie::add (const Bookmark2_tie& item) {
	Bookmark2 item_;
	Bookmark2_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall BookmarkList_tie::insert (size_t index, const Bookmark2_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Bookmark2 item_;
		Bookmark2_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID FragmentList_tie::s_com_iid = {0x2DF09B8E, 0x6C87, 0x4B00, {0x99, 0x6C, 0x00, 0x24, 0x8F, 0xC2, 0xA1, 0x2A}};

unsigned long __stdcall FragmentList_tie::query_interface (
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

unsigned long __stdcall FragmentList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FragmentList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FragmentList_tie* const>(this));
	}
	return counter;
}

void FragmentList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void FragmentList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

FragmentList_tie::FragmentList_tie () : m_impl(NULL), m_orphan(true) {
}

void FragmentList_tie::make_cpp (const FragmentList_tie* obj, FragmentList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void FragmentList_tie::new_tie (FragmentList* obj, FragmentList_tie*& ret_) {
	Core::Aptr<FragmentList> obj_aptr (obj);
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

void FragmentList_tie::make_tie (FragmentList* obj, FragmentList_tie*& ret_) {
	Core::Aptr<FragmentList> obj_aptr (obj);
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
	
void FragmentList_tie::make_tie (const FragmentList& obj, FragmentList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new FragmentList (obj);
	} else {
		ret_ = NULL;
	}
}

void FragmentList_tie::make_tie (const FragmentList& obj, FragmentList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<FragmentList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall FragmentList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall FragmentList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall FragmentList_tie::clear () {
	m_impl->clear();
}

void __stdcall FragmentList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FragmentList_tie::get_item (size_t index, Context_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		Context_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FragmentList_tie::set_item (size_t index, const Context_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Context item_;
		Context_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall FragmentList_tie::add (const Context_tie& item) {
	Context item_;
	Context_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall FragmentList_tie::insert (size_t index, const Context_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Context item_;
		Context_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID SubList_tie::s_com_iid = {0xA8A99F27, 0x9EFD, 0x4C4C, {0x87, 0x64, 0x61, 0x79, 0x8B, 0xA1, 0xC7, 0x28}};

unsigned long __stdcall SubList_tie::query_interface (
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

unsigned long __stdcall SubList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SubList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SubList_tie* const>(this));
	}
	return counter;
}

void SubList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void SubList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

SubList_tie::SubList_tie () : m_impl(NULL), m_orphan(true) {
}

void SubList_tie::make_cpp (const SubList_tie* obj, SubList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void SubList_tie::new_tie (SubList* obj, SubList_tie*& ret_) {
	Core::Aptr<SubList> obj_aptr (obj);
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

void SubList_tie::make_tie (SubList* obj, SubList_tie*& ret_) {
	Core::Aptr<SubList> obj_aptr (obj);
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
	
void SubList_tie::make_tie (const SubList& obj, SubList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new SubList (obj);
	} else {
		ret_ = NULL;
	}
}

void SubList_tie::make_tie (const SubList& obj, SubList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<SubList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall SubList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall SubList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall SubList_tie::clear () {
	m_impl->clear();
}

void __stdcall SubList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

unsigned long __stdcall SubList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall SubList_tie::set_item (size_t index, unsigned long item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall SubList_tie::add (unsigned long item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall SubList_tie::insert (size_t index, unsigned long item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID ContextList_tie::s_com_iid = {0xAEBDD974, 0x3308, 0x4D5B, {0xA7, 0x5F, 0x8B, 0x96, 0x41, 0x3A, 0x89, 0xFF}};

unsigned long __stdcall ContextList_tie::query_interface (
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

unsigned long __stdcall ContextList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ContextList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ContextList_tie* const>(this));
	}
	return counter;
}

void ContextList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ContextList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ContextList_tie::ContextList_tie () : m_impl(NULL), m_orphan(true) {
}

void ContextList_tie::make_cpp (const ContextList_tie* obj, ContextList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ContextList_tie::new_tie (ContextList* obj, ContextList_tie*& ret_) {
	Core::Aptr<ContextList> obj_aptr (obj);
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

void ContextList_tie::make_tie (ContextList* obj, ContextList_tie*& ret_) {
	Core::Aptr<ContextList> obj_aptr (obj);
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
	
void ContextList_tie::make_tie (const ContextList& obj, ContextList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ContextList (obj);
	} else {
		ret_ = NULL;
	}
}

void ContextList_tie::make_tie (const ContextList& obj, ContextList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ContextList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ContextList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ContextList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ContextList_tie::clear () {
	m_impl->clear();
}

void __stdcall ContextList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ContextList_tie::get_item (size_t index, FragmentList_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		FragmentList_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ContextList_tie::set_item (size_t index, const FragmentList_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FragmentList* item_;
		FragmentList_tie::make_cpp (item, item_);
		(*m_impl)[index] = *item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ContextList_tie::add (const FragmentList_tie* item) {
	FragmentList* item_;
	FragmentList_tie::make_cpp (item, item_);
	m_impl->push_back (*item_);
	return m_impl->size() - 1;
}

size_t __stdcall ContextList_tie::insert (size_t index, const FragmentList_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FragmentList* item_;
		FragmentList_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, *item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID FoundContext_tie::s_com_iid = {0x2852766C, 0xA9A5, 0x4A40, {0x8C, 0x9F, 0xFD, 0x95, 0x7D, 0x1D, 0x85, 0x6E}};

FoundContext_tie::IidRegistrator FoundContext_tie::s_iid_registrator;

FoundContext_tie::FoundContext_tie () : m_impl(NULL) {
}

unsigned long __stdcall FoundContext_tie::query_interface (
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
unsigned long __stdcall FoundContext_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FoundContext_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FoundContext_tie* const>(this));
	}
	return counter;
}

void FoundContext_tie::init () {
		m_counter = 1;
	}

void FoundContext_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FoundContext_tie::cast (::Core::IObject* obj) {
	FoundContext* ret = dynamic_cast<FoundContext*>(obj);
	if (ret) {
		ret->addref();
	}
	IFoundContext_tie* ret_ = NULL;
	FoundContext_tie::make_tie (ret, ret_);
	return ret_;
}

void FoundContext_tie::make_cpp (const IFoundContext_tie* obj, FoundContext*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FoundContext*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FoundContext_tie::make_tie (const FoundContext* obj, IFoundContext_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FoundContext_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FoundContext*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FoundContext_tie::make_tie (const FoundContext& obj, IFoundContext_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FoundContext_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FoundContext*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FoundContext_tie::get_impl () const {
	return m_impl;
}


void __stdcall FoundContext_tie::get_list (ContextList_tie*& ret_) const {
_DLL_TRY
	ContextList_tie::make_tie (m_impl->get_list(), ret_, this);
_DLL_CATCH
}



const ::Core::ComIID DocumentTextProvider_tie::s_com_iid = {0xEDE34F9F, 0xF36F, 0x48FA, {0x82, 0xBA, 0xFD, 0x75, 0x5C, 0xE4, 0x6B, 0x4B}};

DocumentTextProvider_tie::IidRegistrator DocumentTextProvider_tie::s_iid_registrator;

DocumentTextProvider_tie::DocumentTextProvider_tie () : m_impl(NULL) {
}

unsigned long __stdcall DocumentTextProvider_tie::query_interface (
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
unsigned long __stdcall DocumentTextProvider_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DocumentTextProvider_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DocumentTextProvider_tie* const>(this));
	}
	return counter;
}

void DocumentTextProvider_tie::init () {
		m_counter = 1;
	}

void DocumentTextProvider_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DocumentTextProvider_tie::cast (::Core::IObject* obj) {
	DocumentTextProvider* ret = dynamic_cast<DocumentTextProvider*>(obj);
	if (ret) {
		ret->addref();
	}
	IDocumentTextProvider_tie* ret_ = NULL;
	DocumentTextProvider_tie::make_tie (ret, ret_);
	return ret_;
}

void DocumentTextProvider_tie::make_cpp (const IDocumentTextProvider_tie* obj, DocumentTextProvider*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DocumentTextProvider*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DocumentTextProvider_tie::make_tie (const DocumentTextProvider* obj, IDocumentTextProvider_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DocumentTextProvider_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DocumentTextProvider*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DocumentTextProvider_tie::make_tie (const DocumentTextProvider& obj, IDocumentTextProvider_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DocumentTextProvider_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DocumentTextProvider*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DocumentTextProvider_tie::get_impl () const {
	return m_impl;
}

unsigned long __stdcall DocumentTextProvider_tie::all_leaf_para_count_4C5ABA2E0009 (
	LayerID layer_id
) /*throw (InvalidLayerID_tie)*/ {
_DLL_TRY
	return m_impl->all_leaf_para_count (layer_id);
_DLL_CATCH
}

unsigned long __stdcall DocumentTextProvider_tie::children_count_4C5ABAED00E5 (
	LayerID layer_id
) /*throw (InvalidLayerID_tie)*/ {
_DLL_TRY
	return m_impl->children_count (layer_id);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::find_block_or_sub_4C5ABB37029A (
	ExternalID id
	, NodeIndexPath_tie*& ret_
) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	const NodeIndexPath& ret = m_impl->find_block_or_sub(id);
	NodeIndexPath_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::find_context_4C5ABBC300BE (
	const GCI::IO::IString_tie* context
	, ExternalID from_id
	, IFoundContext_tie*& ret_
) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	GCI::IO::String* context_;
	GCI::IO::String_tie::make_cpp(context, context_);

	FoundContext* ret = m_impl->find_context(context_, from_id);
	FoundContext_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::find_para_4C5ABB88003B (
	ExternalID id
	, NodeIndexPath_tie*& ret_
) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<NodeIndexPath> ret = m_impl->find_para(id);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::get_child_bookmarks_4C5AB8BF0144 (
	const EntryPoint& id
	, BookmarkList_tie*& ret_
) /*throw (EmptyResult_tie, InvalidEntryPoint_tie)*/ {
_DLL_TRY

	const BookmarkList& ret = m_impl->get_child_bookmarks(id);
	BookmarkList_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::get_child_comment_4C5AB83001A2 (
	const EntryPoint& id
	, IEVDStream_tie*& ret_
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY

	const EVDStream* ret = m_impl->get_child_comment(id);
	EVDStream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::get_child_evd_style_4C5AB80A00E4 (
	const EntryPoint& id
	, IEVDStream_tie*& ret_
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY

	const EVDStream* ret = m_impl->get_child_evd_style(id);
	EVDStream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

ExternalID __stdcall DocumentTextProvider_tie::get_child_external_id_4C5AB6D90193 (
	const EntryPoint& id
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY
	return m_impl->get_child_external_id (id);
_DLL_CATCH
}

LayerID __stdcall DocumentTextProvider_tie::get_child_layer_id_4C5AB68E0235 (
	const EntryPoint& id
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY
	return m_impl->get_child_layer_id (id);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::get_child_tech_comment_4D09D82502D2 (
	const EntryPoint& id
	, GCI::IO::IString_tie*& ret_
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_child_tech_comment(id);
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::get_child_text_4C5AB9ED0306 (
	const EntryPoint& id
	, GCI::IO::IString_tie*& ret_
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY

	const GCI::IO::String* ret = m_impl->get_child_text(id);
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

EVDType __stdcall DocumentTextProvider_tie::get_child_type_4C5AB62C02FC (
	const EntryPoint& id
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY
	return m_impl->get_child_type (id);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::get_prefix_tree_4D0F9F6500F6 (
	ExternalID id
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_prefix_tree(id);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::get_sub_list_4C9B414301FB (
	const EntryPoint& id
	, SubList_tie*& ret_
) {
_DLL_TRY

	const SubList& ret = m_impl->get_sub_list(id);
	SubList_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

bool __stdcall DocumentTextProvider_tie::has_same_5582C01300CB (
	ExternalID id
) {
_DLL_TRY
	return m_impl->has_same (id);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::remove_child_comment_4CC5505001CE (
	const EntryPoint& id
) {
_DLL_TRY

	m_impl->remove_child_comment(id);
_DLL_CATCH
}

void __stdcall DocumentTextProvider_tie::set_child_comment_4C5AB859016E (
	const EntryPoint& id
	, const IEVDStream_tie* comment
) /*throw (InvalidEntryPoint_tie)*/ {
_DLL_TRY
	EVDStream* comment_;
	EVDStream_tie::make_cpp(comment, comment_);

	m_impl->set_child_comment(id, comment_);
_DLL_CATCH
}

bool __stdcall DocumentTextProvider_tie::show_sub_panel_icon_51E40487028B (
	ExternalID id
) {
_DLL_TRY
	return m_impl->show_sub_panel_icon (id);
_DLL_CATCH
}



const ::Core::ComIID DocumentTextProviderList_tie::s_com_iid = {0xD5FCD08C, 0xB18F, 0x4127, {0xAC, 0x59, 0xAF, 0x4E, 0x25, 0xA5, 0x1A, 0xC0}};

unsigned long __stdcall DocumentTextProviderList_tie::query_interface (
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

unsigned long __stdcall DocumentTextProviderList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DocumentTextProviderList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DocumentTextProviderList_tie* const>(this));
	}
	return counter;
}

void DocumentTextProviderList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void DocumentTextProviderList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

DocumentTextProviderList_tie::DocumentTextProviderList_tie () : m_impl(NULL), m_orphan(true) {
}

void DocumentTextProviderList_tie::make_cpp (const DocumentTextProviderList_tie* obj, DocumentTextProviderList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void DocumentTextProviderList_tie::new_tie (DocumentTextProviderList* obj, DocumentTextProviderList_tie*& ret_) {
	Core::Aptr<DocumentTextProviderList> obj_aptr (obj);
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

void DocumentTextProviderList_tie::make_tie (DocumentTextProviderList* obj, DocumentTextProviderList_tie*& ret_) {
	Core::Aptr<DocumentTextProviderList> obj_aptr (obj);
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
	
void DocumentTextProviderList_tie::make_tie (const DocumentTextProviderList& obj, DocumentTextProviderList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new DocumentTextProviderList (obj);
	} else {
		ret_ = NULL;
	}
}

void DocumentTextProviderList_tie::make_tie (const DocumentTextProviderList& obj, DocumentTextProviderList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<DocumentTextProviderList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall DocumentTextProviderList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall DocumentTextProviderList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall DocumentTextProviderList_tie::clear () {
	m_impl->clear();
}

void __stdcall DocumentTextProviderList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DocumentTextProviderList_tie::get_item (size_t index, IDocumentTextProvider_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		DocumentTextProvider_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DocumentTextProviderList_tie::set_item (size_t index, const IDocumentTextProvider_tie* item) {
	if ((size_t)index < m_impl->size()) {
		DocumentTextProvider* item_;
		DocumentTextProvider_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall DocumentTextProviderList_tie::add (const IDocumentTextProvider_tie* item) {
	DocumentTextProvider* item_;
	DocumentTextProvider_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall DocumentTextProviderList_tie::insert (size_t index, const IDocumentTextProvider_tie* item) {
	if ((size_t)index < m_impl->size()) {
		DocumentTextProvider* item_;
		DocumentTextProvider_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID CommentsParaList_tie::s_com_iid = {0x5FA3C62C, 0x8928, 0x49A6, {0xAB, 0xCD, 0xE8, 0x48, 0x78, 0x13, 0xFC, 0x8C}};

unsigned long __stdcall CommentsParaList_tie::query_interface (
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

unsigned long __stdcall CommentsParaList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall CommentsParaList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<CommentsParaList_tie* const>(this));
	}
	return counter;
}

void CommentsParaList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void CommentsParaList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

CommentsParaList_tie::CommentsParaList_tie () : m_impl(NULL), m_orphan(true) {
}

void CommentsParaList_tie::make_cpp (const CommentsParaList_tie* obj, CommentsParaList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void CommentsParaList_tie::new_tie (CommentsParaList* obj, CommentsParaList_tie*& ret_) {
	Core::Aptr<CommentsParaList> obj_aptr (obj);
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

void CommentsParaList_tie::make_tie (CommentsParaList* obj, CommentsParaList_tie*& ret_) {
	Core::Aptr<CommentsParaList> obj_aptr (obj);
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
	
void CommentsParaList_tie::make_tie (const CommentsParaList& obj, CommentsParaList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new CommentsParaList (obj);
	} else {
		ret_ = NULL;
	}
}

void CommentsParaList_tie::make_tie (const CommentsParaList& obj, CommentsParaList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<CommentsParaList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall CommentsParaList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall CommentsParaList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall CommentsParaList_tie::clear () {
	m_impl->clear();
}

void __stdcall CommentsParaList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

ParaId __stdcall CommentsParaList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall CommentsParaList_tie::set_item (size_t index, ParaId item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall CommentsParaList_tie::add (ParaId item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall CommentsParaList_tie::insert (size_t index, ParaId item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void ExternalObjectData_tie::make_cpp (const ExternalObjectData_tie& obj, ExternalObjectData& ret_) {
		ret_.type = obj.type;
		ret_.para_id = obj.para_id;
		GCI::IO::String_tie::make_cpp (obj.name, ret_.name.out (), true);
}

void ExternalObjectData_tie::make_tie (const ExternalObjectData& obj, ExternalObjectData_tie& ret_) {
		ret_.type = obj.type;
		ret_.para_id = obj.para_id;
		ret_.name = 0;
		GCI::IO::String_tie::make_tie (obj.name.in (), ret_.name, true);
}


const ::Core::ComIID ExternalObjectDataList_tie::s_com_iid = {0xFD067004, 0x64CD, 0x4A0C, {0x83, 0x9A, 0xFA, 0xF3, 0x78, 0xD7, 0xE0, 0x3D}};

unsigned long __stdcall ExternalObjectDataList_tie::query_interface (
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

unsigned long __stdcall ExternalObjectDataList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ExternalObjectDataList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ExternalObjectDataList_tie* const>(this));
	}
	return counter;
}

void ExternalObjectDataList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ExternalObjectDataList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ExternalObjectDataList_tie::ExternalObjectDataList_tie () : m_impl(NULL), m_orphan(true) {
}

void ExternalObjectDataList_tie::make_cpp (const ExternalObjectDataList_tie* obj, ExternalObjectDataList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ExternalObjectDataList_tie::new_tie (ExternalObjectDataList* obj, ExternalObjectDataList_tie*& ret_) {
	Core::Aptr<ExternalObjectDataList> obj_aptr (obj);
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

void ExternalObjectDataList_tie::make_tie (ExternalObjectDataList* obj, ExternalObjectDataList_tie*& ret_) {
	Core::Aptr<ExternalObjectDataList> obj_aptr (obj);
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
	
void ExternalObjectDataList_tie::make_tie (const ExternalObjectDataList& obj, ExternalObjectDataList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ExternalObjectDataList (obj);
	} else {
		ret_ = NULL;
	}
}

void ExternalObjectDataList_tie::make_tie (const ExternalObjectDataList& obj, ExternalObjectDataList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ExternalObjectDataList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ExternalObjectDataList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ExternalObjectDataList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ExternalObjectDataList_tie::clear () {
	m_impl->clear();
}

void __stdcall ExternalObjectDataList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ExternalObjectDataList_tie::get_item (size_t index, ExternalObjectData_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		ExternalObjectData_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ExternalObjectDataList_tie::set_item (size_t index, const ExternalObjectData_tie& item) {
	if ((size_t)index < m_impl->size()) {
		ExternalObjectData item_;
		ExternalObjectData_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ExternalObjectDataList_tie::add (const ExternalObjectData_tie& item) {
	ExternalObjectData item_;
	ExternalObjectData_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall ExternalObjectDataList_tie::insert (size_t index, const ExternalObjectData_tie& item) {
	if ((size_t)index < m_impl->size()) {
		ExternalObjectData item_;
		ExternalObjectData_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void DiffData_tie::make_cpp (const DiffData_tie& obj, DiffData& ret_) {
		DiffIterator_tie::make_cpp (obj.diff_iterator, ret_.diff_iterator.out (), true);
		DocumentTextProvider_tie::make_cpp (obj.cur, ret_.cur.out (), true);
		DocumentTextProvider_tie::make_cpp (obj.prev, ret_.prev.out (), true);
}

void DiffData_tie::make_tie (const DiffData& obj, DiffData_tie& ret_) {
		ret_.diff_iterator = 0;
		DiffIterator_tie::make_tie (obj.diff_iterator.in (), ret_.diff_iterator, true);
		ret_.cur = 0;
		DocumentTextProvider_tie::make_tie (obj.cur.in (), ret_.cur, true);
		ret_.prev = 0;
		DocumentTextProvider_tie::make_tie (obj.prev.in (), ret_.prev, true);
}


const ::Core::ComIID DocumentTextProviderDescriptorList_tie::s_com_iid = {0x1FE6402E, 0x2A8A, 0x4B25, {0x86, 0xBE, 0x25, 0x1B, 0x21, 0x9D, 0x8A, 0xBF}};

unsigned long __stdcall DocumentTextProviderDescriptorList_tie::query_interface (
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

unsigned long __stdcall DocumentTextProviderDescriptorList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DocumentTextProviderDescriptorList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DocumentTextProviderDescriptorList_tie* const>(this));
	}
	return counter;
}

void DocumentTextProviderDescriptorList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void DocumentTextProviderDescriptorList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

DocumentTextProviderDescriptorList_tie::DocumentTextProviderDescriptorList_tie () : m_impl(NULL), m_orphan(true) {
}

void DocumentTextProviderDescriptorList_tie::make_cpp (const DocumentTextProviderDescriptorList_tie* obj, DocumentTextProviderDescriptorList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void DocumentTextProviderDescriptorList_tie::new_tie (DocumentTextProviderDescriptorList* obj, DocumentTextProviderDescriptorList_tie*& ret_) {
	Core::Aptr<DocumentTextProviderDescriptorList> obj_aptr (obj);
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

void DocumentTextProviderDescriptorList_tie::make_tie (DocumentTextProviderDescriptorList* obj, DocumentTextProviderDescriptorList_tie*& ret_) {
	Core::Aptr<DocumentTextProviderDescriptorList> obj_aptr (obj);
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
	
void DocumentTextProviderDescriptorList_tie::make_tie (const DocumentTextProviderDescriptorList& obj, DocumentTextProviderDescriptorList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new DocumentTextProviderDescriptorList (obj);
	} else {
		ret_ = NULL;
	}
}

void DocumentTextProviderDescriptorList_tie::make_tie (const DocumentTextProviderDescriptorList& obj, DocumentTextProviderDescriptorList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<DocumentTextProviderDescriptorList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall DocumentTextProviderDescriptorList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall DocumentTextProviderDescriptorList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall DocumentTextProviderDescriptorList_tie::clear () {
	m_impl->clear();
}

void __stdcall DocumentTextProviderDescriptorList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DocumentTextProviderDescriptorList_tie::get_item (size_t index, DocumentTextProviderDescriptor& ret_) {
	if ((size_t)index < m_impl->size()) {
		ret_ = (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DocumentTextProviderDescriptorList_tie::set_item (size_t index, const DocumentTextProviderDescriptor& item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall DocumentTextProviderDescriptorList_tie::add (const DocumentTextProviderDescriptor& item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall DocumentTextProviderDescriptorList_tie::insert (size_t index, const DocumentTextProviderDescriptor& item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID DocPointList_tie::s_com_iid = {0x23E9F1C5, 0xE8C3, 0x40D7, {0xB1, 0x64, 0x7A, 0x8D, 0x5A, 0xBA, 0x52, 0x16}};

unsigned long __stdcall DocPointList_tie::query_interface (
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

unsigned long __stdcall DocPointList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DocPointList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DocPointList_tie* const>(this));
	}
	return counter;
}

void DocPointList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void DocPointList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

DocPointList_tie::DocPointList_tie () : m_impl(NULL), m_orphan(true) {
}

void DocPointList_tie::make_cpp (const DocPointList_tie* obj, DocPointList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void DocPointList_tie::new_tie (DocPointList* obj, DocPointList_tie*& ret_) {
	Core::Aptr<DocPointList> obj_aptr (obj);
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

void DocPointList_tie::make_tie (DocPointList* obj, DocPointList_tie*& ret_) {
	Core::Aptr<DocPointList> obj_aptr (obj);
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
	
void DocPointList_tie::make_tie (const DocPointList& obj, DocPointList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new DocPointList (obj);
	} else {
		ret_ = NULL;
	}
}

void DocPointList_tie::make_tie (const DocPointList& obj, DocPointList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<DocPointList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall DocPointList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall DocPointList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall DocPointList_tie::clear () {
	m_impl->clear();
}

void __stdcall DocPointList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DocPointList_tie::get_item (size_t index, DocPoint& ret_) {
	if ((size_t)index < m_impl->size()) {
		ret_ = (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DocPointList_tie::set_item (size_t index, const DocPoint& item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall DocPointList_tie::add (const DocPoint& item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall DocPointList_tie::insert (size_t index, const DocPoint& item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Likeable_tie::s_com_iid = {0xCD879569, 0xCC93, 0x4E02, {0xB5, 0x6F, 0xC5, 0xC1, 0xB3, 0xFB, 0xBE, 0xBC}};

Likeable_tie::IidRegistrator Likeable_tie::s_iid_registrator;

Likeable_tie::Likeable_tie () : m_impl(NULL) {
}

unsigned long __stdcall Likeable_tie::query_interface (
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
unsigned long __stdcall Likeable_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Likeable_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Likeable_tie* const>(this));
	}
	return counter;
}

void Likeable_tie::init () {
		m_counter = 1;
	}

void Likeable_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Likeable_tie::cast (::Core::IObject* obj) {
	Likeable* ret = dynamic_cast<Likeable*>(obj);
	if (ret) {
		ret->addref();
	}
	ILikeable_tie* ret_ = NULL;
	Likeable_tie::make_tie (ret, ret_);
	return ret_;
}

void Likeable_tie::make_cpp (const ILikeable_tie* obj, Likeable*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Likeable*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Likeable_tie::make_tie (const Likeable* obj, ILikeable_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Likeable_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Likeable*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Likeable_tie::make_tie (const Likeable& obj, ILikeable_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Likeable_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Likeable*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Likeable_tie::get_impl () const {
	return m_impl;
}


const bool __stdcall Likeable_tie::get_can_like () const {
_DLL_TRY
	return m_impl->get_can_like();
_DLL_CATCH
}

void __stdcall Likeable_tie::like_4FEAFD48024F () const {
_DLL_TRY

	m_impl->like();
_DLL_CATCH
}

void __stdcall Likeable_tie::unlike_4FEAFD5D03D1 () const {
_DLL_TRY

	m_impl->unlike();
_DLL_CATCH
}



void RedactionInfo_tie::make_cpp (const RedactionInfo_tie& obj, RedactionInfo& ret_) {
		GCI::IO::String_tie::make_cpp (obj.name, ret_.name.out (), true);
		ret_.time_machine_date = obj.time_machine_date;
		ret_.doc_date = obj.doc_date;
		ret_.is_comparable = obj.is_comparable;
		ret_.actual_type = obj.actual_type;
		NotSureIntervalList* ret_not_sure_intervals_;
		NotSureIntervalList_tie::make_cpp (obj.not_sure_intervals, ret_not_sure_intervals_);
		ret_.not_sure_intervals = *ret_not_sure_intervals_;
		ActiveIntervalList* ret_active_intervals_;
		ActiveIntervalList_tie::make_cpp (obj.active_intervals, ret_active_intervals_);
		ret_.active_intervals = *ret_active_intervals_;
		ret_.id = obj.id;
		RedactionSourceDocumentInfoList* ret_changing_documents_;
		RedactionSourceDocumentInfoList_tie::make_cpp (obj.changing_documents, ret_changing_documents_);
		ret_.changing_documents = *ret_changing_documents_;
}

void RedactionInfo_tie::make_tie (const RedactionInfo& obj, RedactionInfo_tie& ret_) {
		ret_.name = 0;
		GCI::IO::String_tie::make_tie (obj.name.in (), ret_.name, true);
		ret_.time_machine_date = obj.time_machine_date;
		ret_.doc_date = obj.doc_date;
		ret_.is_comparable = obj.is_comparable;
		ret_.actual_type = obj.actual_type;
		ret_.not_sure_intervals = 0;
		NotSureIntervalList_tie::make_tie (obj.not_sure_intervals, ret_.not_sure_intervals);
		ret_.active_intervals = 0;
		ActiveIntervalList_tie::make_tie (obj.active_intervals, ret_.active_intervals);
		ret_.id = obj.id;
		ret_.changing_documents = 0;
		RedactionSourceDocumentInfoList_tie::make_tie (obj.changing_documents, ret_.changing_documents);
}


void DiffDocPara_tie::make_cpp (const DiffDocPara_tie& obj, DiffDocPara& ret_) {
		GCI::IO::String_tie::make_cpp (obj.text, ret_.text.out (), true);
		EVDStream_tie::make_cpp (obj.style, ret_.style.out (), true);
		GCI::IO::Stream_tie::make_cpp (obj.data, ret_.data.out (), true);
		ret_.type = obj.type;
		ret_.id = obj.id;
}

void DiffDocPara_tie::make_tie (const DiffDocPara& obj, DiffDocPara_tie& ret_) {
		ret_.text = 0;
		GCI::IO::String_tie::make_tie (obj.text.in (), ret_.text, true);
		ret_.style = 0;
		EVDStream_tie::make_tie (obj.style.in (), ret_.style, true);
		ret_.data = 0;
		GCI::IO::Stream_tie::make_tie (obj.data.in (), ret_.data, true);
		ret_.type = obj.type;
		ret_.id = obj.id;
}


const ::Core::ComIID DiffDocParaList_tie::s_com_iid = {0x22033D4B, 0x258E, 0x4B5A, {0xA1, 0x79, 0x5C, 0x27, 0x94, 0x55, 0x94, 0x48}};

unsigned long __stdcall DiffDocParaList_tie::query_interface (
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

unsigned long __stdcall DiffDocParaList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DiffDocParaList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DiffDocParaList_tie* const>(this));
	}
	return counter;
}

void DiffDocParaList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void DiffDocParaList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

DiffDocParaList_tie::DiffDocParaList_tie () : m_impl(NULL), m_orphan(true) {
}

void DiffDocParaList_tie::make_cpp (const DiffDocParaList_tie* obj, DiffDocParaList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void DiffDocParaList_tie::new_tie (DiffDocParaList* obj, DiffDocParaList_tie*& ret_) {
	Core::Aptr<DiffDocParaList> obj_aptr (obj);
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

void DiffDocParaList_tie::make_tie (DiffDocParaList* obj, DiffDocParaList_tie*& ret_) {
	Core::Aptr<DiffDocParaList> obj_aptr (obj);
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
	
void DiffDocParaList_tie::make_tie (const DiffDocParaList& obj, DiffDocParaList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new DiffDocParaList (obj);
	} else {
		ret_ = NULL;
	}
}

void DiffDocParaList_tie::make_tie (const DiffDocParaList& obj, DiffDocParaList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<DiffDocParaList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall DiffDocParaList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall DiffDocParaList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall DiffDocParaList_tie::clear () {
	m_impl->clear();
}

void __stdcall DiffDocParaList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DiffDocParaList_tie::get_item (size_t index, DiffDocPara_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		DiffDocPara_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DiffDocParaList_tie::set_item (size_t index, const DiffDocPara_tie& item) {
	if ((size_t)index < m_impl->size()) {
		DiffDocPara item_;
		DiffDocPara_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall DiffDocParaList_tie::add (const DiffDocPara_tie& item) {
	DiffDocPara item_;
	DiffDocPara_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall DiffDocParaList_tie::insert (size_t index, const DiffDocPara_tie& item) {
	if ((size_t)index < m_impl->size()) {
		DiffDocPara item_;
		DiffDocPara_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void ChangedBlock_tie::make_cpp (const ChangedBlock_tie& obj, ChangedBlock& ret_) {
		ret_.id = obj.id;
		DiffDocParaList* ret_header_;
		DiffDocParaList_tie::make_cpp (obj.header, ret_header_);
		ret_.header = *ret_header_;
		DiffDocParaList* ret_right_text_para_list_;
		DiffDocParaList_tie::make_cpp (obj.right_text_para_list, ret_right_text_para_list_);
		ret_.right_text_para_list = *ret_right_text_para_list_;
		DiffDocParaList* ret_left_text_para_list_;
		DiffDocParaList_tie::make_cpp (obj.left_text_para_list, ret_left_text_para_list_);
		ret_.left_text_para_list = *ret_left_text_para_list_;
}

void ChangedBlock_tie::make_tie (const ChangedBlock& obj, ChangedBlock_tie& ret_) {
		ret_.id = obj.id;
		ret_.header = 0;
		DiffDocParaList_tie::make_tie (obj.header, ret_.header);
		ret_.right_text_para_list = 0;
		DiffDocParaList_tie::make_tie (obj.right_text_para_list, ret_.right_text_para_list);
		ret_.left_text_para_list = 0;
		DiffDocParaList_tie::make_tie (obj.left_text_para_list, ret_.left_text_para_list);
}


const ::Core::ComIID RedactionInfoList_tie::s_com_iid = {0x8BDE1298, 0x6218, 0x4C49, {0x90, 0x24, 0x3F, 0x40, 0x4F, 0x6C, 0xC8, 0x09}};

unsigned long __stdcall RedactionInfoList_tie::query_interface (
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

unsigned long __stdcall RedactionInfoList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall RedactionInfoList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<RedactionInfoList_tie* const>(this));
	}
	return counter;
}

void RedactionInfoList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void RedactionInfoList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

RedactionInfoList_tie::RedactionInfoList_tie () : m_impl(NULL), m_orphan(true) {
}

void RedactionInfoList_tie::make_cpp (const RedactionInfoList_tie* obj, RedactionInfoList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void RedactionInfoList_tie::new_tie (RedactionInfoList* obj, RedactionInfoList_tie*& ret_) {
	Core::Aptr<RedactionInfoList> obj_aptr (obj);
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

void RedactionInfoList_tie::make_tie (RedactionInfoList* obj, RedactionInfoList_tie*& ret_) {
	Core::Aptr<RedactionInfoList> obj_aptr (obj);
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
	
void RedactionInfoList_tie::make_tie (const RedactionInfoList& obj, RedactionInfoList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new RedactionInfoList (obj);
	} else {
		ret_ = NULL;
	}
}

void RedactionInfoList_tie::make_tie (const RedactionInfoList& obj, RedactionInfoList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<RedactionInfoList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall RedactionInfoList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall RedactionInfoList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall RedactionInfoList_tie::clear () {
	m_impl->clear();
}

void __stdcall RedactionInfoList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall RedactionInfoList_tie::get_item (size_t index, RedactionInfo_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		RedactionInfo_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall RedactionInfoList_tie::set_item (size_t index, const RedactionInfo_tie& item) {
	if ((size_t)index < m_impl->size()) {
		RedactionInfo item_;
		RedactionInfo_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall RedactionInfoList_tie::add (const RedactionInfo_tie& item) {
	RedactionInfo item_;
	RedactionInfo_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall RedactionInfoList_tie::insert (size_t index, const RedactionInfo_tie& item) {
	if ((size_t)index < m_impl->size()) {
		RedactionInfo item_;
		RedactionInfo_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Document_tie::s_com_iid = {0x2906776F, 0xDD41, 0x403A, {0xAF, 0x10, 0xDD, 0xD0, 0xF9, 0xBD, 0x65, 0x90}};

Document_tie::IidRegistrator Document_tie::s_iid_registrator;

Document_tie::Document_tie () : m_impl(NULL) {
}

unsigned long __stdcall Document_tie::query_interface (
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
unsigned long __stdcall Document_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Document_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Document_tie* const>(this));
	}
	return counter;
}

void Document_tie::init () {
		m_counter = 1;
	}

void Document_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Document_tie::cast (::Core::IObject* obj) {
	Document* ret = dynamic_cast<Document*>(obj);
	if (ret) {
		ret->addref();
	}
	IDocument_tie* ret_ = NULL;
	Document_tie::make_tie (ret, ret_);
	return ret_;
}

void Document_tie::make_cpp (const IDocument_tie* obj, Document*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Document*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Document_tie::make_tie (const Document* obj, IDocument_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Document_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Document*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Document_tie::make_tie (const Document& obj, IDocument_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Document_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Document*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Document_tie::get_impl () const {
	return m_impl;
}


bool __stdcall Document_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall Document_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall Document_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall Document_tie::save_to_456EB3E10178 (
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

void __stdcall Document_tie::append_to_456EB3E1017A (
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

void __stdcall Document_tie::get_annotation (IDocument_tie*& ret_) {
_DLL_TRY
	Document_tie::make_tie (m_impl->get_annotation(), ret_);
_DLL_CATCH
}


void __stdcall Document_tie::get_attributes_root (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_attributes_root(), ret_);
_DLL_CATCH
}


void __stdcall Document_tie::get_bookmark_list (BookmarkList_tie*& ret_) const {
_DLL_TRY
	BookmarkList_tie::make_tie (m_impl->get_bookmark_list(), ret_, this);
_DLL_CATCH
}


const unsigned long __stdcall Document_tie::get_change_status () const {
_DLL_TRY
	return m_impl->get_change_status();
_DLL_CATCH
}


void __stdcall Document_tie::get_comments_para_list (CommentsParaList_tie*& ret_) const {
_DLL_TRY
	CommentsParaList_tie::make_tie (m_impl->get_comments_para_list(), ret_, this);
_DLL_CATCH
}


void __stdcall Document_tie::get_contents_root (INodeBase_tie*& ret_) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_contents_root(), ret_);
_DLL_CATCH
}

void __stdcall Document_tie::create_bookmark_45EEB6520194 (
	ParaId para
	, bool is_para
	, IBookmark_tie*& ret_
) const {
_DLL_TRY

	Bookmark* ret = m_impl->create_bookmark(para, is_para);
	Bookmark_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::create_journal_bookmark_4A8A9AD600BC (
	ParaId para
	, IJournalBookmark_tie*& ret_
) const {
_DLL_TRY

	JournalBookmark* ret = m_impl->create_journal_bookmark(para);
	JournalBookmark_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::create_view_45EEB6520197 (
	IDocumentState_tie* filters
	, IDocument_tie*& ret_
) {
_DLL_TRY
	DocumentState* filters_;
	DocumentState_tie::make_cpp(filters, filters_);

	Document* ret = m_impl->create_view(filters_);
	Document_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall Document_tie::get_current_state (IDocumentState_tie*& ret_) {
_DLL_TRY
	DocumentState_tie::make_tie (m_impl->get_current_state(), ret_);
_DLL_CATCH
}


DocumentType __stdcall Document_tie::get_doc_type () const {
_DLL_TRY
	return m_impl->get_doc_type();
_DLL_CATCH
}

void __stdcall Document_tie::dont_show_document_status_changes_warning_4F1E5DE102BE () const {
_DLL_TRY

	m_impl->dont_show_document_status_changes_warning();
_DLL_CATCH
}


void __stdcall Document_tie::get_external_object_data_list (ExternalObjectDataList_tie*& ret_) const {
_DLL_TRY
	ExternalObjectDataList_tie::make_tie (m_impl->get_external_object_data_list(), ret_, this);
_DLL_CATCH
}


void __stdcall Document_tie::get_file_position (GCI::IO::IString_tie*& ret_) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_file_position(), ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_annotation_header_evd_4D023D3B02B4 (
	unsigned long handle
	, GCI::IO::IStream_tie*& ret_
) const /*throw (Unsupported_tie)*/ {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_annotation_header_evd(handle);
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

size_t __stdcall Document_tie::get_auto_referat_doc_count_4A9F9CF3006A () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_auto_referat_doc_count ();
_DLL_CATCH
}

void __stdcall Document_tie::get_autoreferat_header_evd_4D023C95027A (
	GCI::IO::IStream_tie*& ret_
) const /*throw (Unsupported_tie)*/ {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_autoreferat_header_evd();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_correspondents_45EEB65201D7 (
	const INodeBase_tie* category
	, ICatalogBase_tie*& out_list
) const {
_DLL_TRY
	NodeBase* category_;
	NodeBase_tie::make_cpp(category, category_);
	CatalogBase* out_list_ = 0;

	m_impl->get_correspondents(category_, out_list_);
	CatalogBase_tie::make_tie(out_list_, out_list);
_DLL_CATCH
}

void __stdcall Document_tie::get_correspondents_to_part_45EEB6520199 (
	const PositionList_tie* pos_list
	, const INodeBase_tie* category
	, ICatalogBase_tie*& out_list
) const {
_DLL_TRY
	PositionList* pos_list_;
	PositionList_tie::make_cpp(pos_list, pos_list_);
	NodeBase* category_;
	NodeBase_tie::make_cpp(category, category_);
	CatalogBase* out_list_ = 0;

	m_impl->get_correspondents_to_part(*pos_list_, category_, out_list_);
	CatalogBase_tie::make_tie(out_list_, out_list);
_DLL_CATCH
}

void __stdcall Document_tie::get_drug_list_47EBB17D009B (
	ICatalogBase_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	CatalogBase* ret = m_impl->get_drug_list();
	CatalogBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_evd_stream_4CE3E9DF02B0 (
	GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_evd_stream();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_flash_4857C59403C6 (
	IExternalObject_tie*& ret_
) const {
_DLL_TRY

	ExternalObject* ret = m_impl->get_flash();
	ExternalObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_internet_image_url_45EEB652019D (
	long block_id
	, IExternalLink_tie*& ret_
) const {
_DLL_TRY

	ExternalLink* ret = m_impl->get_internet_image_url(block_id);
	ExternalLink_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_link_53E9F3420066 (
	unsigned long doc_id
	, const Topic& id
	, RedactionID rid
	, ILink_tie*& ret_
) const {
_DLL_TRY

	Link* ret = m_impl->get_link(doc_id, id, rid);
	Link_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_link_info_47AB2FC90361 (
	unsigned long doc_id
	, const Topic& id
	, RedactionID rid
	, LinkInfo_tie& ret_
) const {
_DLL_TRY

	::Core::Aptr<LinkInfo> ret = m_impl->get_link_info(doc_id, id, rid);
	LinkInfo_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_linked_object_45EEB65201A3 (
	unsigned long doc_id
	, const Topic& id
	, RedactionID rid
	, LinkedObjectType& obj_type
	, Core::IIObject_tie*& obj
) const /*throw (InvalidTopicId_tie, FolderLinkNotFound_tie)*/ {
_DLL_TRY
	Core::IObject* obj_ = 0;

	m_impl->get_linked_object(doc_id, id, rid, obj_type, obj_);
	Core::IObject_tie::make_tie(obj_, obj);
_DLL_CATCH
}

void __stdcall Document_tie::get_missing_info_for_object_47C6AA260009 (
	const PId& pid
	, IMissingInfo_tie*& missing_info
) const {
_DLL_TRY
	MissingInfo* missing_info_ = 0;

	m_impl->get_missing_info_for_object(pid, missing_info_);
	MissingInfo_tie::make_tie(missing_info_, missing_info);
_DLL_CATCH
}

void __stdcall Document_tie::get_multi_link_info_4DCBB65D028F (
	unsigned long doc_id
	, const Topic& id
	, DocPointList_tie*& ret_
) const /*throw (CanNotFindData_tie, InternalDatabaseError_tie)*/ {
_DLL_TRY

	::Core::Aptr<DocPointList> ret = m_impl->get_multi_link_info(doc_id, id);
	DocPointList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_not_sure_info_45EEB65201AA (
	const Date& date
	, Date& start
	, Date& finish
	, IDocument_tie*& info
	, GCI::IO::IString_tie*& warning
) const {
_DLL_TRY
	Document* info_ = 0;
	GCI::IO::String* warning_ = 0;

	m_impl->get_not_sure_info(date, start, finish, info_, warning_);
	Document_tie::make_tie(info_, info);
	GCI::IO::String_tie::make_tie(warning_, warning);
_DLL_CATCH
}

void __stdcall Document_tie::get_respondents_45EEB65201DA (
	const INodeBase_tie* category
	, ICatalogBase_tie*& out_list
) const {
_DLL_TRY
	NodeBase* category_;
	NodeBase_tie::make_cpp(category, category_);
	CatalogBase* out_list_ = 0;

	m_impl->get_respondents(category_, out_list_);
	CatalogBase_tie::make_tie(out_list_, out_list);
_DLL_CATCH
}

void __stdcall Document_tie::get_respondents_to_part_45EEB65201B0 (
	const PositionList_tie* pos_list
	, const INodeBase_tie* category
	, ICatalogBase_tie*& out_list
) const {
_DLL_TRY
	PositionList* pos_list_;
	PositionList_tie::make_cpp(pos_list, pos_list_);
	NodeBase* category_;
	NodeBase_tie::make_cpp(category, category_);
	CatalogBase* out_list_ = 0;

	m_impl->get_respondents_to_part(*pos_list_, category_, out_list_);
	CatalogBase_tie::make_tie(out_list_, out_list);
_DLL_CATCH
}

void __stdcall Document_tie::get_same_documents_45EEB65201E1 (
	ICatalogBase_tie*& out_list
) const {
_DLL_TRY
	CatalogBase* out_list_ = 0;

	m_impl->get_same_documents(out_list_);
	CatalogBase_tie::make_tie(out_list_, out_list);
_DLL_CATCH
}

void __stdcall Document_tie::get_same_to_point_5582DAA202AD (
	ExternalID id
	, ICatalogBase_tie*& out_list
) const {
_DLL_TRY
	CatalogBase* out_list_ = 0;

	m_impl->get_same_to_point(id, out_list_);
	CatalogBase_tie::make_tie(out_list_, out_list);
_DLL_CATCH
}

void __stdcall Document_tie::get_self_missing_info_4D3D6F030110 (
	IMissingInfo_tie*& missing_info
) const {
_DLL_TRY
	MissingInfo* missing_info_ = 0;

	m_impl->get_self_missing_info(missing_info_);
	MissingInfo_tie::make_tie(missing_info_, missing_info);
_DLL_CATCH
}

void __stdcall Document_tie::get_text_provider_4CAF1A4B0096 (
	bool all_at_once
	, IDocumentTextProvider_tie*& ret_
) const /*throw (Unsupported_tie, CanNotFindData_tie)*/ {
_DLL_TRY

	DocumentTextProvider* ret = m_impl->get_text_provider(all_at_once);
	DocumentTextProvider_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_text_provider_by_desc_4D6291D500E7 (
	unsigned long handle
	, IDocumentTextProvider_tie*& ret_
) /*throw (Unsupported_tie)*/ {
_DLL_TRY

	DocumentTextProvider* ret = m_impl->get_text_provider_by_desc(handle);
	DocumentTextProvider_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Document_tie::get_text_provider_desc_list_4D6289D601A0 (
	DocumentTextProviderDescriptorList_tie*& ret_
) /*throw (Unsupported_tie)*/ {
_DLL_TRY

	const DocumentTextProviderDescriptorList& ret = m_impl->get_text_provider_desc_list();
	DocumentTextProviderDescriptorList_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

void __stdcall Document_tie::get_text_provider_list_4CED4A090217 (
	bool all_at_once
	, DocumentTextProviderList_tie*& ret_
) /*throw (Unsupported_tie)*/ {
_DLL_TRY

	const DocumentTextProviderList& ret = m_impl->get_text_provider_list(all_at_once);
	DocumentTextProviderList_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

void __stdcall Document_tie::get_time_machine_warning_45EEB65201BE (
	const Date& date
	, TimeMachineWarning_tie& ret_
) {
_DLL_TRY

	::Core::Aptr<TimeMachineWarning> ret = m_impl->get_time_machine_warning(date);
	TimeMachineWarning_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

bool __stdcall Document_tie::has_annotation_45EEB65201C8 () const {
_DLL_TRY
	return m_impl->has_annotation ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_attributes_45EEB65201C9 () const {
_DLL_TRY
	return m_impl->has_attributes ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_chronology_53C3BD6F0050 () const {
_DLL_TRY
	return m_impl->has_chronology ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_correspondents_45EEB65201C0 (
	const INodeBase_tie* category
) const {
_DLL_TRY
	NodeBase* category_;
	NodeBase_tie::make_cpp(category, category_);

	bool ret = m_impl->has_correspondents(category_);
	return ret;
_DLL_CATCH
}

bool __stdcall Document_tie::has_internet_image_45EEB65201C2 () const {
_DLL_TRY
	return m_impl->has_internet_image ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_next_redaction_45EEB65201C3 () const {
_DLL_TRY
	return m_impl->has_next_redaction ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_prev_redaction_45EEB65201C4 () const {
_DLL_TRY
	return m_impl->has_prev_redaction ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_related_doc_45EEB65201C5 () const {
_DLL_TRY
	return m_impl->has_related_doc ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_respondents_45EEB65201C6 (
	const INodeBase_tie* category
) const {
_DLL_TRY
	NodeBase* category_;
	NodeBase_tie::make_cpp(category, category_);

	bool ret = m_impl->has_respondents(category_);
	return ret;
_DLL_CATCH
}

bool __stdcall Document_tie::has_same_documents_45EEB65201E0 () const {
_DLL_TRY
	return m_impl->has_same_documents ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_translation_45EEB65201DF () const {
_DLL_TRY
	return m_impl->has_translation ();
_DLL_CATCH
}

bool __stdcall Document_tie::has_warning_45EEB65201CA () const {
_DLL_TRY
	return m_impl->has_warning ();
_DLL_CATCH
}


unsigned long __stdcall Document_tie::get_internal_id () const {
_DLL_TRY
	return m_impl->get_internal_id();
_DLL_CATCH
}

bool __stdcall Document_tie::is_alive_45EEB65201CB () const {
_DLL_TRY
	return m_impl->is_alive ();
_DLL_CATCH
}

bool __stdcall Document_tie::is_date_in_not_sure_interval_45EEB65201CC (
	const Date& date
) const {
_DLL_TRY
	return m_impl->is_date_in_not_sure_interval (date);
_DLL_CATCH
}

bool __stdcall Document_tie::is_morpho_search_supported_46CD4B9D030D () const {
_DLL_TRY
	return m_impl->is_morpho_search_supported ();
_DLL_CATCH
}

bool __stdcall Document_tie::is_my_bookmark_45EEB65201CE (
	const IBookmark_tie* bookmark
) const {
_DLL_TRY
	Bookmark* bookmark_;
	Bookmark_tie::make_cpp(bookmark, bookmark_);

	bool ret = m_impl->is_my_bookmark(bookmark_);
	return ret;
_DLL_CATCH
}

bool __stdcall Document_tie::is_same_document_45EEB65201D0 (
	const IDocument_tie* doc
) const {
_DLL_TRY
	Document* doc_;
	Document_tie::make_cpp(doc, doc_);

	bool ret = m_impl->is_same_document(doc_);
	return ret;
_DLL_CATCH
}

bool __stdcall Document_tie::is_same_redaction_45EEB65201D2 (
	const IDocument_tie* view
) const {
_DLL_TRY
	Document* view_;
	Document_tie::make_cpp(view, view_);

	bool ret = m_impl->is_same_redaction(view_);
	return ret;
_DLL_CATCH
}

bool __stdcall Document_tie::is_same_view_45EEB65201D4 (
	const IDocument_tie* view
) const {
_DLL_TRY
	Document* view_;
	Document_tie::make_cpp(view, view_);

	bool ret = m_impl->is_same_view(view_);
	return ret;
_DLL_CATCH
}

bool __stdcall Document_tie::may_show_attributes_45EEB65201D6 () const {
_DLL_TRY
	return m_impl->may_show_attributes ();
_DLL_CATCH
}


void __stdcall Document_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}


const bool __stdcall Document_tie::get_new_revision_available () const {
_DLL_TRY
	return m_impl->get_new_revision_available();
_DLL_CATCH
}


const bool __stdcall Document_tie::get_not_tm () const {
_DLL_TRY
	return m_impl->get_not_tm();
_DLL_CATCH
}


void __stdcall Document_tie::get_redactions_list (RedactionInfoList_tie*& ret_) const {
_DLL_TRY
	RedactionInfoList_tie::make_tie (m_impl->get_redactions_list(), ret_, this);
_DLL_CATCH
}


void __stdcall Document_tie::get_related_doc (IDocument_tie*& ret_) {
_DLL_TRY
	Document_tie::make_tie (m_impl->get_related_doc(), ret_);
_DLL_CATCH
}


void __stdcall Document_tie::get_short_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_short_name(), ret_, this);
_DLL_CATCH
}


unsigned long __stdcall Document_tie::get_size () const {
_DLL_TRY
	return m_impl->get_size();
_DLL_CATCH
}


const ItemStatus __stdcall Document_tie::get_status () const {
_DLL_TRY
	return m_impl->get_status();
_DLL_CATCH
}


void __stdcall Document_tie::get_text_languages (LanguagesList_tie*& ret_) const {
_DLL_TRY
	LanguagesList_tie::make_tie (m_impl->get_text_languages(), ret_, this);
_DLL_CATCH
}


void __stdcall Document_tie::get_translation (IDocument_tie*& ret_) {
_DLL_TRY
	Document_tie::make_tie (m_impl->get_translation(), ret_);
_DLL_CATCH
}


void __stdcall Document_tie::get_warning (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_warning(), ret_, this);
_DLL_CATCH
}



const ::Core::ComIID Bookmark_tie::s_com_iid = {0x830AC32A, 0xC3AC, 0x4AA1, {0xA5, 0xA1, 0x0A, 0xCA, 0xE2, 0x29, 0xDD, 0x2A}};

Bookmark_tie::IidRegistrator Bookmark_tie::s_iid_registrator;

Bookmark_tie::Bookmark_tie () : m_impl(NULL) {
}

unsigned long __stdcall Bookmark_tie::query_interface (
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
unsigned long __stdcall Bookmark_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Bookmark_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Bookmark_tie* const>(this));
	}
	return counter;
}

void Bookmark_tie::init () {
		m_counter = 1;
	}

void Bookmark_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Bookmark_tie::cast (::Core::IObject* obj) {
	Bookmark* ret = dynamic_cast<Bookmark*>(obj);
	if (ret) {
		ret->addref();
	}
	IBookmark_tie* ret_ = NULL;
	Bookmark_tie::make_tie (ret, ret_);
	return ret_;
}

void Bookmark_tie::make_cpp (const IBookmark_tie* obj, Bookmark*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Bookmark*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Bookmark_tie::make_tie (const Bookmark* obj, IBookmark_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Bookmark_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Bookmark*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Bookmark_tie::make_tie (const Bookmark& obj, IBookmark_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Bookmark_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Bookmark*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Bookmark_tie::get_impl () const {
	return m_impl;
}


bool __stdcall Bookmark_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall Bookmark_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall Bookmark_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall Bookmark_tie::save_to_456EB3E10178 (
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

void __stdcall Bookmark_tie::append_to_456EB3E1017A (
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

void __stdcall Bookmark_tie::get_comment (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_comment(), ret_, this);
_DLL_CATCH
}
void __stdcall Bookmark_tie::set_comment (GCI::IO::IString_tie* comment) {
_DLL_TRY
	GCI::IO::String* comment_;
	GCI::IO::String_tie::make_cpp(comment, comment_);
	m_impl->set_comment(comment_);
_DLL_CATCH
}


void __stdcall Bookmark_tie::get_document (IDocument_tie*& ret_) {
_DLL_TRY
	Document_tie::make_tie (m_impl->get_document(), ret_);
_DLL_CATCH
}


void __stdcall Bookmark_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}
void __stdcall Bookmark_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}


ParaId __stdcall Bookmark_tie::get_paragraph () const {
_DLL_TRY
	return m_impl->get_paragraph();
_DLL_CATCH
}


void __stdcall Bookmark_tie::get_pid (PId& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_pid();
_DLL_CATCH
}



const ::Core::ComIID DocumentState_tie::s_com_iid = {0x71C2A950, 0x3D61, 0x44A9, {0xA0, 0xFA, 0x84, 0x5C, 0x4A, 0x9F, 0x5B, 0x97}};

DocumentState_tie::IidRegistrator DocumentState_tie::s_iid_registrator;

DocumentState_tie::DocumentState_tie () : m_impl(NULL) {
}

unsigned long __stdcall DocumentState_tie::query_interface (
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
unsigned long __stdcall DocumentState_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DocumentState_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DocumentState_tie* const>(this));
	}
	return counter;
}

void DocumentState_tie::init () {
		m_counter = 1;
	}

void DocumentState_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DocumentState_tie::cast (::Core::IObject* obj) {
	DocumentState* ret = dynamic_cast<DocumentState*>(obj);
	if (ret) {
		ret->addref();
	}
	IDocumentState_tie* ret_ = NULL;
	DocumentState_tie::make_tie (ret, ret_);
	return ret_;
}

void DocumentState_tie::make_cpp (const IDocumentState_tie* obj, DocumentState*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DocumentState*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DocumentState_tie::make_tie (const DocumentState* obj, IDocumentState_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DocumentState_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DocumentState*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DocumentState_tie::make_tie (const DocumentState& obj, IDocumentState_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DocumentState_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DocumentState*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DocumentState_tie::get_impl () const {
	return m_impl;
}

bool __stdcall DocumentState_tie::can_compare_with_any_other_redaction_4B54571C028B () const {
_DLL_TRY
	return m_impl->can_compare_with_any_other_redaction ();
_DLL_CATCH
}

void __stdcall DocumentState_tie::clone_4A8130CE0320 (
	IDocumentState_tie*& ret_
) const {
_DLL_TRY

	DocumentState* ret = m_impl->clone();
	DocumentState_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall DocumentState_tie::get_cur_and_next_redactions_list (RedactionInfoList_tie*& ret_) const {
_DLL_TRY
	RedactionInfoList_tie::make_tie (m_impl->get_cur_and_next_redactions_list(), ret_, this);
_DLL_CATCH
}

void __stdcall DocumentState_tie::diff_with_redaction_by_id_4CC972C00194 (
	RedactionID id
	, DiffData_tie& ret_
) const {
_DLL_TRY

	::Core::Aptr<DiffData> ret = m_impl->diff_with_redaction_by_id(id);
	DiffData_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

void __stdcall DocumentState_tie::get_current_redaction_46320AD6033A (
	RedactionInfo_tie& ret_
) const {
_DLL_TRY

	::Core::Aptr<RedactionInfo> ret = m_impl->get_current_redaction();
	RedactionInfo_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

bool __stdcall DocumentState_tie::is_actual_4EE7512C0058 () const {
_DLL_TRY
	return m_impl->is_actual ();
_DLL_CATCH
}

bool __stdcall DocumentState_tie::is_same_redactions_4628CAEB0169 (
	const IDocumentState_tie* other
) const {
_DLL_TRY
	DocumentState* other_;
	DocumentState_tie::make_cpp(other, other_);

	bool ret = m_impl->is_same_redactions(other_);
	return ret;
_DLL_CATCH
}


Languages __stdcall DocumentState_tie::get_language () const {
_DLL_TRY
	return m_impl->get_language();
_DLL_CATCH
}
void __stdcall DocumentState_tie::set_language (Languages language) {
_DLL_TRY
	m_impl->set_language(language);
_DLL_CATCH
}


void __stdcall DocumentState_tie::get_prev_redactions_list (RedactionInfoList_tie*& ret_) const {
_DLL_TRY
	RedactionInfoList_tie::make_tie (m_impl->get_prev_redactions_list(), ret_, this);
_DLL_CATCH
}

RedactionID __stdcall DocumentState_tie::redaction_46289947018D () const {
_DLL_TRY
	return m_impl->redaction ();
_DLL_CATCH
}

void __stdcall DocumentState_tie::set_actual_redaction_45EED80E008D () const /*throw (RedactionNotFound_tie)*/ {
_DLL_TRY

	m_impl->set_actual_redaction();
_DLL_CATCH
}

void __stdcall DocumentState_tie::set_next_redaction_45EED80E0088 () const /*throw (RedactionNotFound_tie)*/ {
_DLL_TRY

	m_impl->set_next_redaction();
_DLL_CATCH
}

void __stdcall DocumentState_tie::set_prev_active_redaction_4B545717011B () const /*throw (RedactionNotFound_tie)*/ {
_DLL_TRY

	m_impl->set_prev_active_redaction();
_DLL_CATCH
}

void __stdcall DocumentState_tie::set_prev_redaction_45EED80E0087 () const /*throw (RedactionNotFound_tie)*/ {
_DLL_TRY

	m_impl->set_prev_redaction();
_DLL_CATCH
}

void __stdcall DocumentState_tie::set_redaction_on_date_45EED80E0089 (
	const Date& date
) const /*throw (RedactionNotFound_tie)*/ {
_DLL_TRY

	m_impl->set_redaction_on_date(date);
_DLL_CATCH
}

void __stdcall DocumentState_tie::set_redaction_on_id_45EED80E008B (
	RedactionID id
) const /*throw (RedactionNotFound_tie)*/ {
_DLL_TRY

	m_impl->set_redaction_on_id(id);
_DLL_CATCH
}



const ::Core::ComIID JournalBookmark_tie::s_com_iid = {0x7EC5D2E1, 0x6B5C, 0x4C7E, {0xAE, 0x21, 0xC9, 0x8E, 0x21, 0xA8, 0xD0, 0x18}};

JournalBookmark_tie::IidRegistrator JournalBookmark_tie::s_iid_registrator;

JournalBookmark_tie::JournalBookmark_tie () : m_impl(NULL) {
}

unsigned long __stdcall JournalBookmark_tie::query_interface (
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
unsigned long __stdcall JournalBookmark_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall JournalBookmark_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<JournalBookmark_tie* const>(this));
	}
	return counter;
}

void JournalBookmark_tie::init () {
		m_counter = 1;
	}

void JournalBookmark_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* JournalBookmark_tie::cast (::Core::IObject* obj) {
	JournalBookmark* ret = dynamic_cast<JournalBookmark*>(obj);
	if (ret) {
		ret->addref();
	}
	IJournalBookmark_tie* ret_ = NULL;
	JournalBookmark_tie::make_tie (ret, ret_);
	return ret_;
}

void JournalBookmark_tie::make_cpp (const IJournalBookmark_tie* obj, JournalBookmark*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<JournalBookmark*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void JournalBookmark_tie::make_tie (const JournalBookmark* obj, IJournalBookmark_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		JournalBookmark_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<JournalBookmark*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void JournalBookmark_tie::make_tie (const JournalBookmark& obj, IJournalBookmark_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	JournalBookmark_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<JournalBookmark*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* JournalBookmark_tie::get_impl () const {
	return m_impl;
}


bool __stdcall JournalBookmark_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall JournalBookmark_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall JournalBookmark_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall JournalBookmark_tie::save_to_456EB3E10178 (
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

void __stdcall JournalBookmark_tie::append_to_456EB3E1017A (
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

void __stdcall JournalBookmark_tie::get_document (IDocument_tie*& ret_) {
_DLL_TRY
	Document_tie::make_tie (m_impl->get_document(), ret_);
_DLL_CATCH
}


void __stdcall JournalBookmark_tie::get_full_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_full_name(), ret_);
_DLL_CATCH
}


void __stdcall JournalBookmark_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_);
_DLL_CATCH
}


const unsigned long __stdcall JournalBookmark_tie::get_para_id () const {
_DLL_TRY
	return m_impl->get_para_id();
_DLL_CATCH
}



const ::Core::ComIID Link_tie::s_com_iid = {0xFBA5DE98, 0x0FAD, 0x4647, {0xB2, 0xDE, 0xAB, 0x78, 0x8A, 0x6D, 0xDF, 0xE6}};

Link_tie::IidRegistrator Link_tie::s_iid_registrator;

Link_tie::Link_tie () : m_impl(NULL) {
}

unsigned long __stdcall Link_tie::query_interface (
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
unsigned long __stdcall Link_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Link_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Link_tie* const>(this));
	}
	return counter;
}

void Link_tie::init () {
		m_counter = 1;
	}

void Link_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Link_tie::cast (::Core::IObject* obj) {
	Link* ret = dynamic_cast<Link*>(obj);
	if (ret) {
		ret->addref();
	}
	ILink_tie* ret_ = NULL;
	Link_tie::make_tie (ret, ret_);
	return ret_;
}

void Link_tie::make_cpp (const ILink_tie* obj, Link*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Link*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Link_tie::make_tie (const Link* obj, ILink_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Link_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Link*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Link_tie::make_tie (const Link& obj, ILink_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Link_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Link*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Link_tie::get_impl () const {
	return m_impl;
}

LinkKind __stdcall Link_tie::get_kind_53E9EF9A03AB () const {
_DLL_TRY
	return m_impl->get_kind ();
_DLL_CATCH
}

void __stdcall Link_tie::get_link_info_51A745CE0034 (
	LinkInfo_tie& ret_
) const {
_DLL_TRY

	::Core::Aptr<LinkInfo> ret = m_impl->get_link_info();
	LinkInfo_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

void __stdcall Link_tie::get_linked_hint_51AC814F0388 (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_linked_hint();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Link_tie::get_object_51A61EF0013E (
	Core::IIObject_tie*& ret_
) const /*throw (InvalidTopicId_tie, FolderLinkNotFound_tie)*/ {
_DLL_TRY

	Core::IObject* ret = m_impl->get_object();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

LinkedObjectType __stdcall Link_tie::get_object_type_51A61ED6005B () const {
_DLL_TRY
	return m_impl->get_object_type ();
_DLL_CATCH
}



const ::Core::ComIID JournalBookmarkList_tie::s_com_iid = {0x26233056, 0xC81A, 0x4156, {0x96, 0x43, 0x0E, 0x19, 0x55, 0x45, 0x12, 0x5B}};

unsigned long __stdcall JournalBookmarkList_tie::query_interface (
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

unsigned long __stdcall JournalBookmarkList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall JournalBookmarkList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<JournalBookmarkList_tie* const>(this));
	}
	return counter;
}

void JournalBookmarkList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void JournalBookmarkList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

JournalBookmarkList_tie::JournalBookmarkList_tie () : m_impl(NULL), m_orphan(true) {
}

void JournalBookmarkList_tie::make_cpp (const JournalBookmarkList_tie* obj, JournalBookmarkList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void JournalBookmarkList_tie::new_tie (JournalBookmarkList* obj, JournalBookmarkList_tie*& ret_) {
	Core::Aptr<JournalBookmarkList> obj_aptr (obj);
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

void JournalBookmarkList_tie::make_tie (JournalBookmarkList* obj, JournalBookmarkList_tie*& ret_) {
	Core::Aptr<JournalBookmarkList> obj_aptr (obj);
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
	
void JournalBookmarkList_tie::make_tie (const JournalBookmarkList& obj, JournalBookmarkList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new JournalBookmarkList (obj);
	} else {
		ret_ = NULL;
	}
}

void JournalBookmarkList_tie::make_tie (const JournalBookmarkList& obj, JournalBookmarkList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<JournalBookmarkList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall JournalBookmarkList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall JournalBookmarkList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall JournalBookmarkList_tie::clear () {
	m_impl->clear();
}

void __stdcall JournalBookmarkList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall JournalBookmarkList_tie::get_item (size_t index, IJournalBookmark_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		JournalBookmark_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall JournalBookmarkList_tie::set_item (size_t index, const IJournalBookmark_tie* item) {
	if ((size_t)index < m_impl->size()) {
		JournalBookmark* item_;
		JournalBookmark_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall JournalBookmarkList_tie::add (const IJournalBookmark_tie* item) {
	JournalBookmark* item_;
	JournalBookmark_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall JournalBookmarkList_tie::insert (size_t index, const IJournalBookmark_tie* item) {
	if ((size_t)index < m_impl->size()) {
		JournalBookmark* item_;
		JournalBookmark_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID DiffDocDataProvider_tie::s_com_iid = {0xE9D2FB7F, 0x1DE5, 0x4C75, {0x89, 0x98, 0x72, 0xB6, 0xC4, 0x43, 0xFF, 0x03}};

DiffDocDataProvider_tie::IidRegistrator DiffDocDataProvider_tie::s_iid_registrator;

DiffDocDataProvider_tie::DiffDocDataProvider_tie () : m_impl(NULL) {
}

unsigned long __stdcall DiffDocDataProvider_tie::query_interface (
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
unsigned long __stdcall DiffDocDataProvider_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DiffDocDataProvider_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DiffDocDataProvider_tie* const>(this));
	}
	return counter;
}

void DiffDocDataProvider_tie::init () {
		m_counter = 1;
	}

void DiffDocDataProvider_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DiffDocDataProvider_tie::cast (::Core::IObject* obj) {
	DiffDocDataProvider* ret = dynamic_cast<DiffDocDataProvider*>(obj);
	if (ret) {
		ret->addref();
	}
	IDiffDocDataProvider_tie* ret_ = NULL;
	DiffDocDataProvider_tie::make_tie (ret, ret_);
	return ret_;
}

void DiffDocDataProvider_tie::make_cpp (const IDiffDocDataProvider_tie* obj, DiffDocDataProvider*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DiffDocDataProvider*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DiffDocDataProvider_tie::make_tie (const DiffDocDataProvider* obj, IDiffDocDataProvider_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DiffDocDataProvider_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DiffDocDataProvider*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DiffDocDataProvider_tie::make_tie (const DiffDocDataProvider& obj, IDiffDocDataProvider_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DiffDocDataProvider_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DiffDocDataProvider*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DiffDocDataProvider_tie::get_impl () const {
	return m_impl;
}

unsigned long __stdcall DiffDocDataProvider_tie::get_all_leaf_para_count_4D78D86C0070 () const {
_DLL_TRY
	return m_impl->get_all_leaf_para_count ();
_DLL_CATCH
}

void __stdcall DiffDocDataProvider_tie::get_changed_block_4D78DBB90348 (
	unsigned long i
	, ChangedBlock_tie& ret_
) const {
_DLL_TRY

	::Core::Aptr<ChangedBlock> ret = m_impl->get_changed_block(i);
	ChangedBlock_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

unsigned long __stdcall DiffDocDataProvider_tie::get_changed_block_count_4D78DB960024 () const {
_DLL_TRY
	return m_impl->get_changed_block_count ();
_DLL_CATCH
}

bool __stdcall DiffDocDataProvider_tie::get_date_para_left_4D78DB34007D (
	DiffDocPara_tie& para
) const {
_DLL_TRY
	::Core::Aptr<DiffDocPara> para_ = 0;

	bool ret = m_impl->get_date_para_left(para_.out());
	DiffDocPara_tie::make_tie(*para_, para);
	return ret;
_DLL_CATCH
}

bool __stdcall DiffDocDataProvider_tie::get_date_para_right_4D78DB060332 (
	DiffDocPara_tie& para
) const {
_DLL_TRY
	::Core::Aptr<DiffDocPara> para_ = 0;

	bool ret = m_impl->get_date_para_right(para_.out());
	DiffDocPara_tie::make_tie(*para_, para);
	return ret;
_DLL_CATCH
}

void __stdcall DiffDocDataProvider_tie::get_header_para_list_4D78D893019F (
	DiffDocParaList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<DiffDocParaList> ret = m_impl->get_header_para_list();
	DiffDocParaList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall DiffDocDataProvider_tie::get_redaction_name_left_4D78DB6C025D (
	DiffDocPara_tie& ret_
) const {
_DLL_TRY

	::Core::Aptr<DiffDocPara> ret = m_impl->get_redaction_name_left();
	DiffDocPara_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

void __stdcall DiffDocDataProvider_tie::get_redaction_name_right_4D78DB3B00AF (
	DiffDocPara_tie& ret_
) const {
_DLL_TRY

	::Core::Aptr<DiffDocPara> ret = m_impl->get_redaction_name_right();
	DiffDocPara_tie::make_tie(*ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID ObjectFromLink_tie::s_com_iid = {0x51778307, 0xFE15, 0x45BF, {0x9A, 0x86, 0x62, 0xA6, 0x6B, 0xF8, 0x17, 0x25}};

ObjectFromLink_tie::IidRegistrator ObjectFromLink_tie::s_iid_registrator;

ObjectFromLink_tie::ObjectFromLink_tie () : m_impl(NULL) {
}

unsigned long __stdcall ObjectFromLink_tie::query_interface (
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
unsigned long __stdcall ObjectFromLink_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ObjectFromLink_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ObjectFromLink_tie* const>(this));
	}
	return counter;
}

void ObjectFromLink_tie::init () {
		m_counter = 1;
	}

void ObjectFromLink_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ObjectFromLink_tie::cast (::Core::IObject* obj) {
	ObjectFromLink* ret = dynamic_cast<ObjectFromLink*>(obj);
	if (ret) {
		ret->addref();
	}
	IObjectFromLink_tie* ret_ = NULL;
	ObjectFromLink_tie::make_tie (ret, ret_);
	return ret_;
}

void ObjectFromLink_tie::make_cpp (const IObjectFromLink_tie* obj, ObjectFromLink*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ObjectFromLink*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ObjectFromLink_tie::make_tie (const ObjectFromLink* obj, IObjectFromLink_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ObjectFromLink_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ObjectFromLink*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ObjectFromLink_tie::make_tie (const ObjectFromLink& obj, IObjectFromLink_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ObjectFromLink_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ObjectFromLink*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ObjectFromLink_tie::get_impl () const {
	return m_impl;
}

void __stdcall ObjectFromLink_tie::get_object_559EA0D2028B (
	Core::IIObject_tie*& ret_
) const {
_DLL_TRY

	Core::IObject* ret = m_impl->get_object();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

LinkedObjectType __stdcall ObjectFromLink_tie::get_object_type_559EA0DE038A () const {
_DLL_TRY
	return m_impl->get_object_type ();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

