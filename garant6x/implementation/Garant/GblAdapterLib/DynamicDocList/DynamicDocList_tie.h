////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator_tie.h"

namespace GblAdapterLib {

class SortTypes_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (SortTypes_tie)
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
	SortTypes_tie ();

	typedef ::Core::PoolObjectManager<SortTypes_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SortTypes_tie> Pool;
	friend class ::Core::PoolObjectManager<SortTypes_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const SortTypes_tie* obj, SortTypes*& ret_);

	static void make_tie (SortTypes* obj, SortTypes_tie*& ret_);
	
	static void make_tie (const SortTypes& obj, SortTypes_tie*& ret_);

	static void make_tie (const SortTypes& obj, SortTypes_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (SortTypes* obj, SortTypes_tie*& ret_);

	SortTypes* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual SortType __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, SortType item);
	virtual size_t __stdcall add (SortType item);
	virtual size_t __stdcall insert (size_t index, SortType item);
};

class IListEntryInfo_tie: public IEntityBase_tie {
public:

	virtual void __stdcall get_doc (IDocument_tie*& ret_) = 0;


	virtual void __stdcall get_pid (PId& ret_) const = 0;


	virtual unsigned long __stdcall get_position () const = 0;


	virtual const short __stdcall get_relevance () const = 0;


	virtual PositionType __stdcall get_type () const = 0;
};

class __declspec (dllexport) ListEntryInfo_tie: public IListEntryInfo_tie {
	SET_OBJECT_COUNTER (ListEntryInfo_tie)
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
	ListEntryInfo_tie ();

	typedef ::Core::PoolObjectManager<ListEntryInfo_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ListEntryInfo_tie> Pool;
	friend class ::Core::PoolObjectManager<ListEntryInfo_tie>;
	typedef ::Core::IidMapRegistrator<ListEntryInfo_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IListEntryInfo_tie* obj, ListEntryInfo*& ret_, bool interface_addref = false);

	static void make_tie (const ListEntryInfo* obj, IListEntryInfo_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ListEntryInfo& obj, IListEntryInfo_tie*& ret_, const Core::TIEBase* owner);

	ListEntryInfo* m_impl;

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

	virtual void __stdcall get_doc (IDocument_tie*& ret_);


	virtual void __stdcall get_pid (PId& ret_) const;


	virtual unsigned long __stdcall get_position () const;


	virtual const short __stdcall get_relevance () const;


	virtual PositionType __stdcall get_type () const;
};

class IDynList_tie: public ICatalogBase_tie {
public:
	virtual void __stdcall as_evd_45EEBA2C02C3 (
		EVDGeneratorStyle style
		, GCI::IO::IStream_tie*& ret_
	) const = 0;


	virtual void __stdcall get_available_sort_types (SortTypes_tie*& ret_) const = 0;


	virtual const DynListContent __stdcall get_content_type () const = 0;


	virtual void __stdcall get_current_sort_params (SortParams& ret_) const = 0;

	virtual void __stdcall get_analysis_tree_4A9F5D2A001F (
		INodeBase_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_full_list_4A28BDFC00F4 (
		SearchProgressIndicator::IProgressIndicatorForSearch_tie* progress
		, SearchProgressIndicator::ICancelSearch_tie*& cancel_process
	) /*throw (CanNotFindData_tie)*/ = 0;

	virtual unsigned long __stdcall get_full_list_size_4B55CF4102BF () const = 0;

	virtual void __stdcall get_short_name_46F8B9280148 (
		GCI::IO::IString_tie*& ret_
	) const = 0;


	virtual void __stdcall get_history (GCI::IO::IString_tie*& ret_) = 0;


	virtual bool __stdcall get_is_filtered () const = 0;


	virtual const bool __stdcall get_is_short () const = 0;


	virtual const bool __stdcall get_is_snippet () const = 0;

	virtual void __stdcall save_to_file_45EEDB73026D (
		const char* path
		, const INodesClipboard_tie* nodes
	) const = 0;

	virtual void __stdcall set_context_filter_45EEDB73026B (
		IContextFilter_tie* context
	) = 0;

	virtual void __stdcall sort_45EEDB730269 (
		const SortParams& params
	) = 0;
};

class __declspec (dllexport) DynList_tie: public IDynList_tie {
	SET_OBJECT_COUNTER (DynList_tie)
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
	DynList_tie ();

	typedef ::Core::PoolObjectManager<DynList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DynList_tie> Pool;
	friend class ::Core::PoolObjectManager<DynList_tie>;
	typedef ::Core::IidMapRegistrator<DynList_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDynList_tie* obj, DynList*& ret_, bool interface_addref = false);

	static void make_tie (const DynList* obj, IDynList_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DynList& obj, IDynList_tie*& ret_, const Core::TIEBase* owner);

