////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.h"

namespace GblAdapterLib {

class IFilterFromQuery_tie: public ::Core::IIObject_tie {
public:

	virtual const bool __stdcall get_changeable () const = 0;


	virtual const unsigned long __stdcall get_id () const = 0;

	virtual bool __stdcall is_same_4CA9B8430333 (
		const IFilterFromQuery_tie* other
	) const = 0;

	virtual bool __stdcall is_used_4CB6E46C024F () const = 0;

	virtual void __stdcall mark_to_erase_4CA49BC000E5 () = 0;

	virtual bool __stdcall marked_to_erase_4CB450AB03D8 () const = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_name (GCI::IO::IString_tie* name) = 0;


	virtual const bool __stdcall get_permanent () const = 0;
	virtual void __stdcall set_permanent (bool permanent) = 0;


	virtual void __stdcall get_query (IEntityBase_tie*& ret_) = 0;
};

class __declspec (dllexport) FilterFromQuery_tie: public IFilterFromQuery_tie {
	SET_OBJECT_COUNTER (FilterFromQuery_tie)
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
	FilterFromQuery_tie ();

	typedef ::Core::PoolObjectManager<FilterFromQuery_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FilterFromQuery_tie> Pool;
	friend class ::Core::PoolObjectManager<FilterFromQuery_tie>;
	typedef ::Core::IidMapRegistrator<FilterFromQuery_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFilterFromQuery_tie* obj, FilterFromQuery*& ret_, bool interface_addref = false);

	static void make_tie (const FilterFromQuery* obj, IFilterFromQuery_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FilterFromQuery& obj, IFilterFromQuery_tie*& ret_, const Core::TIEBase* owner);

	FilterFromQuery* m_impl;

protected:

	virtual const bool __stdcall get_changeable () const;


	virtual const unsigned long __stdcall get_id () const;

	virtual bool __stdcall is_same_4CA9B8430333 (
		const IFilterFromQuery_tie* other
	) const;

	virtual bool __stdcall is_used_4CB6E46C024F () const;

	virtual void __stdcall mark_to_erase_4CA49BC000E5 ();

	virtual bool __stdcall marked_to_erase_4CB450AB03D8 () const;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);


	virtual const bool __stdcall get_permanent () const;
	virtual void __stdcall set_permanent (bool permanent);


	virtual void __stdcall get_query (IEntityBase_tie*& ret_);
};

class FiltersFromQuery_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (FiltersFromQuery_tie)
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
	FiltersFromQuery_tie ();

	typedef ::Core::PoolObjectManager<FiltersFromQuery_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FiltersFromQuery_tie> Pool;
	friend class ::Core::PoolObjectManager<FiltersFromQuery_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const FiltersFromQuery_tie* obj, FiltersFromQuery*& ret_);

	static void make_tie (FiltersFromQuery* obj, FiltersFromQuery_tie*& ret_);
	
	static void make_tie (const FiltersFromQuery& obj, FiltersFromQuery_tie*& ret_);

	static void make_tie (const FiltersFromQuery& obj, FiltersFromQuery_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (FiltersFromQuery* obj, FiltersFromQuery_tie*& ret_);

	FiltersFromQuery* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IFilterFromQuery_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IFilterFromQuery_tie* item);
	virtual size_t __stdcall add (const IFilterFromQuery_tie* item);
	virtual size_t __stdcall insert (size_t index, const IFilterFromQuery_tie* item);
};

class IFilterable_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_active_filters (FiltersFromQuery_tie*& ret_) const = 0;

	virtual void __stdcall add_filter_45EEB02C03AA (
		IFilterFromQuery_tie* filter
		, bool auto_refresh
	) /*throw (AllContentIsFiltered_tie, NotAllAttributesRestored_tie)*/ = 0;

	virtual void __stdcall apply_filters_45EEB02C03B2 (
		const FiltersFromQuery_tie* filters
	) /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/ = 0;

	virtual void __stdcall clear_filters_45EEB02C03B0 () /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall delete_filter_45EEB02C03AD (
		const IFilterFromQuery_tie* filter
		, bool auto_refresh
	) /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/ = 0;


	virtual bool __stdcall get_has_active_filters () const = 0;

	virtual void __stdcall refresh_filters_45EEB02C03B1 () /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/ = 0;
};

class __declspec (dllexport) Filterable_tie: public IFilterable_tie {
	SET_OBJECT_COUNTER (Filterable_tie)
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
	Filterable_tie ();

