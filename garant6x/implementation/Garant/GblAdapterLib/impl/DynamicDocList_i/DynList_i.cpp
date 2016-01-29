////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "shared/GCI/I18N/I18N.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterface.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ListSortTypeTranslator.h"
#include <fstream>
#include "garant6x/implementation/Garant/GblAdapterLib/FoldersHelper/ContentChecker.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"
#include "garantServer/src/Business/GblLogging/Home/Client.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListAnalysisTree.h"

//#UC START# *45741B97005D_CUSTOM_INCLUDES*
#include "boost/foreach.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ShortDocList_ami.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ProgressIndicatorSupport_i/ProgressIndicatorServant_i.h" 
//#UC END# *45741B97005D_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45741B97005D*
//#UC END# *45741B97005D*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

DynListTypeImpl DynList_i::type_to_impl_type (DynListType type) {
	//#UC START# *48312C010372*
	switch (type) {
		case T_CORRESPONDENT:
			return T_CORRESPONDENT_IMPL;
		case T_CORRESPONDENT_TO_PART:
			return T_CORRESPONDENT_TO_PART_IMPL;
		case T_RESPONDENT:
			return T_RESPONDENT_IMPL;
		case T_RESPONDENT_TO_PART:
			return T_RESPONDENT_TO_PART_IMPL;
		case T_SAME_DOCUMENTS:
			return T_SAME_DOCUMENTS_IMPL;
	}
	GDS_ASSERT (!"Unknown DynList type");
	return T_UNKNOWN_IMPL;
	//#UC END# *48312C010372*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DynList_i::DynList_i (GblDocList::DocListTree* server_list)
//#UC START# *45EEDB730265_46027CB800FD_45741B97005D_BASE_INIT*
	: ListCatalogBase (server_list)
	, m_legal_document (0)
	, m_build_server_list_on_demand (false)
	, m_type (T_UNKNOWN_IMPL)
	, m_sort_params (this)
	, m_name_initialized (false)
	, m_content_type (DLCI_UNKNOWN)
	, m_is_short_list (boost::indeterminate)
	, m_is_snippet (boost::indeterminate)
//#UC END# *45EEDB730265_46027CB800FD_45741B97005D_BASE_INIT*
{
	//#UC START# *45EEDB730265_46027CB800FD_45741B97005D_BODY*
	//#UC END# *45EEDB730265_46027CB800FD_45741B97005D_BODY*
}

DynList_i::DynList_i (GblPilot::LegalDocument* legal_document, const GblPilotQueryDef::Query& query, DynListType type)
//#UC START# *45EEDB730265_462CABDF01F2_45741B97005D_BASE_INIT*
	: ListCatalogBase (0)
	, m_legal_document (GblPilot::LegalDocument::_duplicate (legal_document))
	, m_query (query)
	, m_build_server_list_on_demand (true)
	, m_type (DynList_i::type_to_impl_type (type))
	, m_sort_params (this) 
	, m_name_initialized (false)
	, m_content_type (DLCI_UNKNOWN)
	, m_is_short_list (boost::indeterminate)
//#UC END# *45EEDB730265_462CABDF01F2_45741B97005D_BASE_INIT*
{
	//#UC START# *45EEDB730265_462CABDF01F2_45741B97005D_BODY*
	this->make_name (type);
	//#UC END# *45EEDB730265_462CABDF01F2_45741B97005D_BODY*
}

DynList_i::DynList_i (SpecialListKey key)
//#UC START# *45EEDB730265_47FDCBAE0324_45741B97005D_BASE_INIT*
	: ListCatalogBase (0)
	, m_legal_document (0)
	, m_build_server_list_on_demand (false)
	, m_type (T_UNKNOWN_IMPL)
	, m_sort_params (this)
	, m_name_initialized (false)
	, m_content_type (DLCI_UNKNOWN)
	, m_is_short_list (boost::indeterminate)

//#UC END# *45EEDB730265_47FDCBAE0324_45741B97005D_BASE_INIT*
{
	//#UC START# *45EEDB730265_47FDCBAE0324_45741B97005D_BODY*
	switch (key) {
		case SLK_ALL_ALLOWED_DRUGS:
			try {
				GblDocList::DocListTree_var doc_list_tree = 
					ApplicationHelper::instance ()->get_cached_search_manager ()->get_special_document_list (::GblPilotQueryDef::ALLOWED_DRUG_LIST);
				this->set_server_list (GblDocList::DocListTree::_duplicate (doc_list_tree.in ()));
			} catch (GCD::CanNotFindData&) {
				GDS_ASSERT (false);
			} 
			break;
		default: GDS_ASSERT (false);
	}
	//#UC END# *45EEDB730265_47FDCBAE0324_45741B97005D_BODY*
}

DynList_i::~DynList_i () {
	//#UC START# *45741B97005D_DESTR_BODY*
	FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
	for (FiltersFromQuery::const_iterator it = m_filters.begin (); it != m_filters.end (); ++it) {
		usage_counter->remove (it->in ());
	}
	//#UC END# *45741B97005D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void DynList_i::add_bookmark (const GblPilotDef::Bookmark& bookmark) {
	//#UC START# *4607EF4C016A*
	GDS_ASSERT (this->get_cached_server_tree ());
	GblDocList::DocListTree_var docs_list = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());
	GDS_ASSERT (!CORBA::is_nil (docs_list));
	docs_list->add_bookmark (bookmark);
	EntityStorage_var dummy (this->save_to (0));
	//#UC END# *4607EF4C016A*
}

