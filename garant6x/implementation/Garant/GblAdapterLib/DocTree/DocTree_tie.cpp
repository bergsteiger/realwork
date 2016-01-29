////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DocTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID DocNodeFilter_tie::s_com_iid = {0x8BEEB7B1, 0x6BD1, 0x4BAF, {0x80, 0x71, 0x9A, 0x7F, 0xD1, 0xFF, 0x2E, 0x59}};

DocNodeFilter_tie::IidRegistrator DocNodeFilter_tie::s_iid_registrator;

DocNodeFilter_tie::DocNodeFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall DocNodeFilter_tie::query_interface (
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
unsigned long __stdcall DocNodeFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DocNodeFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DocNodeFilter_tie* const>(this));
	}
	return counter;
}

void DocNodeFilter_tie::init () {
		m_counter = 1;
	}

void DocNodeFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DocNodeFilter_tie::cast (::Core::IObject* obj) {
	DocNodeFilter* ret = dynamic_cast<DocNodeFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	IDocNodeFilter_tie* ret_ = NULL;
	DocNodeFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void DocNodeFilter_tie::make_cpp (const IDocNodeFilter_tie* obj, DocNodeFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DocNodeFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DocNodeFilter_tie::make_tie (const DocNodeFilter* obj, IDocNodeFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DocNodeFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DocNodeFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DocNodeFilter_tie::make_tie (const DocNodeFilter& obj, IDocNodeFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DocNodeFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DocNodeFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DocNodeFilter_tie::get_impl () const {
	return m_impl;
}


TagHandle __stdcall DocNodeFilter_tie::get_id () const {
_DLL_TRY
	return m_impl->get_id();
_DLL_CATCH
}
void __stdcall DocNodeFilter_tie::set_id (TagHandle id) {
_DLL_TRY
	m_impl->set_id(id);
_DLL_CATCH
}


bool __stdcall DocNodeFilter_tie::get_inheritable () const {
_DLL_TRY
	return m_impl->get_inheritable();
_DLL_CATCH
}
void __stdcall DocNodeFilter_tie::set_inheritable (bool inheritable) {
_DLL_TRY
	m_impl->set_inheritable(inheritable);
_DLL_CATCH
}


NodeType __stdcall DocNodeFilter_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}
void __stdcall DocNodeFilter_tie::set_type (NodeType type) {
_DLL_TRY
	m_impl->set_type(type);
_DLL_CATCH
}



const ::Core::ComIID ContentsNode_tie::s_com_iid = {0x1D59A8F6, 0xCE4D, 0x4737, {0xB8, 0x12, 0x85, 0x90, 0x43, 0x56, 0xF8, 0x2B}};

ContentsNode_tie::IidRegistrator ContentsNode_tie::s_iid_registrator;

ContentsNode_tie::ContentsNode_tie () : m_impl(NULL) {
}

unsigned long __stdcall ContentsNode_tie::query_interface (
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
unsigned long __stdcall ContentsNode_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ContentsNode_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ContentsNode_tie* const>(this));
	}
	return counter;
}

void ContentsNode_tie::init () {
		m_counter = 1;
	}

void ContentsNode_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ContentsNode_tie::cast (::Core::IObject* obj) {
	ContentsNode* ret = dynamic_cast<ContentsNode*>(obj);
	if (ret) {
		ret->addref();
	}
	IContentsNode_tie* ret_ = NULL;
	ContentsNode_tie::make_tie (ret, ret_);
	return ret_;
}

void ContentsNode_tie::make_cpp (const IContentsNode_tie* obj, ContentsNode*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ContentsNode*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ContentsNode_tie::make_tie (const ContentsNode* obj, IContentsNode_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ContentsNode_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ContentsNode*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ContentsNode_tie::make_tie (const ContentsNode& obj, IContentsNode_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ContentsNode_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ContentsNode*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ContentsNode_tie::get_impl () const {
	return m_impl;
}

void __stdcall ContentsNode_tie::save_in_setting_45EECD5D02EF (
	const PropertyID id
) const {
_DLL_TRY

	m_impl->save_in_setting(id);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::load_from_setting_45EECD5D02F1 (
	const PropertyID id
	, ISettingEntity_tie*& ret_
) const {
_DLL_TRY

	SettingEntity* ret = m_impl->load_from_setting(id);
	SettingEntity_tie::make_tie(ret, ret_);
_DLL_CATCH
}
void __stdcall ContentsNode_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_, this);
_DLL_CATCH
}


long __stdcall ContentsNode_tie::get_level () const {
_DLL_TRY
	return m_impl->get_level();
_DLL_CATCH
}


NodeType __stdcall ContentsNode_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}
void __stdcall ContentsNode_tie::set_type (NodeType type) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	m_impl->set_type(type);
_DLL_CATCH
}


long __stdcall ContentsNode_tie::get_child_count () const {
_DLL_TRY
	return m_impl->get_child_count();
_DLL_CATCH
}


bool __stdcall ContentsNode_tie::get_is_expanded () const {
_DLL_TRY
	return m_impl->get_is_expanded();
_DLL_CATCH
}


void __stdcall ContentsNode_tie::get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/ {
_DLL_TRY
	EntityBase_tie::make_tie (m_impl->get_entity(), ret_);
_DLL_CATCH
}
void __stdcall ContentsNode_tie::set_entity (IEntityBase_tie* entity) {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);
	m_impl->set_entity(entity_);
_DLL_CATCH
}


