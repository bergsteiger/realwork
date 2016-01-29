////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DocTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.h"

namespace GblAdapterLib {

class IDocNodeFilter_tie: public IFilterForTree_tie {
public:

	virtual TagHandle __stdcall get_id () const = 0;
	virtual void __stdcall set_id (TagHandle id) = 0;


	virtual bool __stdcall get_inheritable () const = 0;
	virtual void __stdcall set_inheritable (bool inheritable) = 0;


	virtual NodeType __stdcall get_type () const = 0;
	virtual void __stdcall set_type (NodeType type) = 0;
};

class __declspec (dllexport) DocNodeFilter_tie: public IDocNodeFilter_tie {
	SET_OBJECT_COUNTER (DocNodeFilter_tie)
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
	DocNodeFilter_tie ();

	typedef ::Core::PoolObjectManager<DocNodeFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DocNodeFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<DocNodeFilter_tie>;
	typedef ::Core::IidMapRegistrator<DocNodeFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDocNodeFilter_tie* obj, DocNodeFilter*& ret_, bool interface_addref = false);

	static void make_tie (const DocNodeFilter* obj, IDocNodeFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DocNodeFilter& obj, IDocNodeFilter_tie*& ret_, const Core::TIEBase* owner);

	DocNodeFilter* m_impl;

protected:

	virtual TagHandle __stdcall get_id () const;
	virtual void __stdcall set_id (TagHandle id);


	virtual bool __stdcall get_inheritable () const;
	virtual void __stdcall set_inheritable (bool inheritable);


	virtual NodeType __stdcall get_type () const;
	virtual void __stdcall set_type (NodeType type);
};

class IContentsNode_tie: public INodeBase_tie {
public:

};

class __declspec (dllexport) ContentsNode_tie: public IContentsNode_tie {
	SET_OBJECT_COUNTER (ContentsNode_tie)
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
	ContentsNode_tie ();

	typedef ::Core::PoolObjectManager<ContentsNode_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ContentsNode_tie> Pool;
	friend class ::Core::PoolObjectManager<ContentsNode_tie>;
	typedef ::Core::IidMapRegistrator<ContentsNode_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IContentsNode_tie* obj, ContentsNode*& ret_, bool interface_addref = false);

	static void make_tie (const ContentsNode* obj, IContentsNode_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ContentsNode& obj, IContentsNode_tie*& ret_, const Core::TIEBase* owner);

	ContentsNode* m_impl;

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

};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