bool DynList_i::check_filter (FilterFromQuery* filter) const {
	//#UC START# *4607D3FC03A4*
	return filter->check ();
	//#UC END# *4607D3FC03A4*
}

// Очистка закешированных данных
void DynList_i::clear_cache () {
	//#UC START# *4AFAA39A01AA*
	m_is_short_list = boost::indeterminate;
	m_is_snippet = boost::indeterminate;
	//#UC END# *4AFAA39A01AA*
}

void DynList_i::clone_filters (DynList_i* clone) const {
	//#UC START# *46E67182017D*
	clone->m_filters = m_filters;
	FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
	BOOST_FOREACH (const FilterFromQuery_var& filter, m_filters) {
		usage_counter->add (filter.in ());		
	}

	clone->m_sort_params.get () = m_sort_params.get ();
	if (!m_context_filter.is_nil ()) {
		clone->m_context_filter = m_context_filter->clone ();
	}
	//#UC END# *46E67182017D*
}

void DynList_i::do_delete_filter (const FilterFromQuery* filter) {
	//#UC START# *4607D2410155*
	size_t length = m_filters.size ();

	for (size_t i = 0; i < length; ++i) {
		if (m_filters[i]->is_same (filter)) {
			m_filters.erase (m_filters.begin () + i);
			FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
			usage_counter->remove (filter);		
			break;
		}
	}
	//#UC END# *4607D2410155*
}

void DynList_i::filtrate () {
	//#UC START# *4607D2070127*
	// clear history cache
	m_history = 0;	

	std::vector <FilterForTree*> buffer;
	
	// create sort filter
	SortFilter* sort_filter = SortFilterFactory::make ();
	sort_filter->set_order (m_sort_params.get ().sort_order);
	sort_filter->set_type (m_sort_params.get ().sort_type);
	buffer.push_back (sort_filter);
	
	// create context filter
	if (m_context_filter.ptr ()) {
		#ifdef _DEBUG
		GCI::IO::String_var context (GCI::IO::StringFactory::make (m_context_filter->get_context ().get_data ()));
		GDS_ASSERT (strlen (const_cast <GCI::IO::String*> (context.ptr ())->get_data()));
		#endif // _DEBUG
		ContextFilter* context_filter = ContextFilter::_duplicate (m_context_filter. in ());	
		buffer.push_back (context_filter);
	}
	
	// create query filters
	if (m_filters.size ()) {
		QueryFilter* query_filter = QueryFilterFactory::make (m_filters);
		buffer.push_back (query_filter);
	}
	
	FilterList list = FilterList (buffer.size ());
	for (size_t i = 0; i < buffer.size (); ++i) {
		list[i] = buffer[i];
	}
	
	VisibleIndex index;
	NodeBase_var new_view (this->real_root ()->create_view_ex (list, FM_USER_FLAG_MASK, 0, index, 0, false, false, false));
	//this->real_root ()->create_view_ex (list, FM_SHARED_ALL, 0, &index, 0, false, false, false, new_view.out ()); //need to be FM_SHARED_ALL, but we have strange error
	m_view = new_view;
	this->clear_cache ();
	//#UC END# *4607D2070127*
}

GTree::Tree* DynList_i::get_actual_server_tree () const {
	//#UC START# *4607D3440200*
	GTree::Tree_ptr stree = dynamic_cast<DefaultNodeBase*> (const_cast<DynList_i*> (this)->view ())->owner_tree ()->get_cached_server_tree ();
	GDS_ASSERT (stree);
	return stree;
	//#UC END# *4607D3440200*
}

GblDocList::DocListTree* DynList_i::get_cached_server_doc_list () const {
	//#UC START# *4607D32B0367*
	if (CORBA::is_nil (this->get_cached_server_list ())) {
		const_cast<DynList_i*> (this)->view (); // load tree on demand
	}
	return this->get_cached_server_list ();
	//#UC END# *4607D32B0367*
}

NodeBase* DynList_i::get_root_i () {
	//#UC START# *4607D63D02B6*
	if (m_view.is_nil ()) {
		if (m_build_server_list_on_demand) {
			try {
				switch (m_type) {
					case T_RESPONDENT_IMPL   : this->set_server_list (m_legal_document->get_respond_list (m_query));    break;
					case T_CORRESPONDENT_IMPL: this->set_server_list (m_legal_document->get_correspond_list (m_query)); break;
					case T_SAME_DOCUMENTS_IMPL: this->set_server_list (m_legal_document->get_same_documents ()); break;
				};
				this->make_tree (true);
			} catch (GCD::CanNotFindData&) {
				throw CanNotFindData ();
			} catch (...) {
				GDS_ASSERT_MSG (false, ("DynList_i::get_root_i: unknown exception"));
				throw CanNotFindData ();
			}
			m_build_server_list_on_demand = false;
			m_legal_document = 0;
		} else {
			GDS_ASSERT (!CORBA::is_nil (this->get_cached_server_list ()));
			this->make_tree (true);
		}
		m_view = const_cast<NodeBase*> (ListCatalogBase::get_root ());
	}
	return const_cast <NodeBase*> (m_view.ptr ());
	//#UC END# *4607D63D02B6*
}

