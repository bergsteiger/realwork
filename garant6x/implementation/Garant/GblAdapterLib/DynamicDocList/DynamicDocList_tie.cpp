////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID SortTypes_tie::s_com_iid = {0xA4E750C6, 0x5513, 0x44B2, {0xAB, 0xE0, 0x67, 0xCC, 0x2D, 0x4C, 0x50, 0x3E}};

unsigned long __stdcall SortTypes_tie::query_interface (
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

unsigned long __stdcall SortTypes_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SortTypes_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SortTypes_tie* const>(this));
	}
	return counter;
}

void SortTypes_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void SortTypes_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

SortTypes_tie::SortTypes_tie () : m_impl(NULL), m_orphan(true) {
}

void SortTypes_tie::make_cpp (const SortTypes_tie* obj, SortTypes*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void SortTypes_tie::new_tie (SortTypes* obj, SortTypes_tie*& ret_) {
	Core::Aptr<SortTypes> obj_aptr (obj);
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

void SortTypes_tie::make_tie (SortTypes* obj, SortTypes_tie*& ret_) {
	Core::Aptr<SortTypes> obj_aptr (obj);
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
	
void SortTypes_tie::make_tie (const SortTypes& obj, SortTypes_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new SortTypes (obj);
	} else {
		ret_ = NULL;
	}
}

void SortTypes_tie::make_tie (const SortTypes& obj, SortTypes_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<SortTypes*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall SortTypes_tie::get_count () const {
	return m_impl->size();
}

void __stdcall SortTypes_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall SortTypes_tie::clear () {
	m_impl->clear();
}

void __stdcall SortTypes_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

SortType __stdcall SortTypes_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall SortTypes_tie::set_item (size_t index, SortType item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall SortTypes_tie::add (SortType item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall SortTypes_tie::insert (size_t index, SortType item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID ListEntryInfo_tie::s_com_iid = {0x5B3CE8D5, 0x3CB9, 0x4EA6, {0xB3, 0xAC, 0x37, 0xEA, 0xDA, 0x8F, 0xDF, 0x9C}};

ListEntryInfo_tie::IidRegistrator ListEntryInfo_tie::s_iid_registrator;

ListEntryInfo_tie::ListEntryInfo_tie () : m_impl(NULL) {
}

unsigned long __stdcall ListEntryInfo_tie::query_interface (
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
unsigned long __stdcall ListEntryInfo_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ListEntryInfo_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ListEntryInfo_tie* const>(this));
	}
	return counter;
}

void ListEntryInfo_tie::init () {
		m_counter = 1;
	}

void ListEntryInfo_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ListEntryInfo_tie::cast (::Core::IObject* obj) {
	ListEntryInfo* ret = dynamic_cast<ListEntryInfo*>(obj);
	if (ret) {
		ret->addref();
	}
	IListEntryInfo_tie* ret_ = NULL;
	ListEntryInfo_tie::make_tie (ret, ret_);
	return ret_;
}

void ListEntryInfo_tie::make_cpp (const IListEntryInfo_tie* obj, ListEntryInfo*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ListEntryInfo*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ListEntryInfo_tie::make_tie (const ListEntryInfo* obj, IListEntryInfo_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ListEntryInfo_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ListEntryInfo*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ListEntryInfo_tie::make_tie (const ListEntryInfo& obj, IListEntryInfo_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ListEntryInfo_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ListEntryInfo*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ListEntryInfo_tie::get_impl () const {
	return m_impl;
}


bool __stdcall ListEntryInfo_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall ListEntryInfo_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall ListEntryInfo_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall ListEntryInfo_tie::save_to_456EB3E10178 (
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

void __stdcall ListEntryInfo_tie::append_to_456EB3E1017A (
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

void __stdcall ListEntryInfo_tie::get_doc (IDocument_tie*& ret_) {
_DLL_TRY
	Document_tie::make_tie (m_impl->get_doc(), ret_);
_DLL_CATCH
}


void __stdcall ListEntryInfo_tie::get_pid (PId& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_pid();
_DLL_CATCH
}


unsigned long __stdcall ListEntryInfo_tie::get_position () const {
_DLL_TRY
	return m_impl->get_position();
_DLL_CATCH
}


const short __stdcall ListEntryInfo_tie::get_relevance () const {
_DLL_TRY
	return m_impl->get_relevance();
_DLL_CATCH
}


PositionType __stdcall ListEntryInfo_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}



const ::Core::ComIID DynList_tie::s_com_iid = {0x00B91ACF, 0x6CDD, 0x437F, {0x93, 0x5A, 0x07, 0x28, 0x7C, 0x0E, 0x2D, 0xF0}};

DynList_tie::IidRegistrator DynList_tie::s_iid_registrator;

DynList_tie::DynList_tie () : m_impl(NULL) {
}

unsigned long __stdcall DynList_tie::query_interface (
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
unsigned long __stdcall DynList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DynList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DynList_tie* const>(this));
	}
	return counter;
}

void DynList_tie::init () {
		m_counter = 1;
	}

void DynList_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DynList_tie::cast (::Core::IObject* obj) {
	DynList* ret = dynamic_cast<DynList*>(obj);
	if (ret) {
		ret->addref();
	}
	IDynList_tie* ret_ = NULL;
	DynList_tie::make_tie (ret, ret_);
	return ret_;
}

void DynList_tie::make_cpp (const IDynList_tie* obj, DynList*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DynList*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DynList_tie::make_tie (const DynList* obj, IDynList_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DynList_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DynList*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DynList_tie::make_tie (const DynList& obj, IDynList_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DynList_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DynList*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DynList_tie::get_impl () const {
	return m_impl;
}


void __stdcall DynList_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}
void __stdcall DynList_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}


void __stdcall DynList_tie::get_root (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_root(), ret_);
_DLL_CATCH
}

void __stdcall DynList_tie::clone_45EEBA2C02C0 (
	ICatalogBase_tie*& ret_
) const {
_DLL_TRY

	CatalogBase* ret = m_impl->clone();
	CatalogBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall DynList_tie::get_node_by_path_45EEBA2C02C1 (
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

void __stdcall DynList_tie::intersect_tree_45EEBA2C02C5 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->intersect_tree(tree_);
_DLL_CATCH
}

void __stdcall DynList_tie::merge_tree_45EEBA2C02C7 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->merge_tree(tree_);
_DLL_CATCH
}

void __stdcall DynList_tie::minus_tree_45EEBA2C02C9 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->minus_tree(tree_);
_DLL_CATCH
}

void __stdcall DynList_tie::create_45EEBA2C02CB (
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
void __stdcall DynList_tie::as_evd_45EEBA2C02C3 (
	EVDGeneratorStyle style
	, GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->as_evd(style);
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall DynList_tie::get_available_sort_types (SortTypes_tie*& ret_) const {
_DLL_TRY
	SortTypes_tie::make_tie (m_impl->get_available_sort_types(), ret_, this);
_DLL_CATCH
}


const DynListContent __stdcall DynList_tie::get_content_type () const {
_DLL_TRY
	return m_impl->get_content_type();
_DLL_CATCH
}


void __stdcall DynList_tie::get_current_sort_params (SortParams& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_current_sort_params();
_DLL_CATCH
}

void __stdcall DynList_tie::get_analysis_tree_4A9F5D2A001F (
	INodeBase_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	NodeBase* ret = m_impl->get_analysis_tree();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall DynList_tie::get_full_list_4A28BDFC00F4 (
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

unsigned long __stdcall DynList_tie::get_full_list_size_4B55CF4102BF () const {
_DLL_TRY
	return m_impl->get_full_list_size ();
_DLL_CATCH
}

void __stdcall DynList_tie::get_short_name_46F8B9280148 (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_short_name();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall DynList_tie::get_history (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_history(), ret_, this);
_DLL_CATCH
}


bool __stdcall DynList_tie::get_is_filtered () const {
_DLL_TRY
	return m_impl->get_is_filtered();
_DLL_CATCH
}


const bool __stdcall DynList_tie::get_is_short () const {
_DLL_TRY
	return m_impl->get_is_short();
_DLL_CATCH
}


const bool __stdcall DynList_tie::get_is_snippet () const {
_DLL_TRY
	return m_impl->get_is_snippet();
_DLL_CATCH
}

void __stdcall DynList_tie::save_to_file_45EEDB73026D (
	const char* path
	, const INodesClipboard_tie* nodes
) const {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->save_to_file(path, nodes_);
_DLL_CATCH
}

void __stdcall DynList_tie::set_context_filter_45EEDB73026B (
	IContextFilter_tie* context
) {
_DLL_TRY
	ContextFilter* context_;
	ContextFilter_tie::make_cpp(context, context_);

	m_impl->set_context_filter(context_);
_DLL_CATCH
}

void __stdcall DynList_tie::sort_45EEDB730269 (
	const SortParams& params
) {
_DLL_TRY

	m_impl->sort(params);
_DLL_CATCH
}



const ::Core::ComIID SearchDynList_tie::s_com_iid = {0xDB91FE90, 0x832B, 0x4753, {0x92, 0x22, 0x43, 0x13, 0xAB, 0x5C, 0xA6, 0x67}};

SearchDynList_tie::IidRegistrator SearchDynList_tie::s_iid_registrator;

SearchDynList_tie::SearchDynList_tie () : m_impl(NULL) {
}

unsigned long __stdcall SearchDynList_tie::query_interface (
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
unsigned long __stdcall SearchDynList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SearchDynList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SearchDynList_tie* const>(this));
	}
	return counter;
}

void SearchDynList_tie::init () {
		m_counter = 1;
	}

void SearchDynList_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* SearchDynList_tie::cast (::Core::IObject* obj) {
	SearchDynList* ret = dynamic_cast<SearchDynList*>(obj);
	if (ret) {
		ret->addref();
	}
	ISearchDynList_tie* ret_ = NULL;
	SearchDynList_tie::make_tie (ret, ret_);
	return ret_;
}

void SearchDynList_tie::make_cpp (const ISearchDynList_tie* obj, SearchDynList*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<SearchDynList*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void SearchDynList_tie::make_tie (const SearchDynList* obj, ISearchDynList_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		SearchDynList_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<SearchDynList*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void SearchDynList_tie::make_tie (const SearchDynList& obj, ISearchDynList_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	SearchDynList_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<SearchDynList*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* SearchDynList_tie::get_impl () const {
	return m_impl;
}


SearchResultType __stdcall SearchDynList_tie::get_result_type () const {
_DLL_TRY
	return m_impl->get_result_type();
_DLL_CATCH
}


size_t __stdcall SearchDynList_tie::get_document_count () const {
_DLL_TRY
	return m_impl->get_document_count();
_DLL_CATCH
}


size_t __stdcall SearchDynList_tie::get_entry_count () const {
_DLL_TRY
	return m_impl->get_entry_count();
_DLL_CATCH
}


size_t __stdcall SearchDynList_tie::get_edition_count () const {
_DLL_TRY
	return m_impl->get_edition_count();
_DLL_CATCH
}
void __stdcall SearchDynList_tie::get_dyn_list_45EEDB91017C (
	IDynList_tie*& ret_
) const {
_DLL_TRY

	DynList* ret = m_impl->get_dyn_list();
	DynList_tie::make_tie(ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID DocListFactory_tie::s_com_iid = {0xC894D5B5, 0x37CF, 0x4463, {0xA4, 0x26, 0xE3, 0x05, 0x50, 0xF4, 0x08, 0xF8}};

DocListFactory_tie::IidRegistrator DocListFactory_tie::s_iid_registrator;

DocListFactory_tie::DocListFactory_tie () : m_impl(NULL) {
}

unsigned long __stdcall DocListFactory_tie::query_interface (
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
unsigned long __stdcall DocListFactory_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DocListFactory_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DocListFactory_tie* const>(this));
	}
	return counter;
}

void DocListFactory_tie::init () {
		m_counter = 1;
	}

void DocListFactory_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DocListFactory_tie::cast (::Core::IObject* obj) {
	DocListFactory* ret = dynamic_cast<DocListFactory*>(obj);
	if (ret) {
		ret->addref();
	}
	IDocListFactory_tie* ret_ = NULL;
	DocListFactory_tie::make_tie (ret, ret_);
	return ret_;
}

void DocListFactory_tie::make_cpp (const IDocListFactory_tie* obj, DocListFactory*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DocListFactory*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DocListFactory_tie::make_tie (const DocListFactory* obj, IDocListFactory_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DocListFactory_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DocListFactory*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DocListFactory_tie::make_tie (const DocListFactory& obj, IDocListFactory_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DocListFactory_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DocListFactory*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DocListFactory_tie::get_impl () const {
	return m_impl;
}

void __stdcall DocListFactory_tie::make_list_4D95C74A035E (
	const char* file_name
	, bool inner_numbers
	, IDynList_tie*& ret_
) const /*throw (AccessDenied_tie, InvalidType_tie)*/ {
_DLL_TRY

	DynList* ret = m_impl->make_list(file_name, inner_numbers);
	DynList_tie::make_tie(ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID DynListNode_tie::s_com_iid = {0xFAE957F6, 0xA5EA, 0x4AB6, {0x9E, 0xC2, 0x85, 0x14, 0xB6, 0x96, 0xA1, 0xC1}};

DynListNode_tie::IidRegistrator DynListNode_tie::s_iid_registrator;

DynListNode_tie::DynListNode_tie () : m_impl(NULL) {
}

unsigned long __stdcall DynListNode_tie::query_interface (
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
unsigned long __stdcall DynListNode_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DynListNode_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DynListNode_tie* const>(this));
	}
	return counter;
}

void DynListNode_tie::init () {
		m_counter = 1;
	}

void DynListNode_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DynListNode_tie::cast (::Core::IObject* obj) {
	DynListNode* ret = dynamic_cast<DynListNode*>(obj);
	if (ret) {
		ret->addref();
	}
	IDynListNode_tie* ret_ = NULL;
	DynListNode_tie::make_tie (ret, ret_);
	return ret_;
}

void DynListNode_tie::make_cpp (const IDynListNode_tie* obj, DynListNode*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DynListNode*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DynListNode_tie::make_tie (const DynListNode* obj, IDynListNode_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DynListNode_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DynListNode*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DynListNode_tie::make_tie (const DynListNode& obj, IDynListNode_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DynListNode_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DynListNode*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DynListNode_tie::get_impl () const {
	return m_impl;
}

ObjectId __stdcall DynListNode_tie::get_document_id_53CF894902A4 () const {
_DLL_TRY
	return m_impl->get_document_id ();
_DLL_CATCH
}

void __stdcall DynListNode_tie::get_snippet_text_56D44B0E0092 (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	const GCI::IO::String* ret = m_impl->get_snippet_text();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

