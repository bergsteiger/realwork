////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Security/Security_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID UserProfile_tie::s_com_iid = {0x600B24EC, 0x1FB9, 0x40F2, {0xA6, 0xFC, 0xE8, 0x93, 0x97, 0x67, 0x9F, 0x80}};

UserProfile_tie::IidRegistrator UserProfile_tie::s_iid_registrator;

UserProfile_tie::UserProfile_tie () : m_impl(NULL) {
}

unsigned long __stdcall UserProfile_tie::query_interface (
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
unsigned long __stdcall UserProfile_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall UserProfile_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<UserProfile_tie* const>(this));
	}
	return counter;
}

void UserProfile_tie::init () {
		m_counter = 1;
	}

void UserProfile_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* UserProfile_tie::cast (::Core::IObject* obj) {
	UserProfile* ret = dynamic_cast<UserProfile*>(obj);
	if (ret) {
		ret->addref();
	}
	IUserProfile_tie* ret_ = NULL;
	UserProfile_tie::make_tie (ret, ret_);
	return ret_;
}

void UserProfile_tie::make_cpp (const IUserProfile_tie* obj, UserProfile*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<UserProfile*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void UserProfile_tie::make_tie (const UserProfile* obj, IUserProfile_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		UserProfile_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<UserProfile*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void UserProfile_tie::make_tie (const UserProfile& obj, IUserProfile_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	UserProfile_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<UserProfile*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* UserProfile_tie::get_impl () const {
	return m_impl;
}


bool __stdcall UserProfile_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall UserProfile_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall UserProfile_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall UserProfile_tie::save_to_456EB3E10178 (
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

void __stdcall UserProfile_tie::append_to_456EB3E1017A (
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
bool __stdcall UserProfile_tie::can_buy_consulting_45EED78501BD () const {
_DLL_TRY
	return m_impl->can_buy_consulting ();
_DLL_CATCH
}

void __stdcall UserProfile_tie::get_login_45EED78501B7 (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	const GCI::IO::String& ret = m_impl->get_login();
	GCI::IO::String_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

void __stdcall UserProfile_tie::get_mail_45EED78501BA (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	const GCI::IO::String& ret = m_impl->get_mail();
	GCI::IO::String_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

void __stdcall UserProfile_tie::get_name_45EED78501B9 (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	const GCI::IO::String& ret = m_impl->get_name();
	GCI::IO::String_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

long __stdcall UserProfile_tie::get_uid_45EED78501BB () const {
_DLL_TRY
	return m_impl->get_uid ();
_DLL_CATCH
}


const Uid __stdcall UserProfile_tie::get_group_id () const /*throw (AccessDenied_tie)*/ {
_DLL_TRY
	return m_impl->get_group_id();
_DLL_CATCH
}

bool __stdcall UserProfile_tie::has_password_45EED78501B8 () const {
_DLL_TRY
	return m_impl->has_password ();
_DLL_CATCH
}

bool __stdcall UserProfile_tie::is_privileged_473DCDF900ED () const {
_DLL_TRY
	return m_impl->is_privileged ();
_DLL_CATCH
}

bool __stdcall UserProfile_tie::is_system_45EED78501BC () const {
_DLL_TRY
	return m_impl->is_system ();
_DLL_CATCH
}



const ::Core::ComIID UserFilter_tie::s_com_iid = {0xA3970144, 0x43FB, 0x4E18, {0xBB, 0xBB, 0x7B, 0x24, 0x60, 0x74, 0x87, 0x3E}};

UserFilter_tie::IidRegistrator UserFilter_tie::s_iid_registrator;

UserFilter_tie::UserFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall UserFilter_tie::query_interface (
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
unsigned long __stdcall UserFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall UserFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<UserFilter_tie* const>(this));
	}
	return counter;
}

void UserFilter_tie::init () {
		m_counter = 1;
	}

void UserFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* UserFilter_tie::cast (::Core::IObject* obj) {
	UserFilter* ret = dynamic_cast<UserFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	IUserFilter_tie* ret_ = NULL;
	UserFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void UserFilter_tie::make_cpp (const IUserFilter_tie* obj, UserFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<UserFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void UserFilter_tie::make_tie (const UserFilter* obj, IUserFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		UserFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<UserFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void UserFilter_tie::make_tie (const UserFilter& obj, IUserFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	UserFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<UserFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* UserFilter_tie::get_impl () const {
	return m_impl;
}


unsigned long __stdcall UserFilter_tie::get_flags () const {
_DLL_TRY
	return m_impl->get_flags();
_DLL_CATCH
}
void __stdcall UserFilter_tie::set_flags (unsigned long flags) {
_DLL_TRY
	m_impl->set_flags(flags);
_DLL_CATCH
}


const Uid __stdcall UserFilter_tie::get_group_uid () const {
_DLL_TRY
	return m_impl->get_group_uid();
_DLL_CATCH
}
void __stdcall UserFilter_tie::set_group_uid (Uid group_uid) {
_DLL_TRY
	m_impl->set_group_uid(group_uid);
_DLL_CATCH
}



const ::Core::ComIID ProfileNode_tie::s_com_iid = {0xA5ED9F82, 0xE286, 0x4359, {0x83, 0x9E, 0x02, 0x1E, 0x43, 0x6C, 0xA6, 0x5E}};

ProfileNode_tie::IidRegistrator ProfileNode_tie::s_iid_registrator;

ProfileNode_tie::ProfileNode_tie () : m_impl(NULL) {
}

unsigned long __stdcall ProfileNode_tie::query_interface (
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
unsigned long __stdcall ProfileNode_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ProfileNode_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ProfileNode_tie* const>(this));
	}
	return counter;
}

void ProfileNode_tie::init () {
		m_counter = 1;
	}

void ProfileNode_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ProfileNode_tie::cast (::Core::IObject* obj) {
	ProfileNode* ret = dynamic_cast<ProfileNode*>(obj);
	if (ret) {
		ret->addref();
	}
	IProfileNode_tie* ret_ = NULL;
	ProfileNode_tie::make_tie (ret, ret_);
	return ret_;
}

void ProfileNode_tie::make_cpp (const IProfileNode_tie* obj, ProfileNode*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ProfileNode*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ProfileNode_tie::make_tie (const ProfileNode* obj, IProfileNode_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ProfileNode_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ProfileNode*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ProfileNode_tie::make_tie (const ProfileNode& obj, IProfileNode_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ProfileNode_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ProfileNode*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ProfileNode_tie::get_impl () const {
	return m_impl;
}

void __stdcall ProfileNode_tie::save_in_setting_45EECD5D02EF (
	const PropertyID id
) const {
_DLL_TRY

	m_impl->save_in_setting(id);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::load_from_setting_45EECD5D02F1 (
	const PropertyID id
	, ISettingEntity_tie*& ret_
) const {
_DLL_TRY

	SettingEntity* ret = m_impl->load_from_setting(id);
	SettingEntity_tie::make_tie(ret, ret_);
_DLL_CATCH
}
void __stdcall ProfileNode_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_, this);
_DLL_CATCH
}


long __stdcall ProfileNode_tie::get_level () const {
_DLL_TRY
	return m_impl->get_level();
_DLL_CATCH
}


NodeType __stdcall ProfileNode_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}
void __stdcall ProfileNode_tie::set_type (NodeType type) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	m_impl->set_type(type);
_DLL_CATCH
}


long __stdcall ProfileNode_tie::get_child_count () const {
_DLL_TRY
	return m_impl->get_child_count();
_DLL_CATCH
}


bool __stdcall ProfileNode_tie::get_is_expanded () const {
_DLL_TRY
	return m_impl->get_is_expanded();
_DLL_CATCH
}


void __stdcall ProfileNode_tie::get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/ {
_DLL_TRY
	EntityBase_tie::make_tie (m_impl->get_entity(), ret_);
_DLL_CATCH
}
void __stdcall ProfileNode_tie::set_entity (IEntityBase_tie* entity) {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);
	m_impl->set_entity(entity_);
_DLL_CATCH
}


void __stdcall ProfileNode_tie::get_first_child (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_first_child(), ret_);
_DLL_CATCH
}


void __stdcall ProfileNode_tie::get_prev (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_prev(), ret_);
_DLL_CATCH
}


void __stdcall ProfileNode_tie::get_next (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_next(), ret_);
_DLL_CATCH
}


void __stdcall ProfileNode_tie::get_parent (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_parent(), ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::add_notifier_45EEB95901C7 (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->add_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall ProfileNode_tie::create_view_ex_45EEB95901C9 (
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

void __stdcall ProfileNode_tie::find_node_45EEB95901D2 (
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

void __stdcall ProfileNode_tie::find_node_path_45EEB95901D4 (
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

void __stdcall ProfileNode_tie::get_by_sibbling_index_45EEB95901D6 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_sibbling_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::get_by_visible_index_45EEB95901D8 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_visible_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::get_first_fit_45EEB95901DA (
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

unsigned long __stdcall ProfileNode_tie::get_flag_count_45EEB95901DC (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_flag_count (flag);
_DLL_CATCH
}

unsigned long __stdcall ProfileNode_tie::get_first_level_children_flag_count_4677A5180213 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_first_level_children_flag_count (flag);
_DLL_CATCH
}

NodeId __stdcall ProfileNode_tie::get_node_id_45EEB95901DE () const {
_DLL_TRY
	return m_impl->get_node_id ();
_DLL_CATCH
}

void __stdcall ProfileNode_tie::set_node_id_45EEB95901DF (
	NodeId id
) {
_DLL_TRY

	m_impl->set_node_id(id);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::get_available_layers_46236D06007D (
	LayerIdList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<LayerIdList> ret = m_impl->get_available_layers();
	LayerIdList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

VisibleIndex __stdcall ProfileNode_tie::get_visible_delta_45EEB95901E1 (
	const INodeBase_tie* node
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	VisibleIndex ret = m_impl->get_visible_delta(node_);
	return ret;
_DLL_CATCH
}

VisibleIndex __stdcall ProfileNode_tie::get_visible_delta_by_entity_45EEB95901E3 (
	const IEntityBase_tie* entity
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);

	VisibleIndex ret = m_impl->get_visible_delta_by_entity(entity_);
	return ret;
_DLL_CATCH
}

VisibleIndex __stdcall ProfileNode_tie::get_index_from_parent_45EEB95901E5 () const {
_DLL_TRY
	return m_impl->get_index_from_parent ();
_DLL_CATCH
}

VisibleIndex __stdcall ProfileNode_tie::get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	return m_impl->get_abs_index ();
_DLL_CATCH
}

void __stdcall ProfileNode_tie::get_child_path_by_abs_index_45EEB95901E7 (
	VisibleIndex index
	, NodeIndexPath_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<NodeIndexPath> ret = m_impl->get_child_path_by_abs_index(index);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::get_frozen_node_4624DEED008C (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_frozen_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::get_unfiltered_node_4625D15D0138 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_unfiltered_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::has_children_45EEB95901EA () const {
_DLL_TRY
	return m_impl->has_children ();
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::has_children_flag_45EEB95901EB (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_children_flag (flag);
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::has_filtered_children_45EEB95901ED () const {
_DLL_TRY
	return m_impl->has_filtered_children ();
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::has_flag_45EEB95901EE (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_flag (flag);
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::has_parent_flag_45EEB95901F0 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_parent_flag (flag);
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::is_first_45EEB95901F2 () const {
_DLL_TRY
	return m_impl->is_first ();
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::is_it_higher_45EEB95901F3 (
	INodeBase_tie* it
) const {
_DLL_TRY
	NodeBase* it_;
	NodeBase_tie::make_cpp(it, it_);

	bool ret = m_impl->is_it_higher(it_);
	return ret;
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::is_last_45EEB95901F5 () const {
_DLL_TRY
	return m_impl->is_last ();
_DLL_CATCH
}

bool __stdcall ProfileNode_tie::is_same_node_45EEB95901F6 (
	INodeBase_tie* node
) const {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	bool ret = m_impl->is_same_node(node_);
	return ret;
_DLL_CATCH
}

void __stdcall ProfileNode_tie::iterate_nodes_45EEB95901F8 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::make_visible_45EEB95901FA () {
_DLL_TRY

	m_impl->make_visible();
_DLL_CATCH
}

void __stdcall ProfileNode_tie::remove_notifier_45EEB95901FB (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->remove_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall ProfileNode_tie::set_all_flag_45EEB95901FD (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag(flag, value);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::set_flag_45EEB9590200 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_flag(flag, value);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::set_range_flag_45EEB9590203 (
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

void __stdcall ProfileNode_tie::delete_nodes_45EEB9590209 (
	FlagMask mask
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY

	m_impl->delete_nodes(mask);
_DLL_CATCH_RETURNED
}

void __stdcall ProfileNode_tie::delete_node_45EEB959020B () {
_DLL_TRY

	m_impl->delete_node();
_DLL_CATCH_RETURNED
}

void __stdcall ProfileNode_tie::copy_nodes_45EEB959020C (
	FlagMask mask
	, INodesClipboard_tie*& ret_
) {
_DLL_TRY

	NodesClipboard* ret = m_impl->copy_nodes(mask);
	NodesClipboard_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::add_last_childs_45EEB959020F (
	INodesClipboard_tie* nodes
) {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_last_childs(nodes_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::add_last_child_45EEB9590211 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_last_child(node_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::add_prev_siblings_45EEB9590213 (
	INodesClipboard_tie* nodes
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_prev_siblings(nodes_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::add_prev_sibling_45EEB9590215 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_prev_sibling(node_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::start_change_transaction_45EEB9590217 () {
_DLL_TRY

	m_impl->start_change_transaction();
_DLL_CATCH
}

void __stdcall ProfileNode_tie::rollback_change_transaction_45EEB9590218 () {
_DLL_TRY

	m_impl->rollback_change_transaction();
_DLL_CATCH
}

void __stdcall ProfileNode_tie::commit_change_transaction_45EEB9590219 () {
_DLL_TRY

	m_impl->commit_change_transaction();
_DLL_CATCH
}

void __stdcall ProfileNode_tie::get_node_by_path_45EEB959021A (
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

void __stdcall ProfileNode_tie::find_45EEB959021C (
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

bool __stdcall ProfileNode_tie::is_relevance_search_supported_45EEB959021F () const {
_DLL_TRY
	return m_impl->is_relevance_search_supported ();
_DLL_CATCH
}

void __stdcall ProfileNode_tie::expand_all_45EEB9590220 (
	bool expand
) {
_DLL_TRY

	m_impl->expand_all(expand);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::iterate_all_nodes_473D89660266 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_all_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::set_all_flag_except_first_children_of_root_children_51EFC4100162 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag_except_first_children_of_root_children(flag, value);
_DLL_CATCH
}

void __stdcall ProfileNode_tie::set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
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
Uid __stdcall ProfileNode_tie::get_uid_465EC3DA036B () const {
_DLL_TRY
	return m_impl->get_uid ();
_DLL_CATCH
}



const ::Core::ComIID UidList_tie::s_com_iid = {0xA75B8B20, 0x685F, 0x4F9B, {0xA3, 0x9F, 0x96, 0x0F, 0x9B, 0x08, 0x69, 0x44}};

unsigned long __stdcall UidList_tie::query_interface (
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

unsigned long __stdcall UidList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall UidList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<UidList_tie* const>(this));
	}
	return counter;
}

void UidList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void UidList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

UidList_tie::UidList_tie () : m_impl(NULL), m_orphan(true) {
}

void UidList_tie::make_cpp (const UidList_tie* obj, UidList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void UidList_tie::new_tie (UidList* obj, UidList_tie*& ret_) {
	Core::Aptr<UidList> obj_aptr (obj);
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

void UidList_tie::make_tie (UidList* obj, UidList_tie*& ret_) {
	Core::Aptr<UidList> obj_aptr (obj);
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
	
void UidList_tie::make_tie (const UidList& obj, UidList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new UidList (obj);
	} else {
		ret_ = NULL;
	}
}

void UidList_tie::make_tie (const UidList& obj, UidList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<UidList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall UidList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall UidList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall UidList_tie::clear () {
	m_impl->clear();
}

void __stdcall UidList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

Uid __stdcall UidList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall UidList_tie::set_item (size_t index, Uid item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall UidList_tie::add (Uid item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall UidList_tie::insert (size_t index, Uid item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID UserManager_tie::s_com_iid = {0xF9017C5B, 0xD7D9, 0x4DD0, {0x8E, 0x29, 0xBD, 0x24, 0xE6, 0xBA, 0x05, 0x1E}};

UserManager_tie::IidRegistrator UserManager_tie::s_iid_registrator;

UserManager_tie::UserManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall UserManager_tie::query_interface (
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
unsigned long __stdcall UserManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall UserManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<UserManager_tie* const>(this));
	}
	return counter;
}

void UserManager_tie::init () {
		m_counter = 1;
	}

void UserManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* UserManager_tie::cast (::Core::IObject* obj) {
	UserManager* ret = dynamic_cast<UserManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IUserManager_tie* ret_ = NULL;
	UserManager_tie::make_tie (ret, ret_);
	return ret_;
}

void UserManager_tie::make_cpp (const IUserManager_tie* obj, UserManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<UserManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void UserManager_tie::make_tie (const UserManager* obj, IUserManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		UserManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<UserManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void UserManager_tie::make_tie (const UserManager& obj, IUserManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	UserManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<UserManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* UserManager_tie::get_impl () const {
	return m_impl;
}

bool __stdcall UserManager_tie::can_create_privileged_user_473DCD910371 () const /*throw (AccessDenied_tie)*/ {
_DLL_TRY
	return m_impl->can_create_privileged_user ();
_DLL_CATCH
}

void __stdcall UserManager_tie::change_group_name_49EF1F8F02B6 (
	Uid uid
	, const char* name
) const /*throw (AccessDenied_tie, CanNotFindData_tie, LoginDuplicate_tie)*/ {
_DLL_TRY

	m_impl->change_group_name(uid, name);
_DLL_CATCH
}

void __stdcall UserManager_tie::change_user_group_49E858400139 (
	Uid user_id
	, Uid group_id
) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ {
_DLL_TRY

	m_impl->change_user_group(user_id, group_id);
_DLL_CATCH
}

void __stdcall UserManager_tie::change_user_info_45EED57B0195 (
	Uid uid
	, const char* name
	, const char* mail
) const /*throw (AccessDenied_tie, CanNotFindData_tie, LicenceViolation_tie, XMLImportRunning_tie)*/ {
_DLL_TRY

	m_impl->change_user_info(uid, name, mail);
_DLL_CATCH_RETURNED
}

void __stdcall UserManager_tie::change_user_password_45EED57B0199 (
	Uid uid
	, const char* password
) const /*throw (AccessDenied_tie, CanNotFindData_tie, WrongAuthentication_tie, LicenceViolation_tie, XMLImportRunning_tie)*/ {
_DLL_TRY

	m_impl->change_user_password(uid, password);
_DLL_CATCH_RETURNED
}

void __stdcall UserManager_tie::change_users_group_49F5595000F7 (
	const UidList_tie* id_list
	, Uid group_id
) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ {
_DLL_TRY
	UidList* id_list_;
	UidList_tie::make_cpp(id_list, id_list_);

	m_impl->change_users_group(*id_list_, group_id);
_DLL_CATCH
}

void __stdcall UserManager_tie::create_group_49C8C2AF03D1 (
	const char* name
) const /*throw (AccessDenied_tie, WrongAuthentication_tie, XMLImportRunning_tie, LoginDuplicate_tie)*/ {
_DLL_TRY

	m_impl->create_group(name);
_DLL_CATCH
}

void __stdcall UserManager_tie::create_user_with_rights_45EED57B018D (
	const char* name
	, const char* login
	, const char* password
	, const char* mail
	, bool can_buy_consulting
	, bool is_privileged
	, Uid group_id
) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, XMLImportRunning_tie, LoginDuplicate_tie, TrialPeriodExpired_tie, NoMorePrivilegedProfiles_tie)*/ {
_DLL_TRY

	m_impl->create_user_with_rights(name, login, password, mail, can_buy_consulting, is_privileged, group_id);
_DLL_CATCH_RETURNED
}

void __stdcall UserManager_tie::delete_group_49C8C58D029D (
	Uid uid
) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ {
_DLL_TRY

	m_impl->delete_group(uid);
_DLL_CATCH
}

void __stdcall UserManager_tie::delete_user_45EED57B0193 (
	Uid uid
) const /*throw (AccessDenied_tie, CanNotFindData_tie, UserActive_tie)*/ {
_DLL_TRY

	m_impl->delete_user(uid);
_DLL_CATCH_RETURNED
}

void __stdcall UserManager_tie::delete_users_4651A57F001F (
	const UidList_tie* list
	, UidList_tie*& ret_
) const /*throw (AccessDenied_tie)*/ {
_DLL_TRY
	UidList* list_;
	UidList_tie::make_cpp(list, list_);

	::Core::Aptr<UidList> ret = m_impl->delete_users(*list_);
	UidList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall UserManager_tie::get_active_users_list_for_net_one_user_version_486CB9E6016C (
	StringList_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<StringList> ret = m_impl->get_active_users_list_for_net_one_user_version();
	StringList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

bool __stdcall UserManager_tie::get_consulting_payment_for_newbies_45EED57B01A6 () const {
_DLL_TRY
	return m_impl->get_consulting_payment_for_newbies ();
_DLL_CATCH
}

void __stdcall UserManager_tie::get_groups_tree_49C8C1B502C0 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_groups_tree();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall UserManager_tie::get_nonsearchable_blocks_for_group_49C8D65B0228 (
	Uid uid
	, NodeIdList_tie*& ret_
) const /*throw (AccessDenied_tie, InternalDatabaseError_tie)*/ {
_DLL_TRY

	::Core::Aptr<NodeIdList> ret = m_impl->get_nonsearchable_blocks_for_group(uid);
	NodeIdList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall UserManager_tie::get_self_profile_45EED57B01A1 (
	IUserProfile_tie*& ret_
) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	UserProfile* ret = m_impl->get_self_profile();
	UserProfile_tie::make_tie(ret, ret_);
_DLL_CATCH_RETURNED
}

void __stdcall UserManager_tie::get_users_tree_49C8C25A00FC (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_users_tree();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall UserManager_tie::has_shared_filters_4E3BC517010A (
	Uid uid
) const {
_DLL_TRY
	return m_impl->has_shared_filters (uid);
_DLL_CATCH
}

bool __stdcall UserManager_tie::is_erasable_4E5F875701F4 (
	Uid uid
) const {
_DLL_TRY
	return m_impl->is_erasable (uid);
_DLL_CATCH
}

void __stdcall UserManager_tie::logout_user_45EED57B019F (
	Uid uid
) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ {
_DLL_TRY

	m_impl->logout_user(uid);
_DLL_CATCH_RETURNED
}

void __stdcall UserManager_tie::logout_users_4651A63100EA (
	const UidList_tie* list
) const /*throw (AccessDenied_tie)*/ {
_DLL_TRY
	UidList* list_;
	UidList_tie::make_cpp(list, list_);

	m_impl->logout_users(*list_);
_DLL_CATCH
}

void __stdcall UserManager_tie::set_consulting_payment_for_all_45EED57B01A2 (
	bool is_allowed
) const /*throw (AccessDenied_tie)*/ {
_DLL_TRY

	m_impl->set_consulting_payment_for_all(is_allowed);
_DLL_CATCH
}

void __stdcall UserManager_tie::set_consulting_payment_for_newbies_45EED57B01A4 (
	bool is_allowed
) const /*throw (AccessDenied_tie)*/ {
_DLL_TRY

	m_impl->set_consulting_payment_for_newbies(is_allowed);
_DLL_CATCH
}

void __stdcall UserManager_tie::set_consulting_rights_4651A670004E (
	const UidList_tie* list
	, bool is_payment_allowed
) const /*throw (AccessDenied_tie, InternalDatabaseError_tie)*/ {
_DLL_TRY
	UidList* list_;
	UidList_tie::make_cpp(list, list_);

	m_impl->set_consulting_rights(*list_, is_payment_allowed);
_DLL_CATCH
}

void __stdcall UserManager_tie::set_erasable_state_4E5F879F0339 (
	Uid uid
	, bool state
) const {
_DLL_TRY

	m_impl->set_erasable_state(uid, state);
_DLL_CATCH
}

void __stdcall UserManager_tie::set_nonsearchable_blocks_for_group_49C8CC1C0238 (
	Uid uid
	, const NodeIdList_tie* blocks_ids
) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ {
_DLL_TRY
	NodeIdList* blocks_ids_;
	NodeIdList_tie::make_cpp(blocks_ids, blocks_ids_);

	m_impl->set_nonsearchable_blocks_for_group(uid, *blocks_ids_);
_DLL_CATCH
}

void __stdcall UserManager_tie::set_privileged_rights_473DC9D20144 (
	const UidList_tie* list
	, bool is_privileged
) const /*throw (AccessDenied_tie, XMLImportRunning_tie, NoMorePrivilegedProfiles_tie)*/ {
_DLL_TRY
	UidList* list_;
	UidList_tie::make_cpp(list, list_);

	m_impl->set_privileged_rights(*list_, is_privileged);
_DLL_CATCH
}

void __stdcall UserManager_tie::set_shared_filters_state_4E3BC5700385 (
	Uid uid
	, bool state
) const {
_DLL_TRY

	m_impl->set_shared_filters_state(uid, state);
_DLL_CATCH
}

void __stdcall UserManager_tie::user_can_buy_consulting_45EED57B019C (
	Uid uid
	, bool is_allowed
) const /*throw (AccessDenied_tie, CanNotFindData_tie, LicenceViolation_tie, XMLImportRunning_tie)*/ {
_DLL_TRY

	m_impl->user_can_buy_consulting(uid, is_allowed);
_DLL_CATCH_RETURNED
}

void __stdcall UserManager_tie::user_is_privileged_473DCA89000A (
	Uid uid
	, bool is_privileged
) const /*throw (AccessDenied_tie, XMLImportRunning_tie, NoMorePrivilegedProfiles_tie)*/ {
_DLL_TRY

	m_impl->user_is_privileged(uid, is_privileged);
_DLL_CATCH
}



const ::Core::ComIID GroupNode_tie::s_com_iid = {0x1EA308E6, 0x3D7C, 0x4A5C, {0xA1, 0xDB, 0x3C, 0xA0, 0x87, 0xF9, 0x40, 0x96}};

GroupNode_tie::IidRegistrator GroupNode_tie::s_iid_registrator;

GroupNode_tie::GroupNode_tie () : m_impl(NULL) {
}

unsigned long __stdcall GroupNode_tie::query_interface (
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
unsigned long __stdcall GroupNode_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall GroupNode_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<GroupNode_tie* const>(this));
	}
	return counter;
}

void GroupNode_tie::init () {
		m_counter = 1;
	}

void GroupNode_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* GroupNode_tie::cast (::Core::IObject* obj) {
	GroupNode* ret = dynamic_cast<GroupNode*>(obj);
	if (ret) {
		ret->addref();
	}
	IGroupNode_tie* ret_ = NULL;
	GroupNode_tie::make_tie (ret, ret_);
	return ret_;
}

void GroupNode_tie::make_cpp (const IGroupNode_tie* obj, GroupNode*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<GroupNode*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void GroupNode_tie::make_tie (const GroupNode* obj, IGroupNode_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		GroupNode_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<GroupNode*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void GroupNode_tie::make_tie (const GroupNode& obj, IGroupNode_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	GroupNode_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<GroupNode*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* GroupNode_tie::get_impl () const {
	return m_impl;
}

void __stdcall GroupNode_tie::save_in_setting_45EECD5D02EF (
	const PropertyID id
) const {
_DLL_TRY

	m_impl->save_in_setting(id);
_DLL_CATCH
}

void __stdcall GroupNode_tie::load_from_setting_45EECD5D02F1 (
	const PropertyID id
	, ISettingEntity_tie*& ret_
) const {
_DLL_TRY

	SettingEntity* ret = m_impl->load_from_setting(id);
	SettingEntity_tie::make_tie(ret, ret_);
_DLL_CATCH
}
void __stdcall GroupNode_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_, this);
_DLL_CATCH
}


long __stdcall GroupNode_tie::get_level () const {
_DLL_TRY
	return m_impl->get_level();
_DLL_CATCH
}


NodeType __stdcall GroupNode_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}
void __stdcall GroupNode_tie::set_type (NodeType type) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	m_impl->set_type(type);
_DLL_CATCH
}


long __stdcall GroupNode_tie::get_child_count () const {
_DLL_TRY
	return m_impl->get_child_count();
_DLL_CATCH
}


bool __stdcall GroupNode_tie::get_is_expanded () const {
_DLL_TRY
	return m_impl->get_is_expanded();
_DLL_CATCH
}


void __stdcall GroupNode_tie::get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/ {
_DLL_TRY
	EntityBase_tie::make_tie (m_impl->get_entity(), ret_);
_DLL_CATCH
}
void __stdcall GroupNode_tie::set_entity (IEntityBase_tie* entity) {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);
	m_impl->set_entity(entity_);
_DLL_CATCH
}


void __stdcall GroupNode_tie::get_first_child (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_first_child(), ret_);
_DLL_CATCH
}


void __stdcall GroupNode_tie::get_prev (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_prev(), ret_);
_DLL_CATCH
}


void __stdcall GroupNode_tie::get_next (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_next(), ret_);
_DLL_CATCH
}


void __stdcall GroupNode_tie::get_parent (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_parent(), ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::add_notifier_45EEB95901C7 (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->add_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall GroupNode_tie::create_view_ex_45EEB95901C9 (
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

void __stdcall GroupNode_tie::find_node_45EEB95901D2 (
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

void __stdcall GroupNode_tie::find_node_path_45EEB95901D4 (
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

void __stdcall GroupNode_tie::get_by_sibbling_index_45EEB95901D6 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_sibbling_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::get_by_visible_index_45EEB95901D8 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_visible_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::get_first_fit_45EEB95901DA (
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

unsigned long __stdcall GroupNode_tie::get_flag_count_45EEB95901DC (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_flag_count (flag);
_DLL_CATCH
}

unsigned long __stdcall GroupNode_tie::get_first_level_children_flag_count_4677A5180213 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_first_level_children_flag_count (flag);
_DLL_CATCH
}

NodeId __stdcall GroupNode_tie::get_node_id_45EEB95901DE () const {
_DLL_TRY
	return m_impl->get_node_id ();
_DLL_CATCH
}

void __stdcall GroupNode_tie::set_node_id_45EEB95901DF (
	NodeId id
) {
_DLL_TRY

	m_impl->set_node_id(id);
_DLL_CATCH
}

void __stdcall GroupNode_tie::get_available_layers_46236D06007D (
	LayerIdList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<LayerIdList> ret = m_impl->get_available_layers();
	LayerIdList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

VisibleIndex __stdcall GroupNode_tie::get_visible_delta_45EEB95901E1 (
	const INodeBase_tie* node
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	VisibleIndex ret = m_impl->get_visible_delta(node_);
	return ret;
_DLL_CATCH
}

VisibleIndex __stdcall GroupNode_tie::get_visible_delta_by_entity_45EEB95901E3 (
	const IEntityBase_tie* entity
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);

	VisibleIndex ret = m_impl->get_visible_delta_by_entity(entity_);
	return ret;
_DLL_CATCH
}

VisibleIndex __stdcall GroupNode_tie::get_index_from_parent_45EEB95901E5 () const {
_DLL_TRY
	return m_impl->get_index_from_parent ();
_DLL_CATCH
}

VisibleIndex __stdcall GroupNode_tie::get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	return m_impl->get_abs_index ();
_DLL_CATCH
}

void __stdcall GroupNode_tie::get_child_path_by_abs_index_45EEB95901E7 (
	VisibleIndex index
	, NodeIndexPath_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<NodeIndexPath> ret = m_impl->get_child_path_by_abs_index(index);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::get_frozen_node_4624DEED008C (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_frozen_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::get_unfiltered_node_4625D15D0138 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_unfiltered_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall GroupNode_tie::has_children_45EEB95901EA () const {
_DLL_TRY
	return m_impl->has_children ();
_DLL_CATCH
}

bool __stdcall GroupNode_tie::has_children_flag_45EEB95901EB (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_children_flag (flag);
_DLL_CATCH
}

bool __stdcall GroupNode_tie::has_filtered_children_45EEB95901ED () const {
_DLL_TRY
	return m_impl->has_filtered_children ();
_DLL_CATCH
}

bool __stdcall GroupNode_tie::has_flag_45EEB95901EE (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_flag (flag);
_DLL_CATCH
}

bool __stdcall GroupNode_tie::has_parent_flag_45EEB95901F0 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_parent_flag (flag);
_DLL_CATCH
}

bool __stdcall GroupNode_tie::is_first_45EEB95901F2 () const {
_DLL_TRY
	return m_impl->is_first ();
_DLL_CATCH
}

bool __stdcall GroupNode_tie::is_it_higher_45EEB95901F3 (
	INodeBase_tie* it
) const {
_DLL_TRY
	NodeBase* it_;
	NodeBase_tie::make_cpp(it, it_);

	bool ret = m_impl->is_it_higher(it_);
	return ret;
_DLL_CATCH
}

bool __stdcall GroupNode_tie::is_last_45EEB95901F5 () const {
_DLL_TRY
	return m_impl->is_last ();
_DLL_CATCH
}

bool __stdcall GroupNode_tie::is_same_node_45EEB95901F6 (
	INodeBase_tie* node
) const {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	bool ret = m_impl->is_same_node(node_);
	return ret;
_DLL_CATCH
}

void __stdcall GroupNode_tie::iterate_nodes_45EEB95901F8 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::make_visible_45EEB95901FA () {
_DLL_TRY

	m_impl->make_visible();
_DLL_CATCH
}

void __stdcall GroupNode_tie::remove_notifier_45EEB95901FB (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->remove_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall GroupNode_tie::set_all_flag_45EEB95901FD (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag(flag, value);
_DLL_CATCH
}

void __stdcall GroupNode_tie::set_flag_45EEB9590200 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_flag(flag, value);
_DLL_CATCH
}

void __stdcall GroupNode_tie::set_range_flag_45EEB9590203 (
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

void __stdcall GroupNode_tie::delete_nodes_45EEB9590209 (
	FlagMask mask
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY

	m_impl->delete_nodes(mask);
_DLL_CATCH_RETURNED
}

void __stdcall GroupNode_tie::delete_node_45EEB959020B () {
_DLL_TRY

	m_impl->delete_node();
_DLL_CATCH_RETURNED
}

void __stdcall GroupNode_tie::copy_nodes_45EEB959020C (
	FlagMask mask
	, INodesClipboard_tie*& ret_
) {
_DLL_TRY

	NodesClipboard* ret = m_impl->copy_nodes(mask);
	NodesClipboard_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::add_last_childs_45EEB959020F (
	INodesClipboard_tie* nodes
) {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_last_childs(nodes_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::add_last_child_45EEB9590211 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_last_child(node_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::add_prev_siblings_45EEB9590213 (
	INodesClipboard_tie* nodes
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_prev_siblings(nodes_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::add_prev_sibling_45EEB9590215 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_prev_sibling(node_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::start_change_transaction_45EEB9590217 () {
_DLL_TRY

	m_impl->start_change_transaction();
_DLL_CATCH
}

void __stdcall GroupNode_tie::rollback_change_transaction_45EEB9590218 () {
_DLL_TRY

	m_impl->rollback_change_transaction();
_DLL_CATCH
}

void __stdcall GroupNode_tie::commit_change_transaction_45EEB9590219 () {
_DLL_TRY

	m_impl->commit_change_transaction();
_DLL_CATCH
}

void __stdcall GroupNode_tie::get_node_by_path_45EEB959021A (
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

void __stdcall GroupNode_tie::find_45EEB959021C (
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

bool __stdcall GroupNode_tie::is_relevance_search_supported_45EEB959021F () const {
_DLL_TRY
	return m_impl->is_relevance_search_supported ();
_DLL_CATCH
}

void __stdcall GroupNode_tie::expand_all_45EEB9590220 (
	bool expand
) {
_DLL_TRY

	m_impl->expand_all(expand);
_DLL_CATCH
}

void __stdcall GroupNode_tie::iterate_all_nodes_473D89660266 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_all_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall GroupNode_tie::set_all_flag_except_first_children_of_root_children_51EFC4100162 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag_except_first_children_of_root_children(flag, value);
_DLL_CATCH
}

void __stdcall GroupNode_tie::set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
_DLL_TRY

	m_impl->set_range_flag_except_first_children_of_root_children(offset_from, offset_to, flag, value, clean_other);
_DLL_CATCH
}Uid __stdcall GroupNode_tie::get_uid_465EC3DA036B () const {
_DLL_TRY
	return m_impl->get_uid ();
_DLL_CATCH
}
bool __stdcall GroupNode_tie::has_users_49EF2092024E () const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ {
_DLL_TRY
	return m_impl->has_users ();
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