void DynList_i::make_name (DynListType type) {
	//#UC START# *4607D2DA006A*
	GCI::IO::String_var list_name;
	switch (type) {
		case T_RESPONDENT:
			list_name = GCI::IO::StringFactory::make (NOT_UNICODE_TR("Ссылки из документа: ").c_str ());
			break;
		case T_CORRESPONDENT:
			list_name = GCI::IO::StringFactory::make (NOT_UNICODE_TR("Ссылки на документ: ").c_str ());
			break;
		case T_SAME_DOCUMENTS:
			list_name = GCI::IO::StringFactory::make (NOT_UNICODE_TR("Похожие документы для: ").c_str ());
			break;
	}

	list_name->add (CORBA::String_var (m_legal_document->get_name ()).in ());
	ListCatalogBase::set_name (list_name.in ());
	m_name_initialized = true;
	//#UC END# *4607D2DA006A*
}

NodeBase* DynList_i::real_root () {
	//#UC START# *4607D7110082*
	this->get_root_i ();
	NodeBase_var root (const_cast<NodeBase*> (ListCatalogBase::get_root ()));
	return root.ptr ();
	//#UC END# *4607D7110082*
}

void DynList_i::reset_by_server_tree (GTree::Tree* new_tree) {
	//#UC START# *4607D7290276*
	if (!CORBA::is_nil (this->get_cached_server_list ())) {
		ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (
			this->get_cached_server_list ()
		);
	}

	this->set_server_list (GblDocList::DocListTree::_narrow (new_tree));
	m_view = 0;
	this->get_root_i ();
	ListTree<DynListNode_i>* list = dynamic_cast<ListTree<DynListNode_i>*> (this->get_cached_adapter_tree ());
	GDS_ASSERT (list);
	list->clear_block_positions ();
//#UC END# *4607D7290276*
}

