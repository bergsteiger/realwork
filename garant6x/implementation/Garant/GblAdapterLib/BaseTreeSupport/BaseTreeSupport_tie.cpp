////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// Поддержка старого дерева.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID Node_tie::s_com_iid = {0xA050343E, 0xCA33, 0x4D63, {0x83, 0x85, 0x2F, 0xFB, 0xD9, 0xB0, 0x12, 0xDA}};

Node_tie::IidRegistrator Node_tie::s_iid_registrator;

Node_tie::Node_tie () : m_impl(NULL) {
}

unsigned long __stdcall Node_tie::query_interface (
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
unsigned long __stdcall Node_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Node_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Node_tie* const>(this));
	}
	return counter;
}

void Node_tie::init () {
		m_counter = 1;
	}

void Node_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Node_tie::cast (::Core::IObject* obj) {
	Node* ret = dynamic_cast<Node*>(obj);
	if (ret) {
		ret->addref();
	}
	INode_tie* ret_ = NULL;
	Node_tie::make_tie (ret, ret_);
	return ret_;
}

void Node_tie::make_cpp (const INode_tie* obj, Node*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Node*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Node_tie::make_tie (const Node* obj, INode_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Node_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Node*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Node_tie::make_tie (const Node& obj, INode_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Node_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Node*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Node_tie::get_impl () const {
	return m_impl;
}

void __stdcall Node_tie::add_child_node_456FE63B01DE (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/ {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->add_child_node(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Node_tie::add_sibling_node_456FE63B01E0 (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const /*throw (ConstantModify_tie, Unsupported_tie, DuplicateNode_tie)*/ {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->add_sibling_node(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}


long __stdcall Node_tie::get_all_child_count () const {
_DLL_TRY
	return m_impl->get_all_child_count();
_DLL_CATCH
}

bool __stdcall Node_tie::can_copy_456FE63B01E7 () const {
_DLL_TRY
	return m_impl->can_copy ();
_DLL_CATCH
}

bool __stdcall Node_tie::can_insert_456FE63B01E8 (
	INode_tie* source
) const {
_DLL_TRY
	Node* source_;
	Node_tie::make_cpp(source, source_);

	bool ret = m_impl->can_insert(source_);
	return ret;
_DLL_CATCH
}

bool __stdcall Node_tie::can_modify_4AA55863036D () const {
_DLL_TRY
	return m_impl->can_modify ();
_DLL_CATCH
}

bool __stdcall Node_tie::can_move_456FE63B01E6 () const {
_DLL_TRY
	return m_impl->can_move ();
_DLL_CATCH
}


void __stdcall Node_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_, this);
_DLL_CATCH
}
void __stdcall Node_tie::set_caption (GCI::IO::IString_tie* caption) /*throw (ConstantModify_tie, AccessDenied_tie)*/ {
_DLL_TRY
	GCI::IO::String* caption_;
	GCI::IO::String_tie::make_cpp(caption, caption_);
	m_impl->set_caption(caption_);
_DLL_CATCH
}


long __stdcall Node_tie::get_child_count () const {
_DLL_TRY
	return m_impl->get_child_count();
_DLL_CATCH
}

void __stdcall Node_tie::copy_to_location_456FE63B01E4 (
	INode_tie* destination
) /*throw (CopyDisabled_tie, InvalidContainer_tie)*/ {
_DLL_TRY
	Node* destination_;
	Node_tie::make_cpp(destination, destination_);

	m_impl->copy_to_location(destination_);
_DLL_CATCH
}

void __stdcall Node_tie::delete_node_456FE63B01DD () /*throw (ConstantModify_tie, AccessDenied_tie, EmptyResult_tie)*/ {
_DLL_TRY

	m_impl->delete_node();
_DLL_CATCH
}


long __stdcall Node_tie::get_flags () const {
_DLL_TRY
	return m_impl->get_flags();
_DLL_CATCH
}

void __stdcall Node_tie::get_child_456FE63B01D6 (
	long index
	, INode_tie*& ret_
) /*throw (InvalidIndex_tie)*/ {
_DLL_TRY

	Node* ret = m_impl->get_child(index);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall Node_tie::has_child_456FE63B01EC () const {
_DLL_TRY
	return m_impl->has_child ();
_DLL_CATCH
}


void __stdcall Node_tie::get_hint (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_hint(), ret_, this);
_DLL_CATCH
}
void __stdcall Node_tie::set_hint (GCI::IO::IString_tie* hint) /*throw (ConstantModify_tie, AccessDenied_tie)*/ {
_DLL_TRY
	GCI::IO::String* hint_;
	GCI::IO::String_tie::make_cpp(hint, hint_);
	m_impl->set_hint(hint_);
_DLL_CATCH
}


long __stdcall Node_tie::get_index () const {
_DLL_TRY
	return m_impl->get_index();
_DLL_CATCH
}

bool __stdcall Node_tie::is_first_456FE63B01EB () const {
_DLL_TRY
	return m_impl->is_first ();
_DLL_CATCH
}

bool __stdcall Node_tie::is_last_456FE63B01EA () const {
_DLL_TRY
	return m_impl->is_last ();
_DLL_CATCH
}

bool __stdcall Node_tie::is_same_node_456FE63B01D9 (
	const INode_tie* node
) const {
_DLL_TRY
	Node* node_;
	Node_tie::make_cpp(node, node_);

	bool ret = m_impl->is_same_node(node_);
	return ret;
_DLL_CATCH
}


long __stdcall Node_tie::get_level () const {
_DLL_TRY
	return m_impl->get_level();
_DLL_CATCH
}

void __stdcall Node_tie::move_to_location_456FE63B01E2 (
	INode_tie* destination
) /*throw (InvalidContainer_tie, MoveDisabled_tie)*/ {
_DLL_TRY
	Node* destination_;
	Node_tie::make_cpp(destination, destination_);

	m_impl->move_to_location(destination_);
_DLL_CATCH
}


void __stdcall Node_tie::get_next_node (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_next_node(), ret_);
_DLL_CATCH
}


EntityType __stdcall Node_tie::get_object_type () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_object_type();
_DLL_CATCH
}

void __stdcall Node_tie::open_456FE63B01DB (
	Core::IIObject_tie*& ret_
) /*throw (CanNotFindData_tie, NotEntityElement_tie)*/ {
_DLL_TRY

	Core::IObject* ret = m_impl->open();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Node_tie::override_child_node_456FE63B01ED (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/ {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->override_child_node(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall Node_tie::get_parent (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_parent(), ret_);
_DLL_CATCH
}


void __stdcall Node_tie::get_previous_node (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_previous_node(), ret_);
_DLL_CATCH
}


long __stdcall Node_tie::get_through_index () const {
_DLL_TRY
	return m_impl->get_through_index();
_DLL_CATCH
}



const ::Core::ComIID BaseCatalog_tie::s_com_iid = {0xB41C62C4, 0xF733, 0x4465, {0x9B, 0x22, 0x3D, 0x4C, 0x52, 0x16, 0x2F, 0x8A}};

BaseCatalog_tie::IidRegistrator BaseCatalog_tie::s_iid_registrator;

BaseCatalog_tie::BaseCatalog_tie () : m_impl(NULL) {
}

unsigned long __stdcall BaseCatalog_tie::query_interface (
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
unsigned long __stdcall BaseCatalog_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall BaseCatalog_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<BaseCatalog_tie* const>(this));
	}
	return counter;
}

void BaseCatalog_tie::init () {
		m_counter = 1;
	}

void BaseCatalog_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* BaseCatalog_tie::cast (::Core::IObject* obj) {
	BaseCatalog* ret = dynamic_cast<BaseCatalog*>(obj);
	if (ret) {
		ret->addref();
	}
	IBaseCatalog_tie* ret_ = NULL;
	BaseCatalog_tie::make_tie (ret, ret_);
	return ret_;
}

void BaseCatalog_tie::make_cpp (const IBaseCatalog_tie* obj, BaseCatalog*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<BaseCatalog*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void BaseCatalog_tie::make_tie (const BaseCatalog* obj, IBaseCatalog_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		BaseCatalog_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<BaseCatalog*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void BaseCatalog_tie::make_tie (const BaseCatalog& obj, IBaseCatalog_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	BaseCatalog_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<BaseCatalog*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* BaseCatalog_tie::get_impl () const {
	return m_impl;
}


const EntityType __stdcall BaseCatalog_tie::get_filter () const {
_DLL_TRY
	return m_impl->get_filter();
_DLL_CATCH
}
void __stdcall BaseCatalog_tie::set_filter (EntityType filter) {
_DLL_TRY
	m_impl->set_filter(filter);
_DLL_CATCH
}

void __stdcall BaseCatalog_tie::find_456FEA67007E (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->find(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall BaseCatalog_tie::find_context_456FEA670080 (
	const char* mask
	, const SearchMode& mode
	, const INode_tie* cur_item
	, ContextSearchResult_tie& result
	, INode_tie*& ret_
) const {
_DLL_TRY
	Node* cur_item_;
	Node_tie::make_cpp(cur_item, cur_item_);
	::Core::Aptr<ContextSearchResult> result_ = 0;

	Node* ret = m_impl->find_context(mask, mode, cur_item_, result_.out());
	ContextSearchResult_tie::make_tie(*result_, result);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall BaseCatalog_tie::reset_type_filter_456FEA670085 () const {
_DLL_TRY

	m_impl->reset_type_filter();
_DLL_CATCH
}


void __stdcall BaseCatalog_tie::get_root (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_root(), ret_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