void __stdcall ContentsNode_tie::get_first_child (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_first_child(), ret_);
_DLL_CATCH
}


void __stdcall ContentsNode_tie::get_prev (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_prev(), ret_);
_DLL_CATCH
}


void __stdcall ContentsNode_tie::get_next (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_next(), ret_);
_DLL_CATCH
}


void __stdcall ContentsNode_tie::get_parent (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_parent(), ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::add_notifier_45EEB95901C7 (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->add_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall ContentsNode_tie::create_view_ex_45EEB95901C9 (
	const FilterList_tie* filter
	, FlagMask shared_flags
	, const INodeBase_tie* sync_node
	, VisibleIndex& sync_index
	, unsigned long levels
	, bool unfiltered
	, bool auto_open
	, bool truncate_this_view
	, INodeBase_tie*& ret_
) {
_DLL_TRY
	FilterList* filter_;
	FilterList_tie::make_cpp(filter, filter_);
	NodeBase* sync_node_;
	NodeBase_tie::make_cpp(sync_node, sync_node_);

	NodeBase* ret = m_impl->create_view_ex(*filter_, shared_flags, sync_node_, sync_index, levels, unfiltered, auto_open, truncate_this_view);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::find_node_45EEB95901D2 (
	const INodeBase_tie* node_to_find
	, INodeBase_tie*& ret_
) const {
_DLL_TRY
	NodeBase* node_to_find_;
	NodeBase_tie::make_cpp(node_to_find, node_to_find_);

	NodeBase* ret = m_impl->find_node(node_to_find_);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::find_node_path_45EEB95901D4 (
	INodeBase_tie* node_to_find
	, NodeIndexPath_tie*& ret_
) const {
_DLL_TRY
	NodeBase* node_to_find_;
	NodeBase_tie::make_cpp(node_to_find, node_to_find_);

	::Core::Aptr<NodeIndexPath> ret = m_impl->find_node_path(node_to_find_);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_by_sibbling_index_45EEB95901D6 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_sibbling_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_by_visible_index_45EEB95901D8 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_visible_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_first_fit_45EEB95901DA (
	const FilterList_tie* filter
	, NodeIndexPath_tie*& ret_
) const {
_DLL_TRY
	FilterList* filter_;
	FilterList_tie::make_cpp(filter, filter_);

	::Core::Aptr<NodeIndexPath> ret = m_impl->get_first_fit(*filter_);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

unsigned long __stdcall ContentsNode_tie::get_flag_count_45EEB95901DC (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_flag_count (flag);
_DLL_CATCH
}

unsigned long __stdcall ContentsNode_tie::get_first_level_children_flag_count_4677A5180213 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_first_level_children_flag_count (flag);
_DLL_CATCH
}

NodeId __stdcall ContentsNode_tie::get_node_id_45EEB95901DE () const {
_DLL_TRY
	return m_impl->get_node_id ();
_DLL_CATCH
}

void __stdcall ContentsNode_tie::set_node_id_45EEB95901DF (
	NodeId id
) {
_DLL_TRY

	m_impl->set_node_id(id);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_available_layers_46236D06007D (
	LayerIdList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<LayerIdList> ret = m_impl->get_available_layers();
	LayerIdList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

VisibleIndex __stdcall ContentsNode_tie::get_visible_delta_45EEB95901E1 (
	const INodeBase_tie* node
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	VisibleIndex ret = m_impl->get_visible_delta(node_);
	return ret;
_DLL_CATCH
}

VisibleIndex __stdcall ContentsNode_tie::get_visible_delta_by_entity_45EEB95901E3 (
	const IEntityBase_tie* entity
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);

	VisibleIndex ret = m_impl->get_visible_delta_by_entity(entity_);
	return ret;
_DLL_CATCH
}

VisibleIndex __stdcall ContentsNode_tie::get_index_from_parent_45EEB95901E5 () const {
_DLL_TRY
	return m_impl->get_index_from_parent ();
_DLL_CATCH
}

VisibleIndex __stdcall ContentsNode_tie::get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	return m_impl->get_abs_index ();
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_child_path_by_abs_index_45EEB95901E7 (
	VisibleIndex index
	, NodeIndexPath_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<NodeIndexPath> ret = m_impl->get_child_path_by_abs_index(index);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_frozen_node_4624DEED008C (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_frozen_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_unfiltered_node_4625D15D0138 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_unfiltered_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::has_children_45EEB95901EA () const {
_DLL_TRY
	return m_impl->has_children ();
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::has_children_flag_45EEB95901EB (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_children_flag (flag);
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::has_filtered_children_45EEB95901ED () const {
_DLL_TRY
	return m_impl->has_filtered_children ();
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::has_flag_45EEB95901EE (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_flag (flag);
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::has_parent_flag_45EEB95901F0 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_parent_flag (flag);
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::is_first_45EEB95901F2 () const {
_DLL_TRY
	return m_impl->is_first ();
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::is_it_higher_45EEB95901F3 (
	INodeBase_tie* it
) const {
_DLL_TRY
	NodeBase* it_;
	NodeBase_tie::make_cpp(it, it_);

	bool ret = m_impl->is_it_higher(it_);
	return ret;
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::is_last_45EEB95901F5 () const {
_DLL_TRY
	return m_impl->is_last ();
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::is_same_node_45EEB95901F6 (
	INodeBase_tie* node
) const {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	bool ret = m_impl->is_same_node(node_);
	return ret;
_DLL_CATCH
}

void __stdcall ContentsNode_tie::iterate_nodes_45EEB95901F8 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::make_visible_45EEB95901FA () {
_DLL_TRY

	m_impl->make_visible();
_DLL_CATCH
}

void __stdcall ContentsNode_tie::remove_notifier_45EEB95901FB (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->remove_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall ContentsNode_tie::set_all_flag_45EEB95901FD (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag(flag, value);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::set_flag_45EEB9590200 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_flag(flag, value);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::set_range_flag_45EEB9590203 (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
_DLL_TRY

	m_impl->set_range_flag(offset_from, offset_to, flag, value, clean_other);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::delete_nodes_45EEB9590209 (
	FlagMask mask
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY

	m_impl->delete_nodes(mask);
_DLL_CATCH_RETURNED
}

void __stdcall ContentsNode_tie::delete_node_45EEB959020B () {
_DLL_TRY

	m_impl->delete_node();
_DLL_CATCH_RETURNED
}

void __stdcall ContentsNode_tie::copy_nodes_45EEB959020C (
	FlagMask mask
	, INodesClipboard_tie*& ret_
) {
_DLL_TRY

	NodesClipboard* ret = m_impl->copy_nodes(mask);
	NodesClipboard_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::add_last_childs_45EEB959020F (
	INodesClipboard_tie* nodes
) {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_last_childs(nodes_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::add_last_child_45EEB9590211 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_last_child(node_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::add_prev_siblings_45EEB9590213 (
	INodesClipboard_tie* nodes
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_prev_siblings(nodes_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::add_prev_sibling_45EEB9590215 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_prev_sibling(node_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::start_change_transaction_45EEB9590217 () {
_DLL_TRY

	m_impl->start_change_transaction();
_DLL_CATCH
}

void __stdcall ContentsNode_tie::rollback_change_transaction_45EEB9590218 () {
_DLL_TRY

	m_impl->rollback_change_transaction();
_DLL_CATCH
}

void __stdcall ContentsNode_tie::commit_change_transaction_45EEB9590219 () {
_DLL_TRY

	m_impl->commit_change_transaction();
_DLL_CATCH
}

void __stdcall ContentsNode_tie::get_node_by_path_45EEB959021A (
	const NodeIndexPath_tie* path
	, INodeBase_tie*& ret_
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	NodeIndexPath* path_;
	NodeIndexPath_tie::make_cpp(path, path_);

	NodeBase* ret = m_impl->get_node_by_path(*path_);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::find_45EEB959021C (
	const FilterList_tie* filter
	, const NodePosition_tie& find_from
	, IFindIterator_tie*& ret_
) const {
_DLL_TRY
	FilterList* filter_;
	FilterList_tie::make_cpp(filter, filter_);
	NodePosition find_from_;
	NodePosition_tie::make_cpp(find_from, find_from_);

	FindIterator* ret = m_impl->find(*filter_, find_from_);
	FindIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall ContentsNode_tie::is_relevance_search_supported_45EEB959021F () const {
_DLL_TRY
	return m_impl->is_relevance_search_supported ();
_DLL_CATCH
}

void __stdcall ContentsNode_tie::expand_all_45EEB9590220 (
	bool expand
) {
_DLL_TRY

	m_impl->expand_all(expand);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::iterate_all_nodes_473D89660266 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_all_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::set_all_flag_except_first_children_of_root_children_51EFC4100162 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag_except_first_children_of_root_children(flag, value);
_DLL_CATCH
}

void __stdcall ContentsNode_tie::set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
_DLL_TRY

	m_impl->set_range_flag_except_first_children_of_root_children(offset_from, offset_to, flag, value, clean_other);
_DLL_CATCH
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

