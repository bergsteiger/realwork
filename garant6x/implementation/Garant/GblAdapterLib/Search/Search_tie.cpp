////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Search
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID QueryAttribute_tie::s_com_iid = {0xF7B99D7B, 0x8104, 0x4890, {0xA1, 0x07, 0x57, 0xD3, 0x52, 0x4B, 0xDE, 0xE1}};

QueryAttribute_tie::IidRegistrator QueryAttribute_tie::s_iid_registrator;

QueryAttribute_tie::QueryAttribute_tie () : m_impl(NULL) {
}

unsigned long __stdcall QueryAttribute_tie::query_interface (
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
unsigned long __stdcall QueryAttribute_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryAttribute_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryAttribute_tie* const>(this));
	}
	return counter;
}

void QueryAttribute_tie::init () {
		m_counter = 1;
	}

void QueryAttribute_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* QueryAttribute_tie::cast (::Core::IObject* obj) {
	QueryAttribute* ret = dynamic_cast<QueryAttribute*>(obj);
	if (ret) {
		ret->addref();
	}
	IQueryAttribute_tie* ret_ = NULL;
	QueryAttribute_tie::make_tie (ret, ret_);
	return ret_;
}

void QueryAttribute_tie::make_cpp (const IQueryAttribute_tie* obj, QueryAttribute*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<QueryAttribute*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void QueryAttribute_tie::make_tie (const QueryAttribute* obj, IQueryAttribute_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		QueryAttribute_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<QueryAttribute*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void QueryAttribute_tie::make_tie (const QueryAttribute& obj, IQueryAttribute_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	QueryAttribute_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<QueryAttribute*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* QueryAttribute_tie::get_impl () const {
	return m_impl;
}

void __stdcall QueryAttribute_tie::clear_4663F1D20290 () {
_DLL_TRY

	m_impl->clear();
_DLL_CATCH
}

AttributeTag_const __stdcall QueryAttribute_tie::get_tag_4767C8D803E1 () const {
_DLL_TRY
	return m_impl->get_tag ();
_DLL_CATCH
}


QueryTagType __stdcall QueryAttribute_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}



const ::Core::ComIID QueryPhoneNumberAttribute_tie::s_com_iid = {0xD08C1696, 0x445B, 0x4611, {0x93, 0xD3, 0xD9, 0xB1, 0x72, 0xB9, 0x25, 0xAB}};

QueryPhoneNumberAttribute_tie::IidRegistrator QueryPhoneNumberAttribute_tie::s_iid_registrator;

QueryPhoneNumberAttribute_tie::QueryPhoneNumberAttribute_tie () : m_impl(NULL) {
}

unsigned long __stdcall QueryPhoneNumberAttribute_tie::query_interface (
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
unsigned long __stdcall QueryPhoneNumberAttribute_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryPhoneNumberAttribute_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryPhoneNumberAttribute_tie* const>(this));
	}
	return counter;
}

void QueryPhoneNumberAttribute_tie::init () {
		m_counter = 1;
	}

void QueryPhoneNumberAttribute_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* QueryPhoneNumberAttribute_tie::cast (::Core::IObject* obj) {
	QueryPhoneNumberAttribute* ret = dynamic_cast<QueryPhoneNumberAttribute*>(obj);
	if (ret) {
		ret->addref();
	}
	IQueryPhoneNumberAttribute_tie* ret_ = NULL;
	QueryPhoneNumberAttribute_tie::make_tie (ret, ret_);
	return ret_;
}

void QueryPhoneNumberAttribute_tie::make_cpp (const IQueryPhoneNumberAttribute_tie* obj, QueryPhoneNumberAttribute*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<QueryPhoneNumberAttribute*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void QueryPhoneNumberAttribute_tie::make_tie (const QueryPhoneNumberAttribute* obj, IQueryPhoneNumberAttribute_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		QueryPhoneNumberAttribute_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<QueryPhoneNumberAttribute*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void QueryPhoneNumberAttribute_tie::make_tie (const QueryPhoneNumberAttribute& obj, IQueryPhoneNumberAttribute_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	QueryPhoneNumberAttribute_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<QueryPhoneNumberAttribute*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* QueryPhoneNumberAttribute_tie::get_impl () const {
	return m_impl;
}


QueryTagType __stdcall QueryPhoneNumberAttribute_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}

void __stdcall QueryPhoneNumberAttribute_tie::clear_4663F1D20290 () {
_DLL_TRY

	m_impl->clear();
_DLL_CATCH
}

AttributeTag_const __stdcall QueryPhoneNumberAttribute_tie::get_tag_4767C8D803E1 () const {
_DLL_TRY
	return m_impl->get_tag ();
_DLL_CATCH
}

void __stdcall QueryPhoneNumberAttribute_tie::get_city_code (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_city_code(), ret_, this);
_DLL_CATCH
}
void __stdcall QueryPhoneNumberAttribute_tie::set_city_code (GCI::IO::IString_tie* city_code) {
_DLL_TRY
	GCI::IO::String* city_code_;
	GCI::IO::String_tie::make_cpp(city_code, city_code_);
	m_impl->set_city_code(city_code_);
_DLL_CATCH
}


void __stdcall QueryPhoneNumberAttribute_tie::get_phone_number (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_phone_number(), ret_, this);
_DLL_CATCH
}
void __stdcall QueryPhoneNumberAttribute_tie::set_phone_number (GCI::IO::IString_tie* phone_number) {
_DLL_TRY
	GCI::IO::String* phone_number_;
	GCI::IO::String_tie::make_cpp(phone_number, phone_number_);
	m_impl->set_phone_number(phone_number_);
_DLL_CATCH
}



void QueryNodeValue_tie::make_cpp (const QueryNodeValue_tie& obj, QueryNodeValue& ret_) {
		NodeBase_tie::make_cpp (obj.node, ret_.node.out (), true);
		ret_.operation = obj.operation;
}