Containers::Content* DynList_i::save_to_folder (GblFolders::Folder* folder) {
	//#UC START# *4607D28203E5*
	GblFolders::Folders* folders = ApplicationHelper::instance ()->get_cached_folders ();
	Containers::Content_var content = folders->create_content (
		this->get_content_type () == DLC_MEDICAL_DOCUMENTS ? Defines::CT_SAVED_PHARM_LIST : Defines::CT_SAVED_LIST
	);
	GblFolders::SavedList_var saved_list = GblFolders::SavedList::_narrow (content);
	try {
		saved_list->set_name (this->get_name ().get_data ());
		saved_list->save (this->get_actual_server_tree ());
		folder->add_content (content);
	} catch (Containers::DuplicateName&) {
		throw DuplicateNode ();
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (...) {
		throw CanNotFindData ();
	}

	this->set_list_storage (saved_list.in ());
	return content._retn ();
	//#UC END# *4607D28203E5*
}

void DynList_i::truncate_view_by_context (ContextFilter* context, bool refresh) {
	//#UC START# *4607D4480097*
	ContextFilter_var old_context_filter (m_context_filter);
	NodeBase_var current_view (Core::IObject::_duplicate (this->view ()));
	if (refresh) {                                                                        // см. CQ28964
		m_context_filter = 0;
		this->filtrate ();
	}
	m_context_filter = Core::IObject::_duplicate (context);                               // filtrate current 

	FilterList list;
	list.push_back (Core::IObject::_duplicate (m_context_filter. in ()));
	this->truncate_view_i (list);

	if (!m_view->get_child_count ()) {
		m_view = current_view;
		m_context_filter = old_context_filter;
		throw AllContentIsFiltered ();
	} 
	//#UC END# *4607D4480097*
}

void DynList_i::truncate_view_by_query () {
	//#UC START# *4607D439021D*
	if (!m_filters.size ()) {
		return;
	}
	FilterList list;
	list.push_back (QueryFilterFactory::make (m_filters));
	this->truncate_view_i (list);
	//#UC END# *4607D439021D*
}

void DynList_i::truncate_view_by_sort () {
	//#UC START# *4607D4230087*
	SortFilter_var filter = SortFilterFactory::make ();
	filter->set_order (m_sort_params.get ().sort_order);
	filter->set_type (m_sort_params.get ().sort_type);
	FilterList list;
	list.push_back (filter._retn ());
	this->truncate_view_i (list);	
	//#UC END# *4607D4230087*
}

void DynList_i::truncate_view_i (const FilterList& list) {
	//#UC START# *4607D4510365*
	VisibleIndex index;
	NodeBase_var new_view (this->view ()->create_view_ex (list, FM_USER_FLAG_MASK, 0, index, 0, false, false, true));
	//this->view ()->create_view_ex (list, FM_SHARED_ALL, 0, &index, 0, false, false, true, new_view.out ()); //need to be FM_SHARED_ALL, but we have strange error
	m_view = new_view; 
	this->clear_cache ();
	//#UC END# *4607D4510365*
}

NodeBase* DynList_i::view () {
	//#UC START# *4607D65803DF*
	return this->get_root_i ();
	//#UC END# *4607D65803DF*
}

void DynList_i::write_to_log (GblLogging::LogEvent log_event, const DynList_i* dyn_list) const {
	//#UC START# *4607D3C90318*
	try {
		GblLogging::EventData_var data = new GblLogging::EventData ();
		data->length (dyn_list == 0 ? 1 : 2);
		(*data) [0] <<= this->get_cached_server_doc_list ();
		if (dyn_list) {
			(*data) [1] <<= dyn_list->get_cached_server_doc_list ();
		}
		ApplicationHelper::instance ()->get_cached_logging_manager ()->add_event (log_event, data.in ());
	} catch (...) {
		GDS_ASSERT_MSG (false, (GDS_CURRENT_FUNCTION));
	}
	//#UC END# *4607D3C90318*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CatalogBase
CatalogBase* DynList_i::clone () const {
	//#UC START# *45EEBA2C02C0_45741B97005D*
	bool is_need_filtrate = false;
	GTree::Tree_var clone = this->get_actual_server_tree ()->clone (is_need_filtrate);
	GblDocList::DocListTree_var list_clone = GblDocList::DocListTree::_narrow (clone.in ());

	Core::Var<DynList_i> dyn_list = new DynList_i (list_clone.in ());
	if (is_need_filtrate) {
		this->clone_filters (dyn_list.ptr ());
		dyn_list->filtrate ();
	}
	return dyn_list.forget ();

	//#UC END# *45EEBA2C02C0_45741B97005D*
}

// implemented method from CatalogBase
CatalogBase* DynList_i::create (NodesClipboard* nodes) const {
	//#UC START# *45EEBA2C02CB_45741B97005D*
	GTree::Tree_var new_tree (
	 	this->get_actual_server_tree ()->create_new (dynamic_cast<NodesClipboard_i*>(nodes)->node_holder())
	);
	GblDocList::DocListTree_var doc_list_tree = GblDocList::DocListTree::_narrow (new_tree.in ());
	
	const static std::string default_name = NOT_UNICODE_TR("Пользовательский список");
	doc_list_tree->name (default_name.c_str ());
	return new DynList_i (doc_list_tree.in ());
	//#UC END# *45EEBA2C02CB_45741B97005D*
}

// implemented method from CatalogBase
void DynList_i::intersect_tree (const CatalogBase* tree) {
	//#UC START# *45EEBA2C02C5_45741B97005D*
	const DynList_i* dl (dynamic_cast<const DynList_i*>(tree));
	GDS_ASSERT (dl);
	GTree::Tree_var new_tree = this->get_cached_server_doc_list ()->intersect_trees (dl->get_actual_server_tree ());
	this->write_to_log (::GblLogging::LE_INTERSECT, dl);

	if (new_tree->is_empty ()) {
		throw EmptyResult ();
	}
	this->reset_by_server_tree (new_tree.in ());
	ListTree<DynListNode_i>* list = dynamic_cast<ListTree<DynListNode_i>*> (this->get_cached_adapter_tree ());
	list->set_changed (true);
	this->refresh_filters ();
	//#UC END# *45EEBA2C02C5_45741B97005D*
}

// implemented method from CatalogBase
void DynList_i::merge_tree (const CatalogBase* tree) {
	//#UC START# *45EEBA2C02C7_45741B97005D*
	const DynList_i* dl (dynamic_cast<const DynList_i*>(tree));
	GDS_ASSERT (dl);
	GTree::Tree_var new_tree = this->get_cached_server_doc_list ()->merge_trees (dl->get_actual_server_tree ());
	
	this->write_to_log (::GblLogging::LE_MERGE, dl);
	
	if (new_tree->is_empty ()) {
		throw EmptyResult ();
	}
	this->reset_by_server_tree (new_tree.in ());
	ListTree<DynListNode_i>* list = dynamic_cast<ListTree<DynListNode_i>*> (this->get_cached_adapter_tree ());
	list->set_changed (true);
	this->refresh_filters ();
	//#UC END# *45EEBA2C02C7_45741B97005D*
}

// implemented method from CatalogBase
void DynList_i::minus_tree (const CatalogBase* tree) {
	//#UC START# *45EEBA2C02C9_45741B97005D*
	const DynList_i* dl (dynamic_cast<const DynList_i*>(tree));
	GDS_ASSERT (dl);
	GTree::Tree_var new_tree = this->get_cached_server_doc_list ()->substruct_trees (dl->get_actual_server_tree ());

	this->write_to_log (::GblLogging::LE_MINUS, dl);

	if (new_tree->is_empty ()) {
		throw EmptyResult ();
	}
	this->reset_by_server_tree (new_tree.in ());
	ListTree<DynListNode_i>* list = dynamic_cast<ListTree<DynListNode_i>*> (this->get_cached_adapter_tree ());
	list->set_changed (true);
	this->refresh_filters ();
	//#UC END# *45EEBA2C02C9_45741B97005D*
}

// implemented method from DynList
GCI::IO::Stream* DynList_i::as_evd (EVDGeneratorStyle style) const {
	//#UC START# *45EEBA2C02C3_45741B97005D*
	GslDataPipe::DataReading_var data_reading = this->get_actual_server_tree()->get_tree_evd (
		(style == GS_FULL_TREE) ? -1 : 1
		, style == GS_TOPIC_AS_NAME
	);
	return DataReadingStreamFactory::make (data_reading.in ());
	//#UC END# *45EEBA2C02C3_45741B97005D*
}

// implemented method from DynList
const SortTypes& DynList_i::get_available_sort_types () const {
	//#UC START# *45EEDC910011_45741B97005D_GET*
	SortTypes* list = new SortTypes ();
	GblDocList::DocListTree_var stree = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());
	if (CORBA::is_nil (stree)) {
		GDS_ASSERT_MSG (false, ("ses: do you need deferred tree loading?"));
		return *list;
	}
	
	GblPilotDef::SortTypeList_var type_list = stree->available_sort_types ();
	list->reserve (type_list->length ());
	for (size_t i = 0; i < type_list->length (); ++i) {
		list->push_back (ListSortTypeTranslatorSingleton::instance ()->get (type_list[i]));
	}
	return *list;
	//#UC END# *45EEDC910011_45741B97005D_GET*
}

// implemented method from DynList
const DynListContent DynList_i::get_content_type () const {
	//#UC START# *47E229CE0249_45741B97005D_GET*
	switch (m_content_type) {
		case DLCI_LEGAL:
			return DLC_LEGAL_DOCUMENTS;
		case DLCI_MEDIC:
			return DLC_MEDICAL_DOCUMENTS;
		case DLCI_UNKNOWN:
		{
			if (m_type != T_UNKNOWN_IMPL) { 	// это СКР
				m_content_type = DLCI_LEGAL;
				return this->get_content_type ();
			}
			GblDocList::DocListTree_var server_tree = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());
			GDS_ASSERT (!CORBA::is_nil (server_tree) && "we need tree for type definition");
			m_content_type = DocListTypeConvertorSingleton::instance ()->get (server_tree->get_type ());
			GDS_ASSERT (m_content_type != DLCI_UNKNOWN);
			return this->get_content_type ();
		}
		default:
			GDS_ASSERT (false && "unknown content type");
			return DLC_LEGAL_DOCUMENTS;
	}
	GDS_ASSERT (false && "unknown content type");
	return DLC_LEGAL_DOCUMENTS;
	//#UC END# *47E229CE0249_45741B97005D_GET*
}

