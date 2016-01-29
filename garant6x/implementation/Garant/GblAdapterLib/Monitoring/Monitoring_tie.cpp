////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID MonitoringList_tie::s_com_iid = {0xF6B6B6C2, 0x1E10, 0x41B3, {0x82, 0x51, 0xB3, 0x76, 0x65, 0xDE, 0x05, 0xBB}};

MonitoringList_tie::IidRegistrator MonitoringList_tie::s_iid_registrator;

MonitoringList_tie::MonitoringList_tie () : m_impl(NULL) {
}

unsigned long __stdcall MonitoringList_tie::query_interface (
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
unsigned long __stdcall MonitoringList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MonitoringList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MonitoringList_tie* const>(this));
	}
	return counter;
}

void MonitoringList_tie::init () {
		m_counter = 1;
	}

void MonitoringList_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* MonitoringList_tie::cast (::Core::IObject* obj) {
	MonitoringList* ret = dynamic_cast<MonitoringList*>(obj);
	if (ret) {
		ret->addref();
	}
	IMonitoringList_tie* ret_ = NULL;
	MonitoringList_tie::make_tie (ret, ret_);
	return ret_;
}

void MonitoringList_tie::make_cpp (const IMonitoringList_tie* obj, MonitoringList*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<MonitoringList*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void MonitoringList_tie::make_tie (const MonitoringList* obj, IMonitoringList_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		MonitoringList_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<MonitoringList*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void MonitoringList_tie::make_tie (const MonitoringList& obj, IMonitoringList_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	MonitoringList_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<MonitoringList*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* MonitoringList_tie::get_impl () const {
	return m_impl;
}


void __stdcall MonitoringList_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}
void __stdcall MonitoringList_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}


void __stdcall MonitoringList_tie::get_root (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_root(), ret_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::clone_45EEBA2C02C0 (
	ICatalogBase_tie*& ret_
) const {
_DLL_TRY

	CatalogBase* ret = m_impl->clone();
	CatalogBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::get_node_by_path_45EEBA2C02C1 (
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

void __stdcall MonitoringList_tie::intersect_tree_45EEBA2C02C5 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->intersect_tree(tree_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::merge_tree_45EEBA2C02C7 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->merge_tree(tree_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::minus_tree_45EEBA2C02C9 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->minus_tree(tree_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::create_45EEBA2C02CB (
	INodesClipboard_tie* nodes
	, ICatalogBase_tie*& ret_
) const {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	CatalogBase* ret = m_impl->create(nodes_);
	CatalogBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}
void __stdcall MonitoringList_tie::get_history (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_history(), ret_, this);
_DLL_CATCH
}


bool __stdcall MonitoringList_tie::get_is_filtered () const {
_DLL_TRY
	return m_impl->get_is_filtered();
_DLL_CATCH
}


const DynListContent __stdcall MonitoringList_tie::get_content_type () const {
_DLL_TRY
	return m_impl->get_content_type();
_DLL_CATCH
}


const bool __stdcall MonitoringList_tie::get_is_short () const {
_DLL_TRY
	return m_impl->get_is_short();
_DLL_CATCH
}


const bool __stdcall MonitoringList_tie::get_is_snippet () const {
_DLL_TRY
	return m_impl->get_is_snippet();
_DLL_CATCH
}


void __stdcall MonitoringList_tie::get_current_sort_params (SortParams& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_current_sort_params();
_DLL_CATCH
}


void __stdcall MonitoringList_tie::get_available_sort_types (SortTypes_tie*& ret_) const {
_DLL_TRY
	SortTypes_tie::make_tie (m_impl->get_available_sort_types(), ret_, this);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::sort_45EEDB730269 (
	const SortParams& params
) {
_DLL_TRY

	m_impl->sort(params);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::set_context_filter_45EEDB73026B (
	IContextFilter_tie* context
) {
_DLL_TRY
	ContextFilter* context_;
	ContextFilter_tie::make_cpp(context, context_);

	m_impl->set_context_filter(context_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::save_to_file_45EEDB73026D (
	const char* path
	, const INodesClipboard_tie* nodes
) const {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->save_to_file(path, nodes_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::as_evd_45EEBA2C02C3 (
	EVDGeneratorStyle style
	, GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->as_evd(style);
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::get_short_name_46F8B9280148 (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_short_name();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::get_full_list_4A28BDFC00F4 (
	SearchProgressIndicator::IProgressIndicatorForSearch_tie* progress
	, SearchProgressIndicator::ICancelSearch_tie*& cancel_process
) /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	SearchProgressIndicator::ProgressIndicatorForSearch_var progress_;
	SearchProgressIndicator::IProgressIndicatorForSearch_tie::make_cpp(progress, progress_.out ());
	SearchProgressIndicator::CancelSearch* cancel_process_ = 0;

	m_impl->get_full_list(progress_.in (), cancel_process_);
	SearchProgressIndicator::CancelSearch_tie::make_tie(cancel_process_, cancel_process);
_DLL_CATCH
}

void __stdcall MonitoringList_tie::get_analysis_tree_4A9F5D2A001F (
	INodeBase_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	NodeBase* ret = m_impl->get_analysis_tree();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

unsigned long __stdcall MonitoringList_tie::get_full_list_size_4B55CF4102BF () const {
_DLL_TRY
	return m_impl->get_full_list_size ();
_DLL_CATCH
}

void __stdcall MonitoringList_tie::get_summary (IDocument_tie*& ret_) {
_DLL_TRY
	Document_tie::make_tie (m_impl->get_summary(), ret_);
_DLL_CATCH
}



const ::Core::ComIID Monitoring_tie::s_com_iid = {0xFD231406, 0x37D4, 0x4C3C, {0xA8, 0x2F, 0x59, 0x23, 0x43, 0x03, 0x1D, 0x3B}};

Monitoring_tie::IidRegistrator Monitoring_tie::s_iid_registrator;

Monitoring_tie::Monitoring_tie () : m_impl(NULL) {
}

unsigned long __stdcall Monitoring_tie::query_interface (
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
unsigned long __stdcall Monitoring_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Monitoring_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Monitoring_tie* const>(this));
	}
	return counter;
}

void Monitoring_tie::init () {
		m_counter = 1;
	}

void Monitoring_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Monitoring_tie::cast (::Core::IObject* obj) {
	Monitoring* ret = dynamic_cast<Monitoring*>(obj);
	if (ret) {
		ret->addref();
	}
	IMonitoring_tie* ret_ = NULL;
	Monitoring_tie::make_tie (ret, ret_);
	return ret_;
}

void Monitoring_tie::make_cpp (const IMonitoring_tie* obj, Monitoring*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Monitoring*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Monitoring_tie::make_tie (const Monitoring* obj, IMonitoring_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Monitoring_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Monitoring*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Monitoring_tie::make_tie (const Monitoring& obj, IMonitoring_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Monitoring_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Monitoring*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Monitoring_tie::get_impl () const {
	return m_impl;
}

bool __stdcall Monitoring_tie::is_exist_45EEC1030220 () const {
_DLL_TRY
	return m_impl->is_exist ();
_DLL_CATCH
}

bool __stdcall Monitoring_tie::is_news_line_defined_45EEC103021F () const {
_DLL_TRY
	return m_impl->is_news_line_defined ();
_DLL_CATCH
}


void __stdcall Monitoring_tie::get_news_line_root (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_news_line_root(), ret_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

