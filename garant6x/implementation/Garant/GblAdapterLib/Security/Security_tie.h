////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Security/Security_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"

namespace GblAdapterLib {

class IUserProfile_tie: public IEntityBase_tie {
public:
	virtual bool __stdcall can_buy_consulting_45EED78501BD () const = 0;

	virtual void __stdcall get_login_45EED78501B7 (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_mail_45EED78501BA (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_name_45EED78501B9 (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual long __stdcall get_uid_45EED78501BB () const = 0;


	virtual const Uid __stdcall get_group_id () const /*throw (AccessDenied_tie)*/ = 0;

	virtual bool __stdcall has_password_45EED78501B8 () const = 0;

	virtual bool __stdcall is_privileged_473DCDF900ED () const = 0;

	virtual bool __stdcall is_system_45EED78501BC () const = 0;
};

class __declspec (dllexport) UserProfile_tie: public IUserProfile_tie {
	SET_OBJECT_COUNTER (UserProfile_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	UserProfile_tie ();

	typedef ::Core::PoolObjectManager<UserProfile_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<UserProfile_tie> Pool;
	friend class ::Core::PoolObjectManager<UserProfile_tie>;
	typedef ::Core::IidMapRegistrator<UserProfile_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IUserProfile_tie* obj, UserProfile*& ret_, bool interface_addref = false);

	static void make_tie (const UserProfile* obj, IUserProfile_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const UserProfile& obj, IUserProfile_tie*& ret_, const Core::TIEBase* owner);

	UserProfile* m_impl;

protected:

	virtual bool __stdcall get_is_saved () const;


	virtual bool __stdcall get_is_changed () const;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/;

	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/;
	virtual bool __stdcall can_buy_consulting_45EED78501BD () const;

	virtual void __stdcall get_login_45EED78501B7 (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_mail_45EED78501BA (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_name_45EED78501B9 (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual long __stdcall get_uid_45EED78501BB () const;


	virtual const Uid __stdcall get_group_id () const /*throw (AccessDenied_tie)*/;

	virtual bool __stdcall has_password_45EED78501B8 () const;

	virtual bool __stdcall is_privileged_473DCDF900ED () const;

	virtual bool __stdcall is_system_45EED78501BC () const;
};

class IUserFilter_tie: public IFilterForTree_tie {
public:

	virtual unsigned long __stdcall get_flags () const = 0;
	virtual void __stdcall set_flags (unsigned long flags) = 0;


	virtual const Uid __stdcall get_group_uid () const = 0;
	virtual void __stdcall set_group_uid (Uid group_uid) = 0;
};

class __declspec (dllexport) UserFilter_tie: public IUserFilter_tie {
	SET_OBJECT_COUNTER (UserFilter_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	UserFilter_tie ();

	typedef ::Core::PoolObjectManager<UserFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<UserFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<UserFilter_tie>;
	typedef ::Core::IidMapRegistrator<UserFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IUserFilter_tie* obj, UserFilter*& ret_, bool interface_addref = false);

	static void make_tie (const UserFilter* obj, IUserFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const UserFilter& obj, IUserFilter_tie*& ret_, const Core::TIEBase* owner);

	UserFilter* m_impl;

protected:

	virtual unsigned long __stdcall get_flags () const;
	virtual void __stdcall set_flags (unsigned long flags);


	virtual const Uid __stdcall get_group_uid () const;
	virtual void __stdcall set_group_uid (Uid group_uid);
};

class IProfileNode_tie: public INodeBase_tie {
public:
	virtual Uid __stdcall get_uid_465EC3DA036B () const = 0;
};

class __declspec (dllexport) ProfileNode_tie: public IProfileNode_tie {
	SET_OBJECT_COUNTER (ProfileNode_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ProfileNode_tie ();

	typedef ::Core::PoolObjectManager<ProfileNode_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ProfileNode_tie> Pool;
	friend class ::Core::PoolObjectManager<ProfileNode_tie>;
	typedef ::Core::IidMapRegistrator<ProfileNode_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IProfileNode_tie* obj, ProfileNode*& ret_, bool interface_addref = false);

	static void make_tie (const ProfileNode* obj, IProfileNode_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ProfileNode& obj, IProfileNode_tie*& ret_, const Core::TIEBase* owner);

	ProfileNode* m_impl;

protected:
	virtual void __stdcall save_in_setting_45EECD5D02EF (
		const PropertyID id
	) const;

	virtual void __stdcall load_from_setting_45EECD5D02F1 (
		const PropertyID id
		, ISettingEntity_tie*& ret_
	) const;
	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_);


	virtual long __stdcall get_level () const;


	virtual NodeType __stdcall get_type () const;
	virtual void __stdcall set_type (NodeType type) /*throw (ConstantModify_tie)*/;


	virtual long __stdcall get_child_count () const;


	virtual bool __stdcall get_is_expanded () const;


	virtual void __stdcall get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/;
	virtual void __stdcall set_entity (IEntityBase_tie* entity);


	virtual void __stdcall get_first_child (INodeBase_tie*& ret_);


	virtual void __stdcall get_prev (INodeBase_tie*& ret_);


	virtual void __stdcall get_next (INodeBase_tie*& ret_);


	virtual void __stdcall get_parent (INodeBase_tie*& ret_);

	virtual void __stdcall add_notifier_45EEB95901C7 (
		INodeNotifier_tie* notifier
	);

	virtual void __stdcall create_view_ex_45EEB95901C9 (
		const FilterList_tie* filter
		, FlagMask shared_flags
		, const INodeBase_tie* sync_node
		, VisibleIndex& sync_index
		, unsigned long levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall find_node_45EEB95901D2 (
		const INodeBase_tie* node_to_find
		, INodeBase_tie*& ret_
	) const;

	virtual void __stdcall find_node_path_45EEB95901D4 (
		INodeBase_tie* node_to_find
		, NodeIndexPath_tie*& ret_
	) const;

	virtual void __stdcall get_by_sibbling_index_45EEB95901D6 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall get_by_visible_index_45EEB95901D8 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall get_first_fit_45EEB95901DA (
		const FilterList_tie* filter
		, NodeIndexPath_tie*& ret_
	) const;

	virtual unsigned long __stdcall get_flag_count_45EEB95901DC (
		FlagMask flag
	) const;

	virtual unsigned long __stdcall get_first_level_children_flag_count_4677A5180213 (
		FlagMask flag
	) const;

	virtual NodeId __stdcall get_node_id_45EEB95901DE () const;

	virtual void __stdcall set_node_id_45EEB95901DF (
		NodeId id
	);

	virtual void __stdcall get_available_layers_46236D06007D (
		LayerIdList_tie*& ret_
	) const;

	virtual VisibleIndex __stdcall get_visible_delta_45EEB95901E1 (
		const INodeBase_tie* node
	) const /*throw (NotFound_tie)*/;

	virtual VisibleIndex __stdcall get_visible_delta_by_entity_45EEB95901E3 (
		const IEntityBase_tie* entity
	) const /*throw (NotFound_tie)*/;

	virtual VisibleIndex __stdcall get_index_from_parent_45EEB95901E5 () const;

	virtual VisibleIndex __stdcall get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_child_path_by_abs_index_45EEB95901E7 (
		VisibleIndex index
		, NodeIndexPath_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_frozen_node_4624DEED008C (
		INodeBase_tie*& ret_
	) const;

	virtual void __stdcall get_unfiltered_node_4625D15D0138 (
		INodeBase_tie*& ret_
	) const;

	virtual bool __stdcall has_children_45EEB95901EA () const;

	virtual bool __stdcall has_children_flag_45EEB95901EB (
		FlagMask flag
	) const;

	virtual bool __stdcall has_filtered_children_45EEB95901ED () const;

	virtual bool __stdcall has_flag_45EEB95901EE (
		FlagMask flag
	) const;

	virtual bool __stdcall has_parent_flag_45EEB95901F0 (
		FlagMask flag
	) const;

	virtual bool __stdcall is_first_45EEB95901F2 () const;

	virtual bool __stdcall is_it_higher_45EEB95901F3 (
		INodeBase_tie* it
	) const;

	virtual bool __stdcall is_last_45EEB95901F5 () const;

	virtual bool __stdcall is_same_node_45EEB95901F6 (
		INodeBase_tie* node
	) const;

	virtual void __stdcall iterate_nodes_45EEB95901F8 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	);

	virtual void __stdcall make_visible_45EEB95901FA ();

	virtual void __stdcall remove_notifier_45EEB95901FB (
		INodeNotifier_tie* notifier
	);

	virtual void __stdcall set_all_flag_45EEB95901FD (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_flag_45EEB9590200 (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_range_flag_45EEB9590203 (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	virtual void __stdcall delete_nodes_45EEB9590209 (
		FlagMask mask
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall delete_node_45EEB959020B ();

	virtual void __stdcall copy_nodes_45EEB959020C (
		FlagMask mask
		, INodesClipboard_tie*& ret_
	);

	virtual void __stdcall add_last_childs_45EEB959020F (
		INodesClipboard_tie* nodes
	);

	virtual void __stdcall add_last_child_45EEB9590211 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall add_prev_siblings_45EEB9590213 (
		INodesClipboard_tie* nodes
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall add_prev_sibling_45EEB9590215 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall start_change_transaction_45EEB9590217 ();

	virtual void __stdcall rollback_change_transaction_45EEB9590218 ();

	virtual void __stdcall commit_change_transaction_45EEB9590219 ();

	virtual void __stdcall get_node_by_path_45EEB959021A (
		const NodeIndexPath_tie* path
		, INodeBase_tie*& ret_
	) const /*throw (NotFound_tie)*/;

	virtual void __stdcall find_45EEB959021C (
		const FilterList_tie* filter
		, const NodePosition_tie& find_from
		, IFindIterator_tie*& ret_
	) const;

	virtual bool __stdcall is_relevance_search_supported_45EEB959021F () const;

	virtual void __stdcall expand_all_45EEB9590220 (
		bool expand
	);

	virtual void __stdcall iterate_all_nodes_473D89660266 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	);

	virtual void __stdcall set_all_flag_except_first_children_of_root_children_51EFC4100162 (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);
	virtual Uid __stdcall get_uid_465EC3DA036B () const;
};

class UidList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (UidList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	UidList_tie ();

	typedef ::Core::PoolObjectManager<UidList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<UidList_tie> Pool;
	friend class ::Core::PoolObjectManager<UidList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const UidList_tie* obj, UidList*& ret_);

	static void make_tie (UidList* obj, UidList_tie*& ret_);
	
	static void make_tie (const UidList& obj, UidList_tie*& ret_);

	static void make_tie (const UidList& obj, UidList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (UidList* obj, UidList_tie*& ret_);

	UidList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual Uid __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, Uid item);
	virtual size_t __stdcall add (Uid item);
	virtual size_t __stdcall insert (size_t index, Uid item);
};

class IUserManager_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall can_create_privileged_user_473DCD910371 () const /*throw (AccessDenied_tie)*/ = 0;

	virtual void __stdcall change_group_name_49EF1F8F02B6 (
		Uid uid
		, const char* name
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, LoginDuplicate_tie)*/ = 0;

	virtual void __stdcall change_user_group_49E858400139 (
		Uid user_id
		, Uid group_id
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ = 0;

	virtual void __stdcall change_user_info_45EED57B0195 (
		Uid uid
		, const char* name
		, const char* mail
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, LicenceViolation_tie, XMLImportRunning_tie)*/ = 0;

	virtual void __stdcall change_user_password_45EED57B0199 (
		Uid uid
		, const char* password
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, WrongAuthentication_tie, LicenceViolation_tie, XMLImportRunning_tie)*/ = 0;

	virtual void __stdcall change_users_group_49F5595000F7 (
		const UidList_tie* id_list
		, Uid group_id
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ = 0;

	virtual void __stdcall create_group_49C8C2AF03D1 (
		const char* name
	) const /*throw (AccessDenied_tie, WrongAuthentication_tie, XMLImportRunning_tie, LoginDuplicate_tie)*/ = 0;

	virtual void __stdcall create_user_with_rights_45EED57B018D (
		const char* name
		, const char* login
		, const char* password
		, const char* mail
		, bool can_buy_consulting
		, bool is_privileged
		, Uid group_id
	) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, XMLImportRunning_tie, LoginDuplicate_tie, TrialPeriodExpired_tie, NoMorePrivilegedProfiles_tie)*/ = 0;

	virtual void __stdcall delete_group_49C8C58D029D (
		Uid uid
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ = 0;

	virtual void __stdcall delete_user_45EED57B0193 (
		Uid uid
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, UserActive_tie)*/ = 0;

	virtual void __stdcall delete_users_4651A57F001F (
		const UidList_tie* list
		, UidList_tie*& ret_
	) const /*throw (AccessDenied_tie)*/ = 0;

	virtual void __stdcall get_active_users_list_for_net_one_user_version_486CB9E6016C (
		StringList_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual bool __stdcall get_consulting_payment_for_newbies_45EED57B01A6 () const = 0;

	virtual void __stdcall get_groups_tree_49C8C1B502C0 (
		INodeBase_tie*& ret_
	) const = 0;

	virtual void __stdcall get_nonsearchable_blocks_for_group_49C8D65B0228 (
		Uid uid
		, NodeIdList_tie*& ret_
	) const /*throw (AccessDenied_tie, InternalDatabaseError_tie)*/ = 0;

	virtual void __stdcall get_self_profile_45EED57B01A1 (
		IUserProfile_tie*& ret_
	) /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_users_tree_49C8C25A00FC (
		INodeBase_tie*& ret_
	) const = 0;

	virtual bool __stdcall has_shared_filters_4E3BC517010A (
		Uid uid
	) const = 0;

	virtual bool __stdcall is_erasable_4E5F875701F4 (
		Uid uid
	) const = 0;

	virtual void __stdcall logout_user_45EED57B019F (
		Uid uid
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ = 0;

	virtual void __stdcall logout_users_4651A63100EA (
		const UidList_tie* list
	) const /*throw (AccessDenied_tie)*/ = 0;

	virtual void __stdcall set_consulting_payment_for_all_45EED57B01A2 (
		bool is_allowed
	) const /*throw (AccessDenied_tie)*/ = 0;

	virtual void __stdcall set_consulting_payment_for_newbies_45EED57B01A4 (
		bool is_allowed
	) const /*throw (AccessDenied_tie)*/ = 0;

	virtual void __stdcall set_consulting_rights_4651A670004E (
		const UidList_tie* list
		, bool is_payment_allowed
	) const /*throw (AccessDenied_tie, InternalDatabaseError_tie)*/ = 0;

	virtual void __stdcall set_erasable_state_4E5F879F0339 (
		Uid uid
		, bool state
	) const = 0;

	virtual void __stdcall set_nonsearchable_blocks_for_group_49C8CC1C0238 (
		Uid uid
		, const NodeIdList_tie* blocks_ids
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ = 0;

	virtual void __stdcall set_privileged_rights_473DC9D20144 (
		const UidList_tie* list
		, bool is_privileged
	) const /*throw (AccessDenied_tie, XMLImportRunning_tie, NoMorePrivilegedProfiles_tie)*/ = 0;

	virtual void __stdcall set_shared_filters_state_4E3BC5700385 (
		Uid uid
		, bool state
	) const = 0;

	virtual void __stdcall user_can_buy_consulting_45EED57B019C (
		Uid uid
		, bool is_allowed
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, LicenceViolation_tie, XMLImportRunning_tie)*/ = 0;

	virtual void __stdcall user_is_privileged_473DCA89000A (
		Uid uid
		, bool is_privileged
	) const /*throw (AccessDenied_tie, XMLImportRunning_tie, NoMorePrivilegedProfiles_tie)*/ = 0;
};

class __declspec (dllexport) UserManager_tie: public IUserManager_tie {
	SET_OBJECT_COUNTER (UserManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	UserManager_tie ();

	typedef ::Core::PoolObjectManager<UserManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<UserManager_tie> Pool;
	friend class ::Core::PoolObjectManager<UserManager_tie>;
	typedef ::Core::IidMapRegistrator<UserManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IUserManager_tie* obj, UserManager*& ret_, bool interface_addref = false);

	static void make_tie (const UserManager* obj, IUserManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const UserManager& obj, IUserManager_tie*& ret_, const Core::TIEBase* owner);

	UserManager* m_impl;

protected:
	virtual bool __stdcall can_create_privileged_user_473DCD910371 () const /*throw (AccessDenied_tie)*/;

	virtual void __stdcall change_group_name_49EF1F8F02B6 (
		Uid uid
		, const char* name
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, LoginDuplicate_tie)*/;

	virtual void __stdcall change_user_group_49E858400139 (
		Uid user_id
		, Uid group_id
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/;

	virtual void __stdcall change_user_info_45EED57B0195 (
		Uid uid
		, const char* name
		, const char* mail
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, LicenceViolation_tie, XMLImportRunning_tie)*/;

	virtual void __stdcall change_user_password_45EED57B0199 (
		Uid uid
		, const char* password
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, WrongAuthentication_tie, LicenceViolation_tie, XMLImportRunning_tie)*/;

	virtual void __stdcall change_users_group_49F5595000F7 (
		const UidList_tie* id_list
		, Uid group_id
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/;

	virtual void __stdcall create_group_49C8C2AF03D1 (
		const char* name
	) const /*throw (AccessDenied_tie, WrongAuthentication_tie, XMLImportRunning_tie, LoginDuplicate_tie)*/;

	virtual void __stdcall create_user_with_rights_45EED57B018D (
		const char* name
		, const char* login
		, const char* password
		, const char* mail
		, bool can_buy_consulting
		, bool is_privileged
		, Uid group_id
	) const /*throw (WrongAuthentication_tie, NoMoreProfiles_tie, XMLImportRunning_tie, LoginDuplicate_tie, TrialPeriodExpired_tie, NoMorePrivilegedProfiles_tie)*/;

	virtual void __stdcall delete_group_49C8C58D029D (
		Uid uid
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/;

	virtual void __stdcall delete_user_45EED57B0193 (
		Uid uid
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, UserActive_tie)*/;

	virtual void __stdcall delete_users_4651A57F001F (
		const UidList_tie* list
		, UidList_tie*& ret_
	) const /*throw (AccessDenied_tie)*/;

	virtual void __stdcall get_active_users_list_for_net_one_user_version_486CB9E6016C (
		StringList_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual bool __stdcall get_consulting_payment_for_newbies_45EED57B01A6 () const;

	virtual void __stdcall get_groups_tree_49C8C1B502C0 (
		INodeBase_tie*& ret_
	) const;

	virtual void __stdcall get_nonsearchable_blocks_for_group_49C8D65B0228 (
		Uid uid
		, NodeIdList_tie*& ret_
	) const /*throw (AccessDenied_tie, InternalDatabaseError_tie)*/;

	virtual void __stdcall get_self_profile_45EED57B01A1 (
		IUserProfile_tie*& ret_
	) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_users_tree_49C8C25A00FC (
		INodeBase_tie*& ret_
	) const;

	virtual bool __stdcall has_shared_filters_4E3BC517010A (
		Uid uid
	) const;

	virtual bool __stdcall is_erasable_4E5F875701F4 (
		Uid uid
	) const;

	virtual void __stdcall logout_user_45EED57B019F (
		Uid uid
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/;

	virtual void __stdcall logout_users_4651A63100EA (
		const UidList_tie* list
	) const /*throw (AccessDenied_tie)*/;

	virtual void __stdcall set_consulting_payment_for_all_45EED57B01A2 (
		bool is_allowed
	) const /*throw (AccessDenied_tie)*/;

	virtual void __stdcall set_consulting_payment_for_newbies_45EED57B01A4 (
		bool is_allowed
	) const /*throw (AccessDenied_tie)*/;

	virtual void __stdcall set_consulting_rights_4651A670004E (
		const UidList_tie* list
		, bool is_payment_allowed
	) const /*throw (AccessDenied_tie, InternalDatabaseError_tie)*/;

	virtual void __stdcall set_erasable_state_4E5F879F0339 (
		Uid uid
		, bool state
	) const;

	virtual void __stdcall set_nonsearchable_blocks_for_group_49C8CC1C0238 (
		Uid uid
		, const NodeIdList_tie* blocks_ids
	) const /*throw (AccessDenied_tie, CanNotFindData_tie)*/;

	virtual void __stdcall set_privileged_rights_473DC9D20144 (
		const UidList_tie* list
		, bool is_privileged
	) const /*throw (AccessDenied_tie, XMLImportRunning_tie, NoMorePrivilegedProfiles_tie)*/;

	virtual void __stdcall set_shared_filters_state_4E3BC5700385 (
		Uid uid
		, bool state
	) const;

	virtual void __stdcall user_can_buy_consulting_45EED57B019C (
		Uid uid
		, bool is_allowed
	) const /*throw (AccessDenied_tie, CanNotFindData_tie, LicenceViolation_tie, XMLImportRunning_tie)*/;

	virtual void __stdcall user_is_privileged_473DCA89000A (
		Uid uid
		, bool is_privileged
	) const /*throw (AccessDenied_tie, XMLImportRunning_tie, NoMorePrivilegedProfiles_tie)*/;
};

class IGroupNode_tie: public IProfileNode_tie {
public:
	virtual bool __stdcall has_users_49EF2092024E () const /*throw (AccessDenied_tie, CanNotFindData_tie)*/ = 0;
};

class __declspec (dllexport) GroupNode_tie: public IGroupNode_tie {
	SET_OBJECT_COUNTER (GroupNode_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	GroupNode_tie ();

	typedef ::Core::PoolObjectManager<GroupNode_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<GroupNode_tie> Pool;
	friend class ::Core::PoolObjectManager<GroupNode_tie>;
	typedef ::Core::IidMapRegistrator<GroupNode_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IGroupNode_tie* obj, GroupNode*& ret_, bool interface_addref = false);

	static void make_tie (const GroupNode* obj, IGroupNode_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const GroupNode& obj, IGroupNode_tie*& ret_, const Core::TIEBase* owner);

	GroupNode* m_impl;

protected:
	virtual void __stdcall save_in_setting_45EECD5D02EF (
		const PropertyID id
	) const;

	virtual void __stdcall load_from_setting_45EECD5D02F1 (
		const PropertyID id
		, ISettingEntity_tie*& ret_
	) const;
	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_);


	virtual long __stdcall get_level () const;


	virtual NodeType __stdcall get_type () const;
	virtual void __stdcall set_type (NodeType type) /*throw (ConstantModify_tie)*/;


	virtual long __stdcall get_child_count () const;


	virtual bool __stdcall get_is_expanded () const;


	virtual void __stdcall get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/;
	virtual void __stdcall set_entity (IEntityBase_tie* entity);


	virtual void __stdcall get_first_child (INodeBase_tie*& ret_);


	virtual void __stdcall get_prev (INodeBase_tie*& ret_);


	virtual void __stdcall get_next (INodeBase_tie*& ret_);


	virtual void __stdcall get_parent (INodeBase_tie*& ret_);

	virtual void __stdcall add_notifier_45EEB95901C7 (
		INodeNotifier_tie* notifier
	);

	virtual void __stdcall create_view_ex_45EEB95901C9 (
		const FilterList_tie* filter
		, FlagMask shared_flags
		, const INodeBase_tie* sync_node
		, VisibleIndex& sync_index
		, unsigned long levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall find_node_45EEB95901D2 (
		const INodeBase_tie* node_to_find
		, INodeBase_tie*& ret_
	) const;

	virtual void __stdcall find_node_path_45EEB95901D4 (
		INodeBase_tie* node_to_find
		, NodeIndexPath_tie*& ret_
	) const;

	virtual void __stdcall get_by_sibbling_index_45EEB95901D6 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall get_by_visible_index_45EEB95901D8 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall get_first_fit_45EEB95901DA (
		const FilterList_tie* filter
		, NodeIndexPath_tie*& ret_
	) const;

	virtual unsigned long __stdcall get_flag_count_45EEB95901DC (
		FlagMask flag
	) const;

	virtual unsigned long __stdcall get_first_level_children_flag_count_4677A5180213 (
		FlagMask flag
	) const;

	virtual NodeId __stdcall get_node_id_45EEB95901DE () const;

	virtual void __stdcall set_node_id_45EEB95901DF (
		NodeId id
	);

	virtual void __stdcall get_available_layers_46236D06007D (
		LayerIdList_tie*& ret_
	) const;

	virtual VisibleIndex __stdcall get_visible_delta_45EEB95901E1 (
		const INodeBase_tie* node
	) const /*throw (NotFound_tie)*/;

	virtual VisibleIndex __stdcall get_visible_delta_by_entity_45EEB95901E3 (
		const IEntityBase_tie* entity
	) const /*throw (NotFound_tie)*/;

	virtual VisibleIndex __stdcall get_index_from_parent_45EEB95901E5 () const;

	virtual VisibleIndex __stdcall get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_child_path_by_abs_index_45EEB95901E7 (
		VisibleIndex index
		, NodeIndexPath_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_frozen_node_4624DEED008C (
		INodeBase_tie*& ret_
	) const;

	virtual void __stdcall get_unfiltered_node_4625D15D0138 (
		INodeBase_tie*& ret_
	) const;

	virtual bool __stdcall has_children_45EEB95901EA () const;

	virtual bool __stdcall has_children_flag_45EEB95901EB (
		FlagMask flag
	) const;

	virtual bool __stdcall has_filtered_children_45EEB95901ED () const;

	virtual bool __stdcall has_flag_45EEB95901EE (
		FlagMask flag
	) const;

	virtual bool __stdcall has_parent_flag_45EEB95901F0 (
		FlagMask flag
	) const;

	virtual bool __stdcall is_first_45EEB95901F2 () const;

	virtual bool __stdcall is_it_higher_45EEB95901F3 (
		INodeBase_tie* it
	) const;

	virtual bool __stdcall is_last_45EEB95901F5 () const;

	virtual bool __stdcall is_same_node_45EEB95901F6 (
		INodeBase_tie* node
	) const;

	virtual void __stdcall iterate_nodes_45EEB95901F8 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	);

	virtual void __stdcall make_visible_45EEB95901FA ();

	virtual void __stdcall remove_notifier_45EEB95901FB (
		INodeNotifier_tie* notifier
	);

	virtual void __stdcall set_all_flag_45EEB95901FD (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_flag_45EEB9590200 (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_range_flag_45EEB9590203 (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	virtual void __stdcall delete_nodes_45EEB9590209 (
		FlagMask mask
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall delete_node_45EEB959020B ();

	virtual void __stdcall copy_nodes_45EEB959020C (
		FlagMask mask
		, INodesClipboard_tie*& ret_
	);

	virtual void __stdcall add_last_childs_45EEB959020F (
		INodesClipboard_tie* nodes
	);

	virtual void __stdcall add_last_child_45EEB9590211 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall add_prev_siblings_45EEB9590213 (
		INodesClipboard_tie* nodes
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall add_prev_sibling_45EEB9590215 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall start_change_transaction_45EEB9590217 ();

	virtual void __stdcall rollback_change_transaction_45EEB9590218 ();

	virtual void __stdcall commit_change_transaction_45EEB9590219 ();

	virtual void __stdcall get_node_by_path_45EEB959021A (
		const NodeIndexPath_tie* path
		, INodeBase_tie*& ret_
	) const /*throw (NotFound_tie)*/;

	virtual void __stdcall find_45EEB959021C (
		const FilterList_tie* filter
		, const NodePosition_tie& find_from
		, IFindIterator_tie*& ret_
	) const;

	virtual bool __stdcall is_relevance_search_supported_45EEB959021F () const;

	virtual void __stdcall expand_all_45EEB9590220 (
		bool expand
	);

	virtual void __stdcall iterate_all_nodes_473D89660266 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	);

	virtual void __stdcall set_all_flag_except_first_children_of_root_children_51EFC4100162 (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);	virtual Uid __stdcall get_uid_465EC3DA036B () const;
	virtual bool __stdcall has_users_49EF2092024E () const /*throw (AccessDenied_tie, CanNotFindData_tie)*/;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