// implemented method from DynList
const SortParams& DynList_i::get_current_sort_params () const {
	//#UC START# *45EEDC7A0244_45741B97005D_GET*
	return m_sort_params.get ();
	//#UC END# *45EEDC7A0244_45741B97005D_GET*
}

// implemented method from DynList
// получить дерево анализа для списка
NodeBase* DynList_i::get_analysis_tree () const /*throw (CanNotFindData)*/ {
	//#UC START# *4A9F5D2A001F_45741B97005D*
	GblDocList::DocListTree_var doc_list_tree = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());    
	if (CORBA::is_nil (doc_list_tree)) {
		GDS_ASSERT (false && "tree not found");
		return 0;
	}
	
	try {
		GTree::Tree_var analysis_tree = doc_list_tree->get_analysis_tree (this->get_actual_server_tree ());
		ListAnalysisTree_var tree (new ListAnalysisTree (analysis_tree));
		return dynamic_cast<RealNodeRoot*> (tree->root ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}

	GDS_ASSERT (false && "not reachable");
	return 0;
	//#UC END# *4A9F5D2A001F_45741B97005D*
}

// implemented method from DynList
// Получить полный список
void DynList_i::get_full_list (
	SearchProgressIndicator::ProgressIndicatorForSearch* progress
	, SearchProgressIndicator::CancelSearch*& cancel_process
) /*throw (
	CanNotFindData
)*/ {
	//#UC START# *4A28BDFC00F4_45741B97005D*
	if (!this->get_is_short ()) {
		LOG_E (("%s: Operation not supported for full list", GDS_CURRENT_FUNCTION));
		GDS_ASSERT (false);
	}
	GblDocList::ShortDocList_var short_doc_list = GblDocList::ShortDocList::_narrow (this->get_cached_server_tree ());
	GDS_ASSERT (short_doc_list.in ());

	cancel_process = Core::TypeTraits<SearchProgressIndicator::CancelSearch>::Factory::make (
		ApplicationHelper::instance ()->get_cached_search_manager ()
	);

	typedef ProgressIndicatorServant_i<SearchProgressIndicator::ProgressIndicatorForSearch> NewExecutePI;
	
	GCD::ProgressIndicator_var progress_indicator;
	NewExecutePI* new_execute_pi = 0;
	if (progress != 0) {
		new_execute_pi = new NewExecutePI (progress);
		progress_indicator = new_execute_pi->_this ();
		new_execute_pi->_remove_ref ();
	}

	ShortDocList_ami* short_doc_list_i = new ShortDocList_ami (
		progress
		, new_execute_pi
	);
	GblDocList::AMI_ShortDocListHandler_var short_doc_lost_handler = short_doc_list_i->_this ();
	short_doc_list_i->_remove_ref ();

	short_doc_list->sendc_get_full_list (
		short_doc_lost_handler.in ()
		, progress_indicator.in()
	);
	//#UC END# *4A28BDFC00F4_45741B97005D*
}

// implemented method from DynList
// Получить длину полного для базового списка
unsigned long DynList_i::get_full_list_size () const {
	//#UC START# *4B55CF4102BF_45741B97005D*
	if (!this->get_is_short ()) {
		LOG_E (("%s: Operation not supported for full list", GDS_CURRENT_FUNCTION));
		GDS_ASSERT (false);
	}
	GblDocList::ShortDocList_var short_doc_list = GblDocList::ShortDocList::_narrow (this->get_cached_server_tree ());
	GDS_ASSERT (short_doc_list.in ());
	return short_doc_list->get_full_list_size ();
	//#UC END# *4B55CF4102BF_45741B97005D*
}

// implemented method from DynList
// получить "короткое" имя списка, используется при выводе на печать
GCI::IO::String* DynList_i::get_short_name () const {
	//#UC START# *46F8B9280148_45741B97005D*
	GblDocList::DocListTree_var stree = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());
	GDS_ASSERT (stree.in ());

	GCI::IO::String_var short_name = GCI::IO::StringFactory::make (CORBA::String_var (stree->get_short_name ()).in ());
	return short_name._retn ();
	//#UC END# *46F8B9280148_45741B97005D*
}

