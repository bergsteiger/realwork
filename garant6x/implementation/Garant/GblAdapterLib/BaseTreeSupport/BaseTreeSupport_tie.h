////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// Поддержка старого дерева.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport_tie.h"

namespace GblAdapterLib {

class INode_tie: public IEntityStorage_tie {
public:
	virtual void __stdcall add_child_node_456FE63B01DE (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/ = 0;

	virtual void __stdcall add_sibling_node_456FE63B01E0 (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, Unsupported_tie, DuplicateNode_tie)*/ = 0;


	virtual long __stdcall get_all_child_count () const = 0;

	virtual bool __stdcall can_copy_456FE63B01E7 () const = 0;

	virtual bool __stdcall can_insert_456FE63B01E8 (
		INode_tie* source
	) const = 0;

	virtual bool __stdcall can_modify_4AA55863036D () const = 0;

	virtual bool __stdcall can_move_456FE63B01E6 () const = 0;


	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_caption (GCI::IO::IString_tie* caption) /*throw (ConstantModify_tie, AccessDenied_tie)*/ = 0;


	virtual long __stdcall get_child_count () const = 0;

	virtual void __stdcall copy_to_location_456FE63B01E4 (
		INode_tie* destination
	) /*throw (CopyDisabled_tie, InvalidContainer_tie)*/ = 0;

	virtual void __stdcall delete_node_456FE63B01DD () /*throw (ConstantModify_tie, AccessDenied_tie, EmptyResult_tie)*/ = 0;


	virtual long __stdcall get_flags () const = 0;

	virtual void __stdcall get_child_456FE63B01D6 (
		long index
		, INode_tie*& ret_
	) /*throw (InvalidIndex_tie)*/ = 0;

	virtual bool __stdcall has_child_456FE63B01EC () const = 0;


	virtual void __stdcall get_hint (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_hint (GCI::IO::IString_tie* hint) /*throw (ConstantModify_tie, AccessDenied_tie)*/ = 0;


	virtual long __stdcall get_index () const = 0;

	virtual bool __stdcall is_first_456FE63B01EB () const = 0;

	virtual bool __stdcall is_last_456FE63B01EA () const = 0;

	virtual bool __stdcall is_same_node_456FE63B01D9 (
		const INode_tie* node
	) const = 0;


	virtual long __stdcall get_level () const = 0;

	virtual void __stdcall move_to_location_456FE63B01E2 (
		INode_tie* destination
	) /*throw (InvalidContainer_tie, MoveDisabled_tie)*/ = 0;


	virtual void __stdcall get_next_node (INode_tie*& ret_) = 0;


	virtual EntityType __stdcall get_object_type () const /*throw (Unsupported_tie)*/ = 0;

	virtual void __stdcall open_456FE63B01DB (
		Core::IIObject_tie*& ret_
	) /*throw (CanNotFindData_tie, NotEntityElement_tie)*/ = 0;

	virtual void __stdcall override_child_node_456FE63B01ED (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/ = 0;


	virtual void __stdcall get_parent (INode_tie*& ret_) = 0;


	virtual void __stdcall get_previous_node (INode_tie*& ret_) = 0;


	virtual long __stdcall get_through_index () const = 0;
};

class __declspec (dllexport) Node_tie: public INode_tie {
	SET_OBJECT_COUNTER (Node_tie)
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
	Node_tie ();

	typedef ::Core::PoolObjectManager<Node_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Node_tie> Pool;
	friend class ::Core::PoolObjectManager<Node_tie>;
	typedef ::Core::IidMapRegistrator<Node_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INode_tie* obj, Node*& ret_, bool interface_addref = false);

	static void make_tie (const Node* obj, INode_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Node& obj, INode_tie*& ret_, const Core::TIEBase* owner);

	Node* m_impl;

protected:
	virtual void __stdcall add_child_node_456FE63B01DE (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/;

	virtual void __stdcall add_sibling_node_456FE63B01E0 (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, Unsupported_tie, DuplicateNode_tie)*/;


	virtual long __stdcall get_all_child_count () const;

	virtual bool __stdcall can_copy_456FE63B01E7 () const;

	virtual bool __stdcall can_insert_456FE63B01E8 (
		INode_tie* source
	) const;

	virtual bool __stdcall can_modify_4AA55863036D () const;

	virtual bool __stdcall can_move_456FE63B01E6 () const;


	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_caption (GCI::IO::IString_tie* caption) /*throw (ConstantModify_tie, AccessDenied_tie)*/;


	virtual long __stdcall get_child_count () const;

	virtual void __stdcall copy_to_location_456FE63B01E4 (
		INode_tie* destination
	) /*throw (CopyDisabled_tie, InvalidContainer_tie)*/;

	virtual void __stdcall delete_node_456FE63B01DD () /*throw (ConstantModify_tie, AccessDenied_tie, EmptyResult_tie)*/;


	virtual long __stdcall get_flags () const;

	virtual void __stdcall get_child_456FE63B01D6 (
		long index
		, INode_tie*& ret_
	) /*throw (InvalidIndex_tie)*/;

	virtual bool __stdcall has_child_456FE63B01EC () const;


	virtual void __stdcall get_hint (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_hint (GCI::IO::IString_tie* hint) /*throw (ConstantModify_tie, AccessDenied_tie)*/;


	virtual long __stdcall get_index () const;

	virtual bool __stdcall is_first_456FE63B01EB () const;

	virtual bool __stdcall is_last_456FE63B01EA () const;

	virtual bool __stdcall is_same_node_456FE63B01D9 (
		const INode_tie* node
	) const;


	virtual long __stdcall get_level () const;

	virtual void __stdcall move_to_location_456FE63B01E2 (
		INode_tie* destination
	) /*throw (InvalidContainer_tie, MoveDisabled_tie)*/;


	virtual void __stdcall get_next_node (INode_tie*& ret_);


	virtual EntityType __stdcall get_object_type () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall open_456FE63B01DB (
		Core::IIObject_tie*& ret_
	) /*throw (CanNotFindData_tie, NotEntityElement_tie)*/;

	virtual void __stdcall override_child_node_456FE63B01ED (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/;


	virtual void __stdcall get_parent (INode_tie*& ret_);


	virtual void __stdcall get_previous_node (INode_tie*& ret_);


	virtual long __stdcall get_through_index () const;
};

class IBaseCatalog_tie: public ::Core::IIObject_tie {
public:

	virtual const EntityType __stdcall get_filter () const = 0;
	virtual void __stdcall set_filter (EntityType filter) = 0;

	virtual void __stdcall find_456FEA67007E (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const = 0;

	virtual void __stdcall find_context_456FEA670080 (
		const char* mask
		, const SearchMode& mode
		, const INode_tie* cur_item
		, ContextSearchResult_tie& result
		, INode_tie*& ret_
	) const = 0;

	virtual void __stdcall reset_type_filter_456FEA670085 () const = 0;


	virtual void __stdcall get_root (INode_tie*& ret_) = 0;
};

class __declspec (dllexport) BaseCatalog_tie: public IBaseCatalog_tie {
	SET_OBJECT_COUNTER (BaseCatalog_tie)
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
	BaseCatalog_tie ();

	typedef ::Core::PoolObjectManager<BaseCatalog_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<BaseCatalog_tie> Pool;
	friend class ::Core::PoolObjectManager<BaseCatalog_tie>;
	typedef ::Core::IidMapRegistrator<BaseCatalog_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBaseCatalog_tie* obj, BaseCatalog*& ret_, bool interface_addref = false);

	static void make_tie (const BaseCatalog* obj, IBaseCatalog_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const BaseCatalog& obj, IBaseCatalog_tie*& ret_, const Core::TIEBase* owner);

	BaseCatalog* m_impl;

protected:

	virtual const EntityType __stdcall get_filter () const;
	virtual void __stdcall set_filter (EntityType filter);

	virtual void __stdcall find_456FEA67007E (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const;

	virtual void __stdcall find_context_456FEA670080 (
		const char* mask
		, const SearchMode& mode
		, const INode_tie* cur_item
		, ContextSearchResult_tie& result
		, INode_tie*& ret_
	) const;

	virtual void __stdcall reset_type_filter_456FEA670085 () const;


	virtual void __stdcall get_root (INode_tie*& ret_);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