	DynList* m_impl;

protected:

	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);


	virtual void __stdcall get_root (INodeBase_tie*& ret_);

	virtual void __stdcall clone_45EEBA2C02C0 (
		ICatalogBase_tie*& ret_
	) const;

	virtual void __stdcall get_node_by_path_45EEBA2C02C1 (
		const NodeIndexPath_tie* path
		, INodeBase_tie*& ret_
	) const /*throw (NotFound_tie)*/;

	virtual void __stdcall intersect_tree_45EEBA2C02C5 (
		const ICatalogBase_tie* tree
	);

	virtual void __stdcall merge_tree_45EEBA2C02C7 (
		const ICatalogBase_tie* tree
	);

	virtual void __stdcall minus_tree_45EEBA2C02C9 (
		const ICatalogBase_tie* tree
	);

	virtual void __stdcall create_45EEBA2C02CB (
		INodesClipboard_tie* nodes
		, ICatalogBase_tie*& ret_
	) const;
	virtual void __stdcall as_evd_45EEBA2C02C3 (
		EVDGeneratorStyle style
		, GCI::IO::IStream_tie*& ret_
	) const;


	virtual void __stdcall get_available_sort_types (SortTypes_tie*& ret_) const;


	virtual const DynListContent __stdcall get_content_type () const;


	virtual void __stdcall get_current_sort_params (SortParams& ret_) const;

	virtual void __stdcall get_analysis_tree_4A9F5D2A001F (
		INodeBase_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_full_list_4A28BDFC00F4 (
		SearchProgressIndicator::IProgressIndicatorForSearch_tie* progress
		, SearchProgressIndicator::ICancelSearch_tie*& cancel_process
	) /*throw (CanNotFindData_tie)*/;

	virtual unsigned long __stdcall get_full_list_size_4B55CF4102BF () const;

	virtual void __stdcall get_short_name_46F8B9280148 (
		GCI::IO::IString_tie*& ret_
	) const;


	virtual void __stdcall get_history (GCI::IO::IString_tie*& ret_);


	virtual bool __stdcall get_is_filtered () const;


	virtual const bool __stdcall get_is_short () const;


	virtual const bool __stdcall get_is_snippet () const;

	virtual void __stdcall save_to_file_45EEDB73026D (
		const char* path
		, const INodesClipboard_tie* nodes
	) const;

	virtual void __stdcall set_context_filter_45EEDB73026B (
		IContextFilter_tie* context
	);

	virtual void __stdcall sort_45EEDB730269 (
		const SortParams& params
	);
};

class ISearchDynList_tie: public ISearchEntity_tie {
public:
	virtual void __stdcall get_dyn_list_45EEDB91017C (
		IDynList_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) SearchDynList_tie: public ISearchDynList_tie {
	SET_OBJECT_COUNTER (SearchDynList_tie)
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
	SearchDynList_tie ();

	typedef ::Core::PoolObjectManager<SearchDynList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SearchDynList_tie> Pool;
	friend class ::Core::PoolObjectManager<SearchDynList_tie>;
	typedef ::Core::IidMapRegistrator<SearchDynList_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISearchDynList_tie* obj, SearchDynList*& ret_, bool interface_addref = false);

	static void make_tie (const SearchDynList* obj, ISearchDynList_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const SearchDynList& obj, ISearchDynList_tie*& ret_, const Core::TIEBase* owner);

	SearchDynList* m_impl;

protected:

	virtual SearchResultType __stdcall get_result_type () const;


	virtual size_t __stdcall get_document_count () const;


	virtual size_t __stdcall get_entry_count () const;


	virtual size_t __stdcall get_edition_count () const;
	virtual void __stdcall get_dyn_list_45EEDB91017C (
		IDynList_tie*& ret_
	) const;
};

class IDocListFactory_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall make_list_4D95C74A035E (
		const char* file_name
		, bool inner_numbers
		, IDynList_tie*& ret_
	) const /*throw (AccessDenied_tie, InvalidType_tie)*/ = 0;
};

class __declspec (dllexport) DocListFactory_tie: public IDocListFactory_tie {
	SET_OBJECT_COUNTER (DocListFactory_tie)
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
	DocListFactory_tie ();

	typedef ::Core::PoolObjectManager<DocListFactory_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DocListFactory_tie> Pool;
	friend class ::Core::PoolObjectManager<DocListFactory_tie>;
	typedef ::Core::IidMapRegistrator<DocListFactory_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDocListFactory_tie* obj, DocListFactory*& ret_, bool interface_addref = false);

	static void make_tie (const DocListFactory* obj, IDocListFactory_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DocListFactory& obj, IDocListFactory_tie*& ret_, const Core::TIEBase* owner);

	DocListFactory* m_impl;

protected:
	virtual void __stdcall make_list_4D95C74A035E (
		const char* file_name
		, bool inner_numbers
		, IDynList_tie*& ret_
	) const /*throw (AccessDenied_tie, InvalidType_tie)*/;
};

class IDynListNode_tie: public ::Core::IIObject_tie {
public:
	virtual ObjectId __stdcall get_document_id_53CF894902A4 () const = 0;
};

class __declspec (dllexport) DynListNode_tie: public IDynListNode_tie {
	SET_OBJECT_COUNTER (DynListNode_tie)
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
	DynListNode_tie ();

	typedef ::Core::PoolObjectManager<DynListNode_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DynListNode_tie> Pool;
	friend class ::Core::PoolObjectManager<DynListNode_tie>;
	typedef ::Core::IidMapRegistrator<DynListNode_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDynListNode_tie* obj, DynListNode*& ret_, bool interface_addref = false);

	static void make_tie (const DynListNode* obj, IDynListNode_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DynListNode& obj, IDynListNode_tie*& ret_, const Core::TIEBase* owner);

	DynListNode* m_impl;

protected:
	virtual ObjectId __stdcall get_document_id_53CF894902A4 () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