// implemented method from DynList
const GCI::IO::String& DynList_i::get_history () const {
	//#UC START# *45EEDB730270_45741B97005D_GET*
	//	if (0 == m_history.in ()) {
		if (GTree::Tree_ptr stree = const_cast <DynList_i*> (this)->get_actual_server_tree ()) {
			m_history = GCI::IO::StringFactory::make (CORBA::String_var (stree->get_my_history ()).in ());
		} else {
			GDS_ASSERT (false); //ses: для истории нужна отложенная загрузка дерева?
		}
//	}
	return *m_history.ptr ();
	//#UC END# *45EEDB730270_45741B97005D_GET*
}

GCI::IO::String& DynList_i::get_history () {
	return const_cast<GCI::IO::String&>(((const DynList_i*)this)->get_history ());
}

// implemented method from DynList
bool DynList_i::get_is_filtered () const {
	//#UC START# *45EEDB730271_45741B97005D_GET*
	return !m_filters.empty ();
	//#UC END# *45EEDB730271_45741B97005D_GET*
}

// implemented method from DynList
// Это короткий список (сниппеты)
const bool DynList_i::get_is_short () const {
	//#UC START# *4A28BE1F015C_45741B97005D_GET*
	if (boost::indeterminate (m_is_short_list)) {
		m_is_short_list = 
			(this->get_cached_server_list ()->is_short ());
	}
	return m_is_short_list;
	//#UC END# *4A28BE1F015C_45741B97005D_GET*
}

// implemented method from DynList
// Признак, является ли список сниппетом
const bool DynList_i::get_is_snippet () const {
	//#UC START# *4A77E72900BC_45741B97005D_GET*
	if (boost::indeterminate (m_is_snippet)) {
		m_is_snippet = this->get_cached_server_list ()->is_snippet ();
	}
	return m_is_snippet;
	//#UC END# *4A77E72900BC_45741B97005D_GET*
}

// implemented method from DynList
// Сохранить список или его выделенные элементы в файл.
void DynList_i::save_to_file (const char* path, const NodesClipboard* nodes) const {
	//#UC START# *45EEDB73026D_45741B97005D*
	GblDocList::DocListTree_var doc_list_tree = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());    
	if (CORBA::is_nil (doc_list_tree)) {
		GDS_ASSERT_MSG (false, ("ses: do you need deferred tree loading?"));
		return;
	}
	GCD::XMLText* result (0);
	try {
		result = nodes 
			? 
				doc_list_tree->save_buffer_to_xml (
					(const_cast<NodesClipboard_i*> (dynamic_cast<const NodesClipboard_i*> (nodes)))->node_holder ()
				)
			: doc_list_tree->save_tree_to_xml (this->get_actual_server_tree ());
	} catch (GblDocList::XMLCreationError&) {
		throw CanNotSave ();
	}

	std::ofstream xml_file (path);
	if (!xml_file) {
		LOG_W (("%s: can't create file %s", GDS_CURRENT_FUNCTION, path));
		throw CanNotSave ();
	}
	xml_file.write (reinterpret_cast<const char*> (result->get_buffer ()), result->length ());
	if (!xml_file) {
		LOG_W (("%s: can't write to %s", GDS_CURRENT_FUNCTION, path));
		throw CanNotSave ();
	}
//#UC END# *45EEDB73026D_45741B97005D*
}

// implemented method from DynList
void DynList_i::set_context_filter (ContextFilter* context) {
	//#UC START# *45EEDB73026B_45741B97005D*
	// оболочка в случае снятия фильтра передаёт 0
	if (!context && !m_context_filter.ptr ()) {                         // no new filter
		return;                                                         // no old filter
	}                                                                   // => nothing to do
		
	if (m_context_filter.ptr ()
		&& (!context || !strlen (context->get_context ().get_data ()))                     // no new filter
	) {                                                                                    // remove current 
	  m_context_filter = 0;                                                                // context filter
	  return this->filtrate ();
	}

	std::string new_context (
		context->get_context ().get_data (), context->get_context ().get_length ()
	);
	if (m_context_filter.ptr ()) {
		std::string cur_context (
			m_context_filter->get_context ().get_data (), m_context_filter->get_context ().get_length ()
		);
		
		if (context->get_area () == m_context_filter->get_area ()                              // new filter is 
			&& context->get_order () == m_context_filter->get_order ()                         // equivalent to
			&& cur_context == new_context							                           // current => 
		) {
			return;                                                                            // => nothing to do 
		}

		if (
			!new_context.empty () 
			&& !cur_context.empty () 
			&& (*(new_context.end () - 1)  == '*') 
			&& (*(cur_context.end () - 1) == '*')
		) {                                                                                    // cut '*' in the end
			boost::trim_right_if (new_context, boost::is_any_of("*"));
			boost::trim_right_if (cur_context, boost::is_any_of("*"));
		}
		if (
			(context->get_area () != m_context_filter->get_area ())                            // new filter is
			|| (context->get_order () != m_context_filter->get_order ())                       // not part of current
			|| new_context.find (cur_context)                                                  // current => 
		) {
			return this->truncate_view_by_context (context, true);	                           // => set new filter
		}
	}
		
	this->truncate_view_by_context (context, false);                                           // filtrate current state
	//#UC END# *45EEDB73026B_45741B97005D*
}