	typedef ::Core::PoolObjectManager<Filterable_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Filterable_tie> Pool;
	friend class ::Core::PoolObjectManager<Filterable_tie>;
	typedef ::Core::IidMapRegistrator<Filterable_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFilterable_tie* obj, Filterable*& ret_, bool interface_addref = false);

	static void make_tie (const Filterable* obj, IFilterable_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Filterable& obj, IFilterable_tie*& ret_, const Core::TIEBase* owner);

	Filterable* m_impl;

protected:

	virtual void __stdcall get_active_filters (FiltersFromQuery_tie*& ret_) const;

	virtual void __stdcall add_filter_45EEB02C03AA (
		IFilterFromQuery_tie* filter
		, bool auto_refresh
	) /*throw (AllContentIsFiltered_tie, NotAllAttributesRestored_tie)*/;

	virtual void __stdcall apply_filters_45EEB02C03B2 (
		const FiltersFromQuery_tie* filters
	) /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/;

	virtual void __stdcall clear_filters_45EEB02C03B0 () /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall delete_filter_45EEB02C03AD (
		const IFilterFromQuery_tie* filter
		, bool auto_refresh
	) /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/;


	virtual bool __stdcall get_has_active_filters () const;

	virtual void __stdcall refresh_filters_45EEB02C03B1 () /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/;
};


class IFilterNotifier_tie;

// callback only cpp-wraper
class FilterNotifier_callback_tie : virtual public FilterNotifier, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (FilterNotifier_callback_tie)
	friend class IFilterNotifier_tie;
protected:
	virtual unsigned long addref () const;

	virtual unsigned long ref_count () const;

public:
	virtual unsigned long release () const;
	virtual void filter_name_changed () const;

	virtual void filter_permanence_changed () const;

	virtual void filters_changed () const;

	FilterNotifier_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<FilterNotifier_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FilterNotifier_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<FilterNotifier_callback_tie>;
	
public:
	mutable IFilterNotifier_tie* m_impl;
};

// callback only abstarct interface
class IFilterNotifier_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;

	virtual void __stdcall filter_name_changed_4CB2B27F03C3 () const = 0;

	virtual void __stdcall filter_permanence_changed_4CB2B2910052 () const = 0;

	virtual void __stdcall filters_changed_4CB2B26B0365 () const = 0;

	static void make_cpp (const IFilterNotifier_tie* obj, FilterNotifier*& ret_, bool interface_addref = false);

	static void make_tie (IFilterNotifier_tie* obj, FilterNotifier_callback_tie*& ret_);
};


class IFiltersManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall create_filter_4CA49DE2023F (
		const IEntityBase_tie* query
		, const GCI::IO::IString_tie* name
	) = 0;

	virtual void __stdcall get_legal_filters_4CA49C380277 (
		FiltersFromQuery_tie*& ret_
	) const = 0;

	virtual void __stdcall get_pharm_filters_4CA49DB202D1 (
		FiltersFromQuery_tie*& ret_
	) const = 0;

	virtual void __stdcall set_legal_notifier_4CB2B31D02D1 (
		IFilterNotifier_tie* notifier
	) = 0;

	virtual void __stdcall set_pharm_notifier_4CB2B344018E (
		IFilterNotifier_tie* notifier
	) = 0;
};

class __declspec (dllexport) FiltersManager_tie: public IFiltersManager_tie {
	SET_OBJECT_COUNTER (FiltersManager_tie)
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
	FiltersManager_tie ();

	typedef ::Core::PoolObjectManager<FiltersManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FiltersManager_tie> Pool;
	friend class ::Core::PoolObjectManager<FiltersManager_tie>;
	typedef ::Core::IidMapRegistrator<FiltersManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFiltersManager_tie* obj, FiltersManager*& ret_, bool interface_addref = false);

	static void make_tie (const FiltersManager* obj, IFiltersManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FiltersManager& obj, IFiltersManager_tie*& ret_, const Core::TIEBase* owner);

	FiltersManager* m_impl;

protected:
	virtual void __stdcall create_filter_4CA49DE2023F (
		const IEntityBase_tie* query
		, const GCI::IO::IString_tie* name
	);

	virtual void __stdcall get_legal_filters_4CA49C380277 (
		FiltersFromQuery_tie*& ret_
	) const;

	virtual void __stdcall get_pharm_filters_4CA49DB202D1 (
		FiltersFromQuery_tie*& ret_
	) const;

	virtual void __stdcall set_legal_notifier_4CB2B31D02D1 (
		IFilterNotifier_tie* notifier
	);

	virtual void __stdcall set_pharm_notifier_4CB2B344018E (
		IFilterNotifier_tie* notifier
	);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

