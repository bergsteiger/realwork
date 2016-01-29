////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MONITORING_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_MONITORING_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.h"

namespace GblAdapterLib {

class IMonitoringList_tie: public IDynList_tie {
public:

	virtual void __stdcall get_summary (IDocument_tie*& ret_) = 0;
};

class __declspec (dllexport) MonitoringList_tie: public IMonitoringList_tie {
	SET_OBJECT_COUNTER (MonitoringList_tie)
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
	MonitoringList_tie ();

	typedef ::Core::PoolObjectManager<MonitoringList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MonitoringList_tie> Pool;
	friend class ::Core::PoolObjectManager<MonitoringList_tie>;
	typedef ::Core::IidMapRegistrator<MonitoringList_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMonitoringList_tie* obj, MonitoringList*& ret_, bool interface_addref = false);

	static void make_tie (const MonitoringList* obj, IMonitoringList_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const MonitoringList& obj, IMonitoringList_tie*& ret_, const Core::TIEBase* owner);

	MonitoringList* m_impl;

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
	virtual void __stdcall get_history (GCI::IO::IString_tie*& ret_);


	virtual bool __stdcall get_is_filtered () const;


	virtual const DynListContent __stdcall get_content_type () const;


	virtual const bool __stdcall get_is_short () const;


	virtual const bool __stdcall get_is_snippet () const;


	virtual void __stdcall get_current_sort_params (SortParams& ret_) const;


	virtual void __stdcall get_available_sort_types (SortTypes_tie*& ret_) const;

	virtual void __stdcall sort_45EEDB730269 (
		const SortParams& params
	);

	virtual void __stdcall set_context_filter_45EEDB73026B (
		IContextFilter_tie* context
	);

	virtual void __stdcall save_to_file_45EEDB73026D (
		const char* path
		, const INodesClipboard_tie* nodes
	) const;

	virtual void __stdcall as_evd_45EEBA2C02C3 (
		EVDGeneratorStyle style
		, GCI::IO::IStream_tie*& ret_
	) const;

	virtual void __stdcall get_short_name_46F8B9280148 (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_full_list_4A28BDFC00F4 (
		SearchProgressIndicator::IProgressIndicatorForSearch_tie* progress
		, SearchProgressIndicator::ICancelSearch_tie*& cancel_process
	) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_analysis_tree_4A9F5D2A001F (
		INodeBase_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual unsigned long __stdcall get_full_list_size_4B55CF4102BF () const;

	virtual void __stdcall get_summary (IDocument_tie*& ret_);
};

class IMonitoring_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall is_exist_45EEC1030220 () const = 0;

	virtual bool __stdcall is_news_line_defined_45EEC103021F () const = 0;


	virtual void __stdcall get_news_line_root (INodeBase_tie*& ret_) = 0;
};

class __declspec (dllexport) Monitoring_tie: public IMonitoring_tie {
	SET_OBJECT_COUNTER (Monitoring_tie)
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
	Monitoring_tie ();

	typedef ::Core::PoolObjectManager<Monitoring_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Monitoring_tie> Pool;
	friend class ::Core::PoolObjectManager<Monitoring_tie>;
	typedef ::Core::IidMapRegistrator<Monitoring_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMonitoring_tie* obj, Monitoring*& ret_, bool interface_addref = false);

	static void make_tie (const Monitoring* obj, IMonitoring_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Monitoring& obj, IMonitoring_tie*& ret_, const Core::TIEBase* owner);

	Monitoring* m_impl;

protected:
	virtual bool __stdcall is_exist_45EEC1030220 () const;

	virtual bool __stdcall is_news_line_defined_45EEC103021F () const;


	virtual void __stdcall get_news_line_root (INodeBase_tie*& ret_);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_MONITORING_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