// implemented method from DynList
void DynList_i::set_list_storage (GblFolders::SavedList* saved_list) {
	//#UC START# *4763CDEB02F8_45741B97005D*
	m_saved_list = GblFolders::SavedList::_duplicate (saved_list);
	//#UC END# *4763CDEB02F8_45741B97005D*
}

// implemented method from DynList
void DynList_i::sort (const SortParams& params) {
	//#UC START# *45EEDB730269_45741B97005D*
	if (m_sort_params.get ().sort_order != params.sort_order
		|| m_sort_params.get ().sort_type != params.sort_type
	) {
		m_sort_params.get () = params;
		this->truncate_view_by_sort ();
	}
	//#UC END# *45EEDB730269_45741B97005D*
}

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* DynList_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_45741B97005D*
	if (
		((Defines::CT_SAVED_LIST == storage->get_content_type ()) 
		&& (this->get_content_type () == DLC_LEGAL_DOCUMENTS))
		|| ((Defines::CT_SAVED_PHARM_LIST == storage->get_content_type ()) 
		&& (this->get_content_type () == DLC_MEDICAL_DOCUMENTS))
	) {
		if (!dynamic_cast <FoldersNode*> (storage)) {
			throw CanNotSave ();
		}
		GblFolders::SavedList_var sl (
			GblFolders::SavedList::_narrow (storage->get_cached_content ())
		);
		sl->append (this->get_actual_server_tree ());
		return 0;
	}

	GDS_ASSERT (false); // not reached
	throw CanNotSave ();
	//#UC END# *456EB3E1017A_45741B97005D*
}

// implemented method from EntityBase
// идентификатор
const unsigned long DynList_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_45741B97005D_GET*
	return this->get_is_saved () ? m_saved_list->id () : throw NotSaved ();
	//#UC END# *456EE084033C_45741B97005D_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool DynList_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_45741B97005D_GET*
//	NodeBase_cvar root = this->get_root ();
	return !this->get_cached_root () ? false : this->get_cached_adapter_tree ()->get_is_changed ();
	//#UC END# *456EB3E1017D_45741B97005D_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool DynList_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_45741B97005D_GET*
	return ContentChecker::check_content (m_saved_list);
	//#UC END# *456EB3E1017C_45741B97005D_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* DynList_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_45741B97005D*
	if (!storage) {
		if (ContentChecker::check_server_content (m_saved_list.in ())) {
			//this->save_data ();
			m_saved_list->save (this->get_actual_server_tree ());
			
//			NodeBase_cvar root (this->get_root ());

			if (this->get_cached_root ()) {
				this->get_cached_adapter_tree ()->set_changed (false);
			}	
		} else {
			throw NotSaved ();
		}
		return 0;
	}

	FoldersNode* fn = dynamic_cast <FoldersNode*> (storage);
	if (!fn) {
		throw CanNotSave ();
	}
	switch (storage->get_content_type ()) {
		case Defines::CT_FOLDER:
			return fn->add_child_node (static_cast<DynList*> (this));
		case Defines::CT_SAVED_LIST:
		case Defines::CT_SAVED_PHARM_LIST:
			m_saved_list = GblFolders::SavedList::_narrow (storage->get_cached_content ());
			this->set_name (GCI::IO::String_var (GCI::IO::StringFactory::make (CORBA::String_var (m_saved_list->get_name ()).in ())).in ());
			m_saved_list->save (this->get_actual_server_tree ());
			//this->save_data ();
			return 0;
	}

	GDS_ASSERT (false); // not reached
	throw CanNotSave ();
	//#UC END# *456EB3E10178_45741B97005D*
}

// implemented method from Filterable
const FiltersFromQuery& DynList_i::get_active_filters () const {
	//#UC START# *45EEB18401B0_45741B97005D_GET*
	return m_filters;
	//#UC END# *45EEB18401B0_45741B97005D_GET*
}

// implemented method from Filterable
// Добавляет INode (из дерева папок) как фильтр.
// Если auto_refresh = true (значение по умолчанию), то
// операция приводит к перефильтрации объекта.
void DynList_i::add_filter (
	FilterFromQuery* filter
	, bool auto_refresh
) /*throw (
	AllContentIsFiltered
	, NotAllAttributesRestored
)*/ {
	//#UC START# *45EEB02C03AA_45741B97005D*
	m_history = 0;	
	
	this->write_to_log (::GblLogging::LE_LIST_FILTRATE, 0);

	size_t length = m_filters.size ();
	
	for (size_t i = 0; i < length; ++i) {
		if (m_filters[i]->is_same (filter)) { 
			return;                                    // don't save the same filter twice
		}
	}

	if (!this->check_filter (filter)) {
		throw NotAllAttributesRestored ();
	}

	m_filters.push_back (Core::IObject::_duplicate (filter));
	FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
	usage_counter->add (filter);

	if (auto_refresh) {
		this->truncate_view_by_query ();
		if (!m_view->get_child_count ()) {
			throw AllContentIsFiltered ();
		}
	}
	//#UC END# *45EEB02C03AA_45741B97005D*
}