void QueryNodeValue_tie::make_tie (const QueryNodeValue& obj, QueryNodeValue_tie& ret_) {
		ret_.node = 0;
		NodeBase_tie::make_tie (obj.node.in (), ret_.node, true);
		ret_.operation = obj.operation;
}


void ContextValue_tie::make_cpp (const ContextValue_tie& obj, ContextValue& ret_) {
		GCI::IO::String_tie::make_cpp (obj.context, ret_.context.out (), true);
		ret_.operation = obj.operation;
}

void ContextValue_tie::make_tie (const ContextValue& obj, ContextValue_tie& ret_) {
		ret_.context = 0;
		GCI::IO::String_tie::make_tie (obj.context.in (), ret_.context, true);
		ret_.operation = obj.operation;
}


const ::Core::ComIID ContextValueList_tie::s_com_iid = {0x8EDC6AA0, 0x7C9D, 0x4E76, {0xB2, 0x5F, 0xF3, 0x8E, 0x82, 0xE5, 0xA9, 0x74}};

unsigned long __stdcall ContextValueList_tie::query_interface (
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

unsigned long __stdcall ContextValueList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ContextValueList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ContextValueList_tie* const>(this));
	}
	return counter;
}

void ContextValueList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ContextValueList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ContextValueList_tie::ContextValueList_tie () : m_impl(NULL), m_orphan(true) {
}

