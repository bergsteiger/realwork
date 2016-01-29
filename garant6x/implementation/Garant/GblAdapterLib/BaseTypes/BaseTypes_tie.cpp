////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// Базовые типы, используемые в адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID NamedElement_tie::s_com_iid = {0xE6AAFF18, 0xFAD7, 0x4E46, {0xA5, 0x86, 0xCE, 0xEC, 0x45, 0x90, 0x50, 0x94}};

NamedElement_tie::IidRegistrator NamedElement_tie::s_iid_registrator;

NamedElement_tie::NamedElement_tie () : m_impl(NULL) {
}

unsigned long __stdcall NamedElement_tie::query_interface (
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
unsigned long __stdcall NamedElement_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NamedElement_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NamedElement_tie* const>(this));
	}
	return counter;
}

void NamedElement_tie::init () {
		m_counter = 1;
	}

void NamedElement_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* NamedElement_tie::cast (::Core::IObject* obj) {
	NamedElement* ret = dynamic_cast<NamedElement*>(obj);
	if (ret) {
		ret->addref();
	}
	INamedElement_tie* ret_ = NULL;
	NamedElement_tie::make_tie (ret, ret_);
	return ret_;
}

void NamedElement_tie::make_cpp (const INamedElement_tie* obj, NamedElement*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<NamedElement*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void NamedElement_tie::make_tie (const NamedElement* obj, INamedElement_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		NamedElement_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<NamedElement*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void NamedElement_tie::make_tie (const NamedElement& obj, INamedElement_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	NamedElement_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<NamedElement*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* NamedElement_tie::get_impl () const {
	return m_impl;
}


void __stdcall NamedElement_tie::get_comment (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_comment(), ret_, this);
_DLL_CATCH
}
void __stdcall NamedElement_tie::set_comment (GCI::IO::IString_tie* comment) {
_DLL_TRY
	GCI::IO::String* comment_;
	GCI::IO::String_tie::make_cpp(comment, comment_);
	m_impl->set_comment(comment_);
_DLL_CATCH
}


void __stdcall NamedElement_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}
void __stdcall NamedElement_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}



const ::Core::ComIID EntityStorage_tie::s_com_iid = {0xD4613491, 0x81A1, 0x4AD8, {0xB5, 0x1E, 0x95, 0x92, 0x3E, 0x4D, 0xA9, 0x7A}};

EntityStorage_tie::IidRegistrator EntityStorage_tie::s_iid_registrator;

EntityStorage_tie::EntityStorage_tie () : m_impl(NULL) {
}

unsigned long __stdcall EntityStorage_tie::query_interface (
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
unsigned long __stdcall EntityStorage_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall EntityStorage_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<EntityStorage_tie* const>(this));
	}
	return counter;
}

void EntityStorage_tie::init () {
		m_counter = 1;
	}

void EntityStorage_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* EntityStorage_tie::cast (::Core::IObject* obj) {
	EntityStorage* ret = dynamic_cast<EntityStorage*>(obj);
	if (ret) {
		ret->addref();
	}
	IEntityStorage_tie* ret_ = NULL;
	EntityStorage_tie::make_tie (ret, ret_);
	return ret_;
}