// implemented method from Filterable
// Добавляет пачку фильтров с одновременным их применением. При этом эта пачка либо целиком
// применяется, либо (в случае, если все документы отфильтрованы) целиком отклоняется.
// 
// Если выясняется, что на сервере нет данных для построения списка, т.е. списка как такового нет
// (см. К244711732), летит CanNotFindData.
void DynList_i::apply_filters (const FiltersFromQuery& filters) /*throw (CanNotFindData, AllContentIsFiltered)*/ {
	//#UC START# *45EEB02C03B2_45741B97005D*
	size_t f_count = filters.size ();
	if (!f_count) {
		return; 
	}

	size_t prev_length = m_filters.size ();

	// add if doesn't already exist 
	for (size_t i = 0; i < f_count; ++i) {
		size_t length = m_filters.size ();
		size_t j = 0;
		for (;j < length; ++j) {
			if (m_filters[j]->is_same (filters[i].ptr ())) { 
				break;
			}
		}

		if (j == length && this->check_filter (const_cast <FilterFromQuery*> (filters[i].in ()))) { // FIXME: const_cast
			m_filters.push_back (filters[i]);
			FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
			usage_counter->add (filters[i].in ());
		}
	}

	if (prev_length == m_filters.size ()) {		// all new filters already exist
		return;
	}

	{
		// Логируем применение фильтра во время поиска
		::GblLogging::add_event_without_data (::GblLogging::LE_SEARCH_WITH_FILTER);
	}
	
	if (m_filters.size () == 1) {
		this->truncate_view_by_query ();
	} else {
		this->filtrate();
	}

	if (!m_view->get_child_count ()) {
		throw AllContentIsFiltered ();
	}
	//#UC END# *45EEB02C03B2_45741B97005D*
}

// implemented method from Filterable
// Удаляет все фильтры. В результате операции объект переходит в состояние, соответвующее
// отсутствию фильтров
void DynList_i::clear_filters () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB02C03B0_45741B97005D*
	FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
	for (FiltersFromQuery::const_iterator it = m_filters.begin (); it != m_filters.end (); ++it) {
		usage_counter->remove (it->in ());
	}
	m_filters.clear ();
	this->filtrate();
	//#UC END# *45EEB02C03B0_45741B97005D*
}

// implemented method from Filterable
// Удаляет фильтр из списка активных фильтров объекта. Если auto_refresh = true (значение по
// умолчанию), то операция приводит к перефильтрации объекта.
void DynList_i::delete_filter (
	const FilterFromQuery* filter
	, bool auto_refresh
) /*throw (
	CanNotFindData
	, AllContentIsFiltered
)*/ {
	//#UC START# *45EEB02C03AD_45741B97005D*
	this->write_to_log (::GblLogging::LE_LIST_FILTRATE, 0);
	
	this->do_delete_filter (filter);
	if (auto_refresh) {
		this->filtrate ();
		if (!m_view->get_child_count ()) {
			throw AllContentIsFiltered ();
		}
	}
	//#UC END# *45EEB02C03AD_45741B97005D*
}

// implemented method from Filterable
bool DynList_i::get_has_active_filters () const {
	//#UC START# *45EEB02C03B4_45741B97005D_GET*
	return m_filters.size () ? true : false;
	//#UC END# *45EEB02C03B4_45741B97005D_GET*
}

// implemented method from Filterable
void DynList_i::refresh_filters () /*throw (CanNotFindData, AllContentIsFiltered)*/ {
	//#UC START# *45EEB02C03B1_45741B97005D*
	this->filtrate ();
	
	if (!m_view->get_child_count ()) {
		throw AllContentIsFiltered ();
	}
	//#UC END# *45EEB02C03B1_45741B97005D*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from CatalogBase
const GCI::IO::String& DynList_i::get_name () const {
	//#UC START# *45EEBA2C02CD_45741B97005D_GET*
	// todo переделать
	if (!m_name_initialized) {
		GblDocList::DocListTree_var stree = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());
		GDS_ASSERT (stree.in ());
		const_cast<DynList_i*> (this)->ListCatalogBase::set_name (GCI::IO::String_var (GCI::IO::StringFactory::make (CORBA::String_var (stree->name ()))).in ());
		m_name_initialized = true;
	}
	return this->ListCatalogBase::get_name ();
	//#UC END# *45EEBA2C02CD_45741B97005D_GET*
}

GCI::IO::String& DynList_i::get_name () {
	return const_cast<GCI::IO::String&>(((const DynList_i*)this)->get_name ());
}

void DynList_i::set_name (GCI::IO::String* name) {
	//#UC START# *45EEBA2C02CD_45741B97005D_SET*
	GblDocList::DocListTree_var stree = GblDocList::DocListTree::_narrow (this->get_cached_server_tree ());
	GDS_ASSERT (stree.in ());
	stree->name (name->get_data ());
	ListCatalogBase::set_name (name);
	//#UC END# *45EEBA2C02CD_45741B97005D_SET*
}

// overloaded method from CatalogBase
const NodeBase* DynList_i::get_root () const {
	//#UC START# *45F6906C03C8_45741B97005D_GET*
	return Core::IObject::_duplicate (const_cast<DynList_i*> (this)->get_root_i ());
	//#UC END# *45F6906C03C8_45741B97005D_GET*
}

// overloaded method from CatalogBase_i<NodeType_>
GTree::Tree* DynList_i::get_cached_server_tree () const {
	//#UC START# *45F7E8A0038A_45741B97005D*
	GDS_ASSERT (!CORBA::is_nil (this->get_cached_server_list ()));
	return this->get_cached_server_list ();
	//#UC END# *45F7E8A0038A_45741B97005D*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