void ContextValueList_tie::make_cpp (const ContextValueList_tie* obj, ContextValueList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ContextValueList_tie::new_tie (ContextValueList* obj, ContextValueList_tie*& ret_) {
	Core::Aptr<ContextValueList> obj_aptr (obj);
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

void ContextValueList_tie::make_tie (ContextValueList* obj, ContextValueList_tie*& ret_) {
	Core::Aptr<ContextValueList> obj_aptr (obj);
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
	
void ContextValueList_tie::make_tie (const ContextValueList& obj, ContextValueList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ContextValueList (obj);
	} else {
		ret_ = NULL;
	}
}

void ContextValueList_tie::make_tie (const ContextValueList& obj, ContextValueList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ContextValueList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ContextValueList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ContextValueList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ContextValueList_tie::clear () {
	m_impl->clear();
}

void __stdcall ContextValueList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ContextValueList_tie::get_item (size_t index, ContextValue_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		ContextValue_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ContextValueList_tie::set_item (size_t index, const ContextValue_tie& item) {
	if ((size_t)index < m_impl->size()) {
		ContextValue item_;
		ContextValue_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ContextValueList_tie::add (const ContextValue_tie& item) {
	ContextValue item_;
	ContextValue_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall ContextValueList_tie::insert (size_t index, const ContextValue_tie& item) {
	if ((size_t)index < m_impl->size()) {
		ContextValue item_;
		ContextValue_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID DateValueList_tie::s_com_iid = {0xA97316BC, 0x57EC, 0x4203, {0xB8, 0x9B, 0x88, 0x7D, 0xA2, 0x90, 0x58, 0x58}};

unsigned long __stdcall DateValueList_tie::query_interface (
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

unsigned long __stdcall DateValueList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DateValueList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DateValueList_tie* const>(this));
	}
	return counter;
}

void DateValueList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void DateValueList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

DateValueList_tie::DateValueList_tie () : m_impl(NULL), m_orphan(true) {
}

void DateValueList_tie::make_cpp (const DateValueList_tie* obj, DateValueList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void DateValueList_tie::new_tie (DateValueList* obj, DateValueList_tie*& ret_) {
	Core::Aptr<DateValueList> obj_aptr (obj);
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

void DateValueList_tie::make_tie (DateValueList* obj, DateValueList_tie*& ret_) {
	Core::Aptr<DateValueList> obj_aptr (obj);
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
	
void DateValueList_tie::make_tie (const DateValueList& obj, DateValueList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new DateValueList (obj);
	} else {
		ret_ = NULL;
	}
}

void DateValueList_tie::make_tie (const DateValueList& obj, DateValueList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<DateValueList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall DateValueList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall DateValueList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall DateValueList_tie::clear () {
	m_impl->clear();
}

void __stdcall DateValueList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DateValueList_tie::get_item (size_t index, DateValue& ret_) {
	if ((size_t)index < m_impl->size()) {
		ret_ = (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall DateValueList_tie::set_item (size_t index, const DateValue& item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall DateValueList_tie::add (const DateValue& item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall DateValueList_tie::insert (size_t index, const DateValue& item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID QueryDateAttribute_tie::s_com_iid = {0x3CAD67CD, 0x205A, 0x4E98, {0x92, 0x40, 0x49, 0x31, 0x1D, 0x9B, 0x33, 0xD2}};

QueryDateAttribute_tie::IidRegistrator QueryDateAttribute_tie::s_iid_registrator;

QueryDateAttribute_tie::QueryDateAttribute_tie () : m_impl(NULL) {
}

unsigned long __stdcall QueryDateAttribute_tie::query_interface (
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
unsigned long __stdcall QueryDateAttribute_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryDateAttribute_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryDateAttribute_tie* const>(this));
	}
	return counter;
}

void QueryDateAttribute_tie::init () {
		m_counter = 1;
	}

void QueryDateAttribute_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* QueryDateAttribute_tie::cast (::Core::IObject* obj) {
	QueryDateAttribute* ret = dynamic_cast<QueryDateAttribute*>(obj);
	if (ret) {
		ret->addref();
	}
	IQueryDateAttribute_tie* ret_ = NULL;
	QueryDateAttribute_tie::make_tie (ret, ret_);
	return ret_;
}

void QueryDateAttribute_tie::make_cpp (const IQueryDateAttribute_tie* obj, QueryDateAttribute*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<QueryDateAttribute*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void QueryDateAttribute_tie::make_tie (const QueryDateAttribute* obj, IQueryDateAttribute_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		QueryDateAttribute_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<QueryDateAttribute*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void QueryDateAttribute_tie::make_tie (const QueryDateAttribute& obj, IQueryDateAttribute_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	QueryDateAttribute_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<QueryDateAttribute*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* QueryDateAttribute_tie::get_impl () const {
	return m_impl;
}


QueryTagType __stdcall QueryDateAttribute_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}

void __stdcall QueryDateAttribute_tie::clear_4663F1D20290 () {
_DLL_TRY

	m_impl->clear();
_DLL_CATCH
}

AttributeTag_const __stdcall QueryDateAttribute_tie::get_tag_4767C8D803E1 () const {
_DLL_TRY
	return m_impl->get_tag ();
_DLL_CATCH
}
void __stdcall QueryDateAttribute_tie::add_value_45EEE3790392 (
	QueryLogicOperation operation
	, const Date& from
	, const Date& to
) {
_DLL_TRY

	m_impl->add_value(operation, from, to);
_DLL_CATCH
}


void __stdcall QueryDateAttribute_tie::get_values (DateValueList_tie*& ret_) const {
_DLL_TRY
	DateValueList_tie::make_tie (m_impl->get_values(), ret_, this);
_DLL_CATCH
}



const ::Core::ComIID NodeValueList_tie::s_com_iid = {0x22FC2FF8, 0x6660, 0x4E16, {0x9A, 0xF5, 0xEC, 0xCF, 0xE3, 0xFE, 0x43, 0x85}};

unsigned long __stdcall NodeValueList_tie::query_interface (
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

unsigned long __stdcall NodeValueList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NodeValueList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NodeValueList_tie* const>(this));
	}
	return counter;
}

void NodeValueList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void NodeValueList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

NodeValueList_tie::NodeValueList_tie () : m_impl(NULL), m_orphan(true) {
}

void NodeValueList_tie::make_cpp (const NodeValueList_tie* obj, NodeValueList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void NodeValueList_tie::new_tie (NodeValueList* obj, NodeValueList_tie*& ret_) {
	Core::Aptr<NodeValueList> obj_aptr (obj);
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

void NodeValueList_tie::make_tie (NodeValueList* obj, NodeValueList_tie*& ret_) {
	Core::Aptr<NodeValueList> obj_aptr (obj);
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
	
void NodeValueList_tie::make_tie (const NodeValueList& obj, NodeValueList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new NodeValueList (obj);
	} else {
		ret_ = NULL;
	}
}

void NodeValueList_tie::make_tie (const NodeValueList& obj, NodeValueList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<NodeValueList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall NodeValueList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall NodeValueList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall NodeValueList_tie::clear () {
	m_impl->clear();
}

void __stdcall NodeValueList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall NodeValueList_tie::get_item (size_t index, QueryNodeValue_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		QueryNodeValue_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall NodeValueList_tie::set_item (size_t index, const QueryNodeValue_tie& item) {
	if ((size_t)index < m_impl->size()) {
		QueryNodeValue item_;
		QueryNodeValue_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall NodeValueList_tie::add (const QueryNodeValue_tie& item) {
	QueryNodeValue item_;
	QueryNodeValue_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall NodeValueList_tie::insert (size_t index, const QueryNodeValue_tie& item) {
	if ((size_t)index < m_impl->size()) {
		QueryNodeValue item_;
		QueryNodeValue_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID QueryNodeAttribute_tie::s_com_iid = {0x6BD5D1EC, 0x803B, 0x4923, {0xBA, 0xB6, 0xDB, 0xBC, 0x28, 0x68, 0x56, 0x20}};

QueryNodeAttribute_tie::IidRegistrator QueryNodeAttribute_tie::s_iid_registrator;

QueryNodeAttribute_tie::QueryNodeAttribute_tie () : m_impl(NULL) {
}

unsigned long __stdcall QueryNodeAttribute_tie::query_interface (
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
unsigned long __stdcall QueryNodeAttribute_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryNodeAttribute_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryNodeAttribute_tie* const>(this));
	}
	return counter;
}

void QueryNodeAttribute_tie::init () {
		m_counter = 1;
	}

void QueryNodeAttribute_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* QueryNodeAttribute_tie::cast (::Core::IObject* obj) {
	QueryNodeAttribute* ret = dynamic_cast<QueryNodeAttribute*>(obj);
	if (ret) {
		ret->addref();
	}
	IQueryNodeAttribute_tie* ret_ = NULL;
	QueryNodeAttribute_tie::make_tie (ret, ret_);
	return ret_;
}

void QueryNodeAttribute_tie::make_cpp (const IQueryNodeAttribute_tie* obj, QueryNodeAttribute*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<QueryNodeAttribute*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void QueryNodeAttribute_tie::make_tie (const QueryNodeAttribute* obj, IQueryNodeAttribute_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		QueryNodeAttribute_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<QueryNodeAttribute*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void QueryNodeAttribute_tie::make_tie (const QueryNodeAttribute& obj, IQueryNodeAttribute_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	QueryNodeAttribute_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<QueryNodeAttribute*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* QueryNodeAttribute_tie::get_impl () const {
	return m_impl;
}


QueryTagType __stdcall QueryNodeAttribute_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}

void __stdcall QueryNodeAttribute_tie::clear_4663F1D20290 () {
_DLL_TRY

	m_impl->clear();
_DLL_CATCH
}

AttributeTag_const __stdcall QueryNodeAttribute_tie::get_tag_4767C8D803E1 () const {
_DLL_TRY
	return m_impl->get_tag ();
_DLL_CATCH
}
void __stdcall QueryNodeAttribute_tie::add_value_45EEE3890354 (
	QueryLogicOperation operation
	, INodeBase_tie* node
) {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_value(operation, node_);
_DLL_CATCH
}


void __stdcall QueryNodeAttribute_tie::get_values (NodeValueList_tie*& ret_) const {
_DLL_TRY
	NodeValueList_tie::make_tie (m_impl->get_values(), ret_, this);
_DLL_CATCH
}



const ::Core::ComIID QueryAttributeList_tie::s_com_iid = {0x286CCB59, 0x7339, 0x4EFE, {0x83, 0xE2, 0x8A, 0xFF, 0x56, 0x25, 0xA4, 0xCA}};

unsigned long __stdcall QueryAttributeList_tie::query_interface (
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

unsigned long __stdcall QueryAttributeList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryAttributeList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryAttributeList_tie* const>(this));
	}
	return counter;
}

void QueryAttributeList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void QueryAttributeList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

QueryAttributeList_tie::QueryAttributeList_tie () : m_impl(NULL), m_orphan(true) {
}

void QueryAttributeList_tie::make_cpp (const QueryAttributeList_tie* obj, QueryAttributeList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void QueryAttributeList_tie::new_tie (QueryAttributeList* obj, QueryAttributeList_tie*& ret_) {
	Core::Aptr<QueryAttributeList> obj_aptr (obj);
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

void QueryAttributeList_tie::make_tie (QueryAttributeList* obj, QueryAttributeList_tie*& ret_) {
	Core::Aptr<QueryAttributeList> obj_aptr (obj);
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
	
void QueryAttributeList_tie::make_tie (const QueryAttributeList& obj, QueryAttributeList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new QueryAttributeList (obj);
	} else {
		ret_ = NULL;
	}
}

void QueryAttributeList_tie::make_tie (const QueryAttributeList& obj, QueryAttributeList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<QueryAttributeList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall QueryAttributeList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall QueryAttributeList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall QueryAttributeList_tie::clear () {
	m_impl->clear();
}

void __stdcall QueryAttributeList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall QueryAttributeList_tie::get_item (size_t index, IQueryAttribute_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		QueryAttribute_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall QueryAttributeList_tie::set_item (size_t index, const IQueryAttribute_tie* item) {
	if ((size_t)index < m_impl->size()) {
		QueryAttribute* item_;
		QueryAttribute_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall QueryAttributeList_tie::add (const IQueryAttribute_tie* item) {
	QueryAttribute* item_;
	QueryAttribute_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall QueryAttributeList_tie::insert (size_t index, const IQueryAttribute_tie* item) {
	if ((size_t)index < m_impl->size()) {
		QueryAttribute* item_;
		QueryAttribute_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID OperationList_tie::s_com_iid = {0x78C80DA4, 0x3163, 0x4569, {0x9B, 0xB6, 0x7A, 0x77, 0x5B, 0xB1, 0x71, 0x85}};

unsigned long __stdcall OperationList_tie::query_interface (
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

unsigned long __stdcall OperationList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall OperationList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<OperationList_tie* const>(this));
	}
	return counter;
}

void OperationList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void OperationList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

OperationList_tie::OperationList_tie () : m_impl(NULL), m_orphan(true) {
}

void OperationList_tie::make_cpp (const OperationList_tie* obj, OperationList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void OperationList_tie::new_tie (OperationList* obj, OperationList_tie*& ret_) {
	Core::Aptr<OperationList> obj_aptr (obj);
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

void OperationList_tie::make_tie (OperationList* obj, OperationList_tie*& ret_) {
	Core::Aptr<OperationList> obj_aptr (obj);
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
	
void OperationList_tie::make_tie (const OperationList& obj, OperationList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new OperationList (obj);
	} else {
		ret_ = NULL;
	}
}

void OperationList_tie::make_tie (const OperationList& obj, OperationList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<OperationList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall OperationList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall OperationList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall OperationList_tie::clear () {
	m_impl->clear();
}

void __stdcall OperationList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

QueryLogicOperation __stdcall OperationList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall OperationList_tie::set_item (size_t index, QueryLogicOperation item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall OperationList_tie::add (QueryLogicOperation item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall OperationList_tie::insert (size_t index, QueryLogicOperation item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID QueryContextAttribute_tie::s_com_iid = {0x3219EAF4, 0x9E07, 0x4548, {0x99, 0x55, 0xB0, 0xB8, 0x46, 0x0F, 0xB3, 0xC8}};

QueryContextAttribute_tie::IidRegistrator QueryContextAttribute_tie::s_iid_registrator;

QueryContextAttribute_tie::QueryContextAttribute_tie () : m_impl(NULL) {
}

unsigned long __stdcall QueryContextAttribute_tie::query_interface (
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
unsigned long __stdcall QueryContextAttribute_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryContextAttribute_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryContextAttribute_tie* const>(this));
	}
	return counter;
}

void QueryContextAttribute_tie::init () {
		m_counter = 1;
	}

void QueryContextAttribute_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* QueryContextAttribute_tie::cast (::Core::IObject* obj) {
	QueryContextAttribute* ret = dynamic_cast<QueryContextAttribute*>(obj);
	if (ret) {
		ret->addref();
	}
	IQueryContextAttribute_tie* ret_ = NULL;
	QueryContextAttribute_tie::make_tie (ret, ret_);
	return ret_;
}

void QueryContextAttribute_tie::make_cpp (const IQueryContextAttribute_tie* obj, QueryContextAttribute*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<QueryContextAttribute*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void QueryContextAttribute_tie::make_tie (const QueryContextAttribute* obj, IQueryContextAttribute_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		QueryContextAttribute_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<QueryContextAttribute*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void QueryContextAttribute_tie::make_tie (const QueryContextAttribute& obj, IQueryContextAttribute_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	QueryContextAttribute_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<QueryContextAttribute*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* QueryContextAttribute_tie::get_impl () const {
	return m_impl;
}


QueryTagType __stdcall QueryContextAttribute_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}

void __stdcall QueryContextAttribute_tie::clear_4663F1D20290 () {
_DLL_TRY

	m_impl->clear();
_DLL_CATCH
}

AttributeTag_const __stdcall QueryContextAttribute_tie::get_tag_4767C8D803E1 () const {
_DLL_TRY
	return m_impl->get_tag ();
_DLL_CATCH
}
void __stdcall QueryContextAttribute_tie::add_value_45EEE3740383 (
	QueryLogicOperation operation
	, GCI::IO::IString_tie* context
) {
_DLL_TRY
	GCI::IO::String* context_;
	GCI::IO::String_tie::make_cpp(context, context_);

	m_impl->add_value(operation, context_);
_DLL_CATCH
}


void __stdcall QueryContextAttribute_tie::get_values (ContextValueList_tie*& ret_) const {
_DLL_TRY
	ContextValueList_tie::make_tie (m_impl->get_values(), ret_, this);
_DLL_CATCH
}



const ::Core::ComIID AttributeInfo_tie::s_com_iid = {0x866DFFF9, 0xC146, 0x4174, {0xB3, 0xA8, 0x83, 0x11, 0x90, 0xDF, 0xEA, 0x4D}};

AttributeInfo_tie::IidRegistrator AttributeInfo_tie::s_iid_registrator;

AttributeInfo_tie::AttributeInfo_tie () : m_impl(NULL) {
}

unsigned long __stdcall AttributeInfo_tie::query_interface (
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
unsigned long __stdcall AttributeInfo_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall AttributeInfo_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<AttributeInfo_tie* const>(this));
	}
	return counter;
}

void AttributeInfo_tie::init () {
		m_counter = 1;
	}

void AttributeInfo_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* AttributeInfo_tie::cast (::Core::IObject* obj) {
	AttributeInfo* ret = dynamic_cast<AttributeInfo*>(obj);
	if (ret) {
		ret->addref();
	}
	IAttributeInfo_tie* ret_ = NULL;
	AttributeInfo_tie::make_tie (ret, ret_);
	return ret_;
}

void AttributeInfo_tie::make_cpp (const IAttributeInfo_tie* obj, AttributeInfo*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<AttributeInfo*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void AttributeInfo_tie::make_tie (const AttributeInfo* obj, IAttributeInfo_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		AttributeInfo_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<AttributeInfo*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void AttributeInfo_tie::make_tie (const AttributeInfo& obj, IAttributeInfo_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	AttributeInfo_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<AttributeInfo*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* AttributeInfo_tie::get_impl () const {
	return m_impl;
}


void __stdcall AttributeInfo_tie::get_available_operations (OperationList_tie*& ret_) const {
_DLL_TRY
	OperationList_tie::make_tie (m_impl->get_available_operations(), ret_, this);
_DLL_CATCH
}

void __stdcall AttributeInfo_tie::get_default_value_45F115DD01E2 (
	IQueryAttribute_tie*& ret_
) const {
_DLL_TRY

	QueryAttribute* ret = m_impl->get_default_value();
	QueryAttribute_tie::make_tie(ret, ret_);
_DLL_CATCH
}


bool __stdcall AttributeInfo_tie::get_is_exist () const {
_DLL_TRY
	return m_impl->get_is_exist();
_DLL_CATCH
}



const ::Core::ComIID ContextWordList_tie::s_com_iid = {0x78BEBCCD, 0x97F9, 0x4835, {0x87, 0xAF, 0x13, 0x4D, 0xF4, 0x80, 0x64, 0x5D}};

unsigned long __stdcall ContextWordList_tie::query_interface (
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

unsigned long __stdcall ContextWordList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ContextWordList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ContextWordList_tie* const>(this));
	}
	return counter;
}

void ContextWordList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ContextWordList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ContextWordList_tie::ContextWordList_tie () : m_impl(NULL), m_orphan(true) {
}

void ContextWordList_tie::make_cpp (const ContextWordList_tie* obj, ContextWordList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ContextWordList_tie::new_tie (ContextWordList* obj, ContextWordList_tie*& ret_) {
	Core::Aptr<ContextWordList> obj_aptr (obj);
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

void ContextWordList_tie::make_tie (ContextWordList* obj, ContextWordList_tie*& ret_) {
	Core::Aptr<ContextWordList> obj_aptr (obj);
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
	
void ContextWordList_tie::make_tie (const ContextWordList& obj, ContextWordList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ContextWordList (obj);
	} else {
		ret_ = NULL;
	}
}

void ContextWordList_tie::make_tie (const ContextWordList& obj, ContextWordList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ContextWordList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ContextWordList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ContextWordList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ContextWordList_tie::clear () {
	m_impl->clear();
}

void __stdcall ContextWordList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ContextWordList_tie::get_item (size_t index, GCI::IO::IString_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ContextWordList_tie::set_item (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ContextWordList_tie::add (const GCI::IO::IString_tie* item) {
	GCI::IO::String* item_;
	GCI::IO::String_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall ContextWordList_tie::insert (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Query_tie::s_com_iid = {0x73F075AC, 0x4899, 0x45B6, {0x8C, 0x26, 0x44, 0xA4, 0xC1, 0xEA, 0xA2, 0xC2}};

Query_tie::IidRegistrator Query_tie::s_iid_registrator;

Query_tie::Query_tie () : m_impl(NULL) {
}

unsigned long __stdcall Query_tie::query_interface (
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
unsigned long __stdcall Query_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Query_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Query_tie* const>(this));
	}
	return counter;
}

void Query_tie::init () {
		m_counter = 1;
	}

void Query_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Query_tie::cast (::Core::IObject* obj) {
	Query* ret = dynamic_cast<Query*>(obj);
	if (ret) {
		ret->addref();
	}
	IQuery_tie* ret_ = NULL;
	Query_tie::make_tie (ret, ret_);
	return ret_;
}

void Query_tie::make_cpp (const IQuery_tie* obj, Query*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Query*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Query_tie::make_tie (const Query* obj, IQuery_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Query_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Query*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Query_tie::make_tie (const Query& obj, IQuery_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Query_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Query*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Query_tie::get_impl () const {
	return m_impl;
}


bool __stdcall Query_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall Query_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall Query_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall Query_tie::save_to_456EB3E10178 (
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

void __stdcall Query_tie::append_to_456EB3E1017A (
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

void __stdcall Query_tie::get_attributes (QueryAttributeList_tie*& ret_) const {
_DLL_TRY
	QueryAttributeList_tie::make_tie (m_impl->get_attributes(), ret_, this);
_DLL_CATCH
}

void __stdcall Query_tie::attributes_by_tag_45EEE1450286 (
	const AttributeTag tag
	, QueryAttributeList_tie*& ret_
) {
_DLL_TRY

	::Core::Aptr<QueryAttributeList> ret = m_impl->attributes_by_tag(tag);
	QueryAttributeList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall Query_tie::clear_45EEE1450285 () {
_DLL_TRY

	m_impl->clear();
_DLL_CATCH
}

void __stdcall Query_tie::clone_45EEE1450288 (
	IQuery_tie*& ret_
) {
_DLL_TRY

	Query* ret = m_impl->clone();
	Query_tie::make_tie(ret, ret_);
_DLL_CATCH
}


unsigned long __stdcall Query_tie::get_count () const {
_DLL_TRY
	return m_impl->get_count();
_DLL_CATCH
}


void __stdcall Query_tie::get_date (Date& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_date();
_DLL_CATCH
}

void __stdcall Query_tie::execute_45FF9F9D01F5 (
	IDynList_tie* filtrate_list
	, SearchProgressIndicator::IProgressIndicatorForSearch_tie* progress
	, SearchProgressIndicator::ICancelSearch_tie*& cancel_process
) {
_DLL_TRY
	DynList* filtrate_list_;
	DynList_tie::make_cpp(filtrate_list, filtrate_list_);
	SearchProgressIndicator::ProgressIndicatorForSearch_var progress_;
	SearchProgressIndicator::IProgressIndicatorForSearch_tie::make_cpp(progress, progress_.out ());
	SearchProgressIndicator::CancelSearch* cancel_process_ = 0;

	m_impl->execute(filtrate_list_, progress_.in (), cancel_process_);
	SearchProgressIndicator::CancelSearch_tie::make_tie(cancel_process_, cancel_process);
_DLL_CATCH
}

void __stdcall Query_tie::get_comment_4762B73103AB (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_comment();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Query_tie::get_context_attribute_45EEE145027F (
	const AttributeTag tag
	, IQueryContextAttribute_tie*& ret_
) {
_DLL_TRY

	QueryContextAttribute* ret = m_impl->get_context_attribute(tag);
	QueryContextAttribute_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Query_tie::get_date_attribute_45EEE1450283 (
	const AttributeTag tag
	, IQueryDateAttribute_tie*& ret_
) {
_DLL_TRY

	QueryDateAttribute* ret = m_impl->get_date_attribute(tag);
	QueryDateAttribute_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Query_tie::get_name_4762B6E401CD (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	const GCI::IO::String* ret = m_impl->get_name();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Query_tie::get_node_attribute_45EEE1450281 (
	const AttributeTag tag
	, IQueryNodeAttribute_tie*& ret_
) {
_DLL_TRY

	QueryNodeAttribute* ret = m_impl->get_node_attribute(tag);
	QueryNodeAttribute_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Query_tie::get_phone_number_attribute_45EEE145028A (
	const AttributeTag tag
	, IQueryPhoneNumberAttribute_tie*& ret_
) {
_DLL_TRY

	QueryPhoneNumberAttribute* ret = m_impl->get_phone_number_attribute(tag);
	QueryPhoneNumberAttribute_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall Query_tie::is_filter_query_4CB6EAED0168 () const {
_DLL_TRY
	return m_impl->is_filter_query ();
_DLL_CATCH
}

void __stdcall Query_tie::send_query_45EEE1450289 () {
_DLL_TRY

	m_impl->send_query();
_DLL_CATCH
}

void __stdcall Query_tie::set_comment_4762B7150252 (
	GCI::IO::IString_tie* comment
) {
_DLL_TRY
	GCI::IO::String* comment_;
	GCI::IO::String_tie::make_cpp(comment, comment_);

	m_impl->set_comment(comment_);
_DLL_CATCH
}

void __stdcall Query_tie::set_name_4762B6A10258 (
	GCI::IO::IString_tie* name
) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);

	m_impl->set_name(name_);
_DLL_CATCH
}


QueryType __stdcall Query_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}



const ::Core::ComIID QueryList_tie::s_com_iid = {0x0DE9E8D7, 0xAFF7, 0x4561, {0xBE, 0xB9, 0x74, 0x10, 0x4F, 0xCB, 0xC7, 0xD7}};

unsigned long __stdcall QueryList_tie::query_interface (
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

unsigned long __stdcall QueryList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryList_tie* const>(this));
	}
	return counter;
}

void QueryList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void QueryList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

QueryList_tie::QueryList_tie () : m_impl(NULL), m_orphan(true) {
}

void QueryList_tie::make_cpp (const QueryList_tie* obj, QueryList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void QueryList_tie::new_tie (QueryList* obj, QueryList_tie*& ret_) {
	Core::Aptr<QueryList> obj_aptr (obj);
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

void QueryList_tie::make_tie (QueryList* obj, QueryList_tie*& ret_) {
	Core::Aptr<QueryList> obj_aptr (obj);
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
	
void QueryList_tie::make_tie (const QueryList& obj, QueryList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new QueryList (obj);
	} else {
		ret_ = NULL;
	}
}

void QueryList_tie::make_tie (const QueryList& obj, QueryList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<QueryList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall QueryList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall QueryList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall QueryList_tie::clear () {
	m_impl->clear();
}

void __stdcall QueryList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall QueryList_tie::get_item (size_t index, IQuery_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		Query_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall QueryList_tie::set_item (size_t index, const IQuery_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Query* item_;
		Query_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall QueryList_tie::add (const IQuery_tie* item) {
	Query* item_;
	Query_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall QueryList_tie::insert (size_t index, const IQuery_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Query* item_;
		Query_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Search_tie::s_com_iid = {0xE15D4E0A, 0x900B, 0x460A, {0xBC, 0x2C, 0xF3, 0x5D, 0x28, 0x2B, 0x37, 0x66}};

Search_tie::IidRegistrator Search_tie::s_iid_registrator;

Search_tie::Search_tie () : m_impl(NULL) {
}

unsigned long __stdcall Search_tie::query_interface (
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
unsigned long __stdcall Search_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Search_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Search_tie* const>(this));
	}
	return counter;
}

void Search_tie::init () {
		m_counter = 1;
	}

void Search_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Search_tie::cast (::Core::IObject* obj) {
	Search* ret = dynamic_cast<Search*>(obj);
	if (ret) {
		ret->addref();
	}
	ISearch_tie* ret_ = NULL;
	Search_tie::make_tie (ret, ret_);
	return ret_;
}

void Search_tie::make_cpp (const ISearch_tie* obj, Search*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Search*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Search_tie::make_tie (const Search* obj, ISearch_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Search_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Search*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Search_tie::make_tie (const Search& obj, ISearch_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Search_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Search*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Search_tie::get_impl () const {
	return m_impl;
}

void __stdcall Search_tie::correct_context_48284BC700D9 (
	const ContextWordList_tie* context_for_check
	, bool for_inpharm
	, ContextWordList_tie*& corrected_context
	, ContextWordList_tie*& ret_
) const {
_DLL_TRY
	ContextWordList* context_for_check_;
	ContextWordList_tie::make_cpp(context_for_check, context_for_check_);
	::Core::Aptr<ContextWordList> corrected_context_ = 0;

	::Core::Aptr<ContextWordList> ret = m_impl->correct_context(*context_for_check_, for_inpharm, corrected_context_.out());
	ContextWordList_tie::make_tie(corrected_context_._retn(), corrected_context);
	ContextWordList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall Search_tie::create_query_45EEE0A40202 (
	QueryType type
	, IQuery_tie*& ret_
) const {
_DLL_TRY

	Query* ret = m_impl->create_query(type);
	Query_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Search_tie::get_attribute_info_45EEE0A40204 (
	const AttributeTag tag
	, IAttributeInfo_tie*& ret_
) const {
_DLL_TRY

	AttributeInfo* ret = m_impl->get_attribute_info(tag);
	AttributeInfo_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Search_tie::get_documents_without_class_4746F7020272 (
	IDynList_tie*& ret_
) const {
_DLL_TRY

	DynList* ret = m_impl->get_documents_without_class();
	DynList_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Search_tie::get_documents_without_included_4746F7450002 (
	IDynList_tie*& ret_
) const {
_DLL_TRY

	DynList* ret = m_impl->get_documents_without_included();
	DynList_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Search_tie::get_documents_without_key_4746F76A0308 (
	IDynList_tie*& ret_
) const {
_DLL_TRY

	DynList* ret = m_impl->get_documents_without_key();
	DynList_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Search_tie::get_example_text_467790F3005D (
	unsigned long pos
	, GCI::IO::IString_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_example_text(pos);
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

unsigned long __stdcall Search_tie::get_example_text_count_467790D2006D () const {
_DLL_TRY
	return m_impl->get_example_text_count ();
_DLL_CATCH
}


bool __stdcall Search_tie::get_is_morpho_exist () const {
_DLL_TRY
	return m_impl->get_is_morpho_exist();
_DLL_CATCH
}



const ::Core::ComIID FullAttributeInfo_tie::s_com_iid = {0x5898650D, 0x3C1B, 0x4820, {0xAA, 0x3E, 0x6C, 0x7A, 0x98, 0x09, 0xF2, 0x67}};

FullAttributeInfo_tie::IidRegistrator FullAttributeInfo_tie::s_iid_registrator;

FullAttributeInfo_tie::FullAttributeInfo_tie () : m_impl(NULL) {
}

unsigned long __stdcall FullAttributeInfo_tie::query_interface (
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
unsigned long __stdcall FullAttributeInfo_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FullAttributeInfo_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FullAttributeInfo_tie* const>(this));
	}
	return counter;
}

void FullAttributeInfo_tie::init () {
		m_counter = 1;
	}

void FullAttributeInfo_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FullAttributeInfo_tie::cast (::Core::IObject* obj) {
	FullAttributeInfo* ret = dynamic_cast<FullAttributeInfo*>(obj);
	if (ret) {
		ret->addref();
	}
	IFullAttributeInfo_tie* ret_ = NULL;
	FullAttributeInfo_tie::make_tie (ret, ret_);
	return ret_;
}

void FullAttributeInfo_tie::make_cpp (const IFullAttributeInfo_tie* obj, FullAttributeInfo*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FullAttributeInfo*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FullAttributeInfo_tie::make_tie (const FullAttributeInfo* obj, IFullAttributeInfo_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FullAttributeInfo_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FullAttributeInfo*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FullAttributeInfo_tie::make_tie (const FullAttributeInfo& obj, IFullAttributeInfo_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FullAttributeInfo_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FullAttributeInfo*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FullAttributeInfo_tie::get_impl () const {
	return m_impl;
}


bool __stdcall FullAttributeInfo_tie::get_is_exist () const {
_DLL_TRY
	return m_impl->get_is_exist();
_DLL_CATCH
}


void __stdcall FullAttributeInfo_tie::get_available_operations (OperationList_tie*& ret_) const {
_DLL_TRY
	OperationList_tie::make_tie (m_impl->get_available_operations(), ret_, this);
_DLL_CATCH
}

void __stdcall FullAttributeInfo_tie::get_default_value_45F115DD01E2 (
	IQueryAttribute_tie*& ret_
) const {
_DLL_TRY

	QueryAttribute* ret = m_impl->get_default_value();
	QueryAttribute_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall FullAttributeInfo_tie::get_tag (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_tag(), ret_);
_DLL_CATCH
}



const ::Core::ComIID AttributeList_tie::s_com_iid = {0x0051F266, 0x26A3, 0x4387, {0xA8, 0xB6, 0x0C, 0x92, 0x57, 0xB3, 0x57, 0xAE}};

unsigned long __stdcall AttributeList_tie::query_interface (
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

unsigned long __stdcall AttributeList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall AttributeList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<AttributeList_tie* const>(this));
	}
	return counter;
}

void AttributeList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void AttributeList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

AttributeList_tie::AttributeList_tie () : m_impl(NULL), m_orphan(true) {
}

void AttributeList_tie::make_cpp (const AttributeList_tie* obj, AttributeList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void AttributeList_tie::new_tie (AttributeList* obj, AttributeList_tie*& ret_) {
	Core::Aptr<AttributeList> obj_aptr (obj);
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

void AttributeList_tie::make_tie (AttributeList* obj, AttributeList_tie*& ret_) {
	Core::Aptr<AttributeList> obj_aptr (obj);
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
	
void AttributeList_tie::make_tie (const AttributeList& obj, AttributeList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new AttributeList (obj);
	} else {
		ret_ = NULL;
	}
}

void AttributeList_tie::make_tie (const AttributeList& obj, AttributeList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<AttributeList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall AttributeList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall AttributeList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall AttributeList_tie::clear () {
	m_impl->clear();
}

void __stdcall AttributeList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall AttributeList_tie::get_item (size_t index, IFullAttributeInfo_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		FullAttributeInfo_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall AttributeList_tie::set_item (size_t index, const IFullAttributeInfo_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FullAttributeInfo* item_;
		FullAttributeInfo_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall AttributeList_tie::add (const IFullAttributeInfo_tie* item) {
	FullAttributeInfo* item_;
	FullAttributeInfo_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall AttributeList_tie::insert (size_t index, const IFullAttributeInfo_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FullAttributeInfo* item_;
		FullAttributeInfo_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID QueryCardInfo_tie::s_com_iid = {0xF9D884BA, 0xB356, 0x4A7C, {0x89, 0x97, 0xD3, 0xE7, 0x4A, 0x8F, 0xB8, 0xF1}};

QueryCardInfo_tie::IidRegistrator QueryCardInfo_tie::s_iid_registrator;

QueryCardInfo_tie::QueryCardInfo_tie () : m_impl(NULL) {
}

unsigned long __stdcall QueryCardInfo_tie::query_interface (
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
unsigned long __stdcall QueryCardInfo_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall QueryCardInfo_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<QueryCardInfo_tie* const>(this));
	}
	return counter;
}

void QueryCardInfo_tie::init () {
		m_counter = 1;
	}

void QueryCardInfo_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* QueryCardInfo_tie::cast (::Core::IObject* obj) {
	QueryCardInfo* ret = dynamic_cast<QueryCardInfo*>(obj);
	if (ret) {
		ret->addref();
	}
	IQueryCardInfo_tie* ret_ = NULL;
	QueryCardInfo_tie::make_tie (ret, ret_);
	return ret_;
}

void QueryCardInfo_tie::make_cpp (const IQueryCardInfo_tie* obj, QueryCardInfo*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<QueryCardInfo*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void QueryCardInfo_tie::make_tie (const QueryCardInfo* obj, IQueryCardInfo_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		QueryCardInfo_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<QueryCardInfo*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void QueryCardInfo_tie::make_tie (const QueryCardInfo& obj, IQueryCardInfo_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	QueryCardInfo_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<QueryCardInfo*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* QueryCardInfo_tie::get_impl () const {
	return m_impl;
}


void __stdcall QueryCardInfo_tie::get_evd_card (GCI::IO::IStream_tie*& ret_) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	GCI::IO::Stream_tie::make_tie (m_impl->get_evd_card(), ret_);
_DLL_CATCH
}

void __stdcall QueryCardInfo_tie::get_exist_attrs_4CC973C702EE (
	AttributeList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<AttributeList> ret = m_impl->get_exist_attrs();
	AttributeList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}



const ::Core::ComIID AttributesHelper_tie::s_com_iid = {0x03CD2930, 0x3AE2, 0x4CC9, {0x9B, 0xE4, 0x50, 0x1A, 0x2B, 0x75, 0x8C, 0x64}};

AttributesHelper_tie::IidRegistrator AttributesHelper_tie::s_iid_registrator;

AttributesHelper_tie::AttributesHelper_tie () : m_impl(NULL) {
}

unsigned long __stdcall AttributesHelper_tie::query_interface (
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
unsigned long __stdcall AttributesHelper_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall AttributesHelper_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<AttributesHelper_tie* const>(this));
	}
	return counter;
}

void AttributesHelper_tie::init () {
		m_counter = 1;
	}

void AttributesHelper_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* AttributesHelper_tie::cast (::Core::IObject* obj) {
	AttributesHelper* ret = dynamic_cast<AttributesHelper*>(obj);
	if (ret) {
		ret->addref();
	}
	IAttributesHelper_tie* ret_ = NULL;
	AttributesHelper_tie::make_tie (ret, ret_);
	return ret_;
}

void AttributesHelper_tie::make_cpp (const IAttributesHelper_tie* obj, AttributesHelper*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<AttributesHelper*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void AttributesHelper_tie::make_tie (const AttributesHelper* obj, IAttributesHelper_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		AttributesHelper_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<AttributesHelper*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void AttributesHelper_tie::make_tie (const AttributesHelper& obj, IAttributesHelper_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	AttributesHelper_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<AttributesHelper*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* AttributesHelper_tie::get_impl () const {
	return m_impl;
}

bool __stdcall AttributesHelper_tie::attribute_KW_exists_4CEA4D0702FD () const {
_DLL_TRY
	return m_impl->attribute_KW_exists ();
_DLL_CATCH
}

bool __stdcall AttributesHelper_tie::attribute_publish_source_exists_4CEA4D5D002C () const {
_DLL_TRY
	return m_impl->attribute_publish_source_exists ();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