void EntityStorage_tie::make_cpp (const IEntityStorage_tie* obj, EntityStorage*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<EntityStorage*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void EntityStorage_tie::make_tie (const EntityStorage* obj, IEntityStorage_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		EntityStorage_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<EntityStorage*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void EntityStorage_tie::make_tie (const EntityStorage& obj, IEntityStorage_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	EntityStorage_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<EntityStorage*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* EntityStorage_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID EntityBase_tie::s_com_iid = {0xAC2E64E2, 0x18A5, 0x4F4A, {0xB1, 0x6F, 0xA1, 0x86, 0xB4, 0xF6, 0xBB, 0x37}};

EntityBase_tie::IidRegistrator EntityBase_tie::s_iid_registrator;

EntityBase_tie::EntityBase_tie () : m_impl(NULL) {
}

unsigned long __stdcall EntityBase_tie::query_interface (
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
unsigned long __stdcall EntityBase_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall EntityBase_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<EntityBase_tie* const>(this));
	}
	return counter;
}

void EntityBase_tie::init () {
		m_counter = 1;
	}

void EntityBase_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* EntityBase_tie::cast (::Core::IObject* obj) {
	EntityBase* ret = dynamic_cast<EntityBase*>(obj);
	if (ret) {
		ret->addref();
	}
	IEntityBase_tie* ret_ = NULL;
	EntityBase_tie::make_tie (ret, ret_);
	return ret_;
}

void EntityBase_tie::make_cpp (const IEntityBase_tie* obj, EntityBase*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<EntityBase*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void EntityBase_tie::make_tie (const EntityBase* obj, IEntityBase_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		EntityBase_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<EntityBase*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void EntityBase_tie::make_tie (const EntityBase& obj, IEntityBase_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	EntityBase_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<EntityBase*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* EntityBase_tie::get_impl () const {
	return m_impl;
}

void __stdcall EntityBase_tie::append_to_456EB3E1017A (
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


const unsigned long __stdcall EntityBase_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}


bool __stdcall EntityBase_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


bool __stdcall EntityBase_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}

void __stdcall EntityBase_tie::save_to_456EB3E10178 (
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



const ::Core::ComIID SearchEntity_tie::s_com_iid = {0x8299FB1B, 0xC061, 0x4407, {0x84, 0xD9, 0xAF, 0x61, 0xA0, 0xE3, 0x57, 0x54}};

SearchEntity_tie::IidRegistrator SearchEntity_tie::s_iid_registrator;

SearchEntity_tie::SearchEntity_tie () : m_impl(NULL) {
}

unsigned long __stdcall SearchEntity_tie::query_interface (
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
unsigned long __stdcall SearchEntity_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SearchEntity_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SearchEntity_tie* const>(this));
	}
	return counter;
}

void SearchEntity_tie::init () {
		m_counter = 1;
	}

void SearchEntity_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* SearchEntity_tie::cast (::Core::IObject* obj) {
	SearchEntity* ret = dynamic_cast<SearchEntity*>(obj);
	if (ret) {
		ret->addref();
	}
	ISearchEntity_tie* ret_ = NULL;
	SearchEntity_tie::make_tie (ret, ret_);
	return ret_;
}

void SearchEntity_tie::make_cpp (const ISearchEntity_tie* obj, SearchEntity*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<SearchEntity*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void SearchEntity_tie::make_tie (const SearchEntity* obj, ISearchEntity_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		SearchEntity_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<SearchEntity*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void SearchEntity_tie::make_tie (const SearchEntity& obj, ISearchEntity_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	SearchEntity_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<SearchEntity*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* SearchEntity_tie::get_impl () const {
	return m_impl;
}


size_t __stdcall SearchEntity_tie::get_document_count () const {
_DLL_TRY
	return m_impl->get_document_count();
_DLL_CATCH
}


size_t __stdcall SearchEntity_tie::get_edition_count () const {
_DLL_TRY
	return m_impl->get_edition_count();
_DLL_CATCH
}


size_t __stdcall SearchEntity_tie::get_entry_count () const {
_DLL_TRY
	return m_impl->get_entry_count();
_DLL_CATCH
}


SearchResultType __stdcall SearchEntity_tie::get_result_type () const {
_DLL_TRY
	return m_impl->get_result_type();
_DLL_CATCH
}



const ::Core::ComIID Variant_tie::s_com_iid = {0x0B872568, 0x888B, 0x4CC1, {0xB7, 0xED, 0xD0, 0xE5, 0x55, 0xED, 0xA7, 0xB7}};

Variant_tie::IidRegistrator Variant_tie::s_iid_registrator;

Variant_tie::Variant_tie () : m_impl(NULL) {
}

unsigned long __stdcall Variant_tie::query_interface (
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
unsigned long __stdcall Variant_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Variant_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Variant_tie* const>(this));
	}
	return counter;
}

void Variant_tie::init () {
		m_counter = 1;
	}

void Variant_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Variant_tie::cast (::Core::IObject* obj) {
	Variant* ret = dynamic_cast<Variant*>(obj);
	if (ret) {
		ret->addref();
	}
	IVariant_tie* ret_ = NULL;
	Variant_tie::make_tie (ret, ret_);
	return ret_;
}

void Variant_tie::make_cpp (const IVariant_tie* obj, Variant*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Variant*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Variant_tie::make_tie (const Variant* obj, IVariant_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Variant_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Variant*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Variant_tie::make_tie (const Variant& obj, IVariant_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Variant_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Variant*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Variant_tie::get_impl () const {
	return m_impl;
}

bool __stdcall Variant_tie::get_bool_456ED2D701D6 () const /*throw (InvalidType_tie)*/ {
_DLL_TRY
	return m_impl->get_bool ();
_DLL_CATCH
}

long __stdcall Variant_tie::get_long_456ED2D701D5 () const /*throw (InvalidType_tie)*/ {
_DLL_TRY
	return m_impl->get_long ();
_DLL_CATCH
}

void __stdcall Variant_tie::get_object_456ED2D701D8 (
	Core::IIObject_tie*& ret_
) /*throw (InvalidType_tie)*/ {
_DLL_TRY

	Core::IObject* ret = m_impl->get_object();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Variant_tie::get_string_456ED2D701D7 (
	GCI::IO::IString_tie*& ret_
) /*throw (InvalidType_tie)*/ {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_string();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID LanguagesList_tie::s_com_iid = {0x47BCBDD9, 0xCFDB, 0x45E8, {0x9F, 0x95, 0xF3, 0x6B, 0x63, 0xC7, 0xD9, 0x1B}};

unsigned long __stdcall LanguagesList_tie::query_interface (
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

unsigned long __stdcall LanguagesList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall LanguagesList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<LanguagesList_tie* const>(this));
	}
	return counter;
}

void LanguagesList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void LanguagesList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

LanguagesList_tie::LanguagesList_tie () : m_impl(NULL), m_orphan(true) {
}

void LanguagesList_tie::make_cpp (const LanguagesList_tie* obj, LanguagesList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void LanguagesList_tie::new_tie (LanguagesList* obj, LanguagesList_tie*& ret_) {
	Core::Aptr<LanguagesList> obj_aptr (obj);
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

void LanguagesList_tie::make_tie (LanguagesList* obj, LanguagesList_tie*& ret_) {
	Core::Aptr<LanguagesList> obj_aptr (obj);
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
	
void LanguagesList_tie::make_tie (const LanguagesList& obj, LanguagesList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new LanguagesList (obj);
	} else {
		ret_ = NULL;
	}
}

void LanguagesList_tie::make_tie (const LanguagesList& obj, LanguagesList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<LanguagesList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall LanguagesList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall LanguagesList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall LanguagesList_tie::clear () {
	m_impl->clear();
}

void __stdcall LanguagesList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

Languages __stdcall LanguagesList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return *(*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall LanguagesList_tie::set_item (size_t index, Languages item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall LanguagesList_tie::add (Languages item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall LanguagesList_tie::insert (size_t index, Languages item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID StringList_tie::s_com_iid = {0xA315F0A6, 0x6BEE, 0x4779, {0x93, 0x6A, 0xD3, 0xE1, 0x19, 0xE9, 0x7C, 0x7D}};

unsigned long __stdcall StringList_tie::query_interface (
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

unsigned long __stdcall StringList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall StringList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<StringList_tie* const>(this));
	}
	return counter;
}

void StringList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void StringList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

StringList_tie::StringList_tie () : m_impl(NULL), m_orphan(true) {
}

void StringList_tie::make_cpp (const StringList_tie* obj, StringList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void StringList_tie::new_tie (StringList* obj, StringList_tie*& ret_) {
	Core::Aptr<StringList> obj_aptr (obj);
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

void StringList_tie::make_tie (StringList* obj, StringList_tie*& ret_) {
	Core::Aptr<StringList> obj_aptr (obj);
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
	
void StringList_tie::make_tie (const StringList& obj, StringList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new StringList (obj);
	} else {
		ret_ = NULL;
	}
}

void StringList_tie::make_tie (const StringList& obj, StringList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<StringList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall StringList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall StringList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall StringList_tie::clear () {
	m_impl->clear();
}

void __stdcall StringList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall StringList_tie::get_item (size_t index, GCI::IO::IString_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall StringList_tie::set_item (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall StringList_tie::add (const GCI::IO::IString_tie* item) {
	GCI::IO::String* item_;
	GCI::IO::String_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall StringList_tie::insert (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

