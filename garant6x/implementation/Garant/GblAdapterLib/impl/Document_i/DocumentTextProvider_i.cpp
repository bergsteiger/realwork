////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentTextProvider_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i.h"

//#UC START# *4C5ADDD20234_CUSTOM_INCLUDES*
#include "boost/lexical_cast.hpp"
#include "boost/foreach.hpp"
#include "common/components/rtl/Garant/EVD/evddata.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/PrefixTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
//#UC END# *4C5ADDD20234_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4C5ADDD20234*
class FlatFacade : virtual public ServerTextProviderFacade {
	SET_OBJECT_COUNTER (FlatFacade)

public:
	FlatFacade (GblPilot::Document* doc, const GblPilot::HighlightHandle& highlight_handle)
		: m_doc (GblPilot::FlatDocument::_narrow (doc))
		, m_highlight_handle (highlight_handle)	{
		GDS_ASSERT (!CORBA::is_nil (m_doc));
		ApplicationHelper::instance ()->get_cached_life_cycle_manager()->duplicate_object (m_doc);
	}
	
	~FlatFacade () {
		m_doc->release_highlight (m_highlight_handle);
		try {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_doc);
		} catch (CORBA::TRANSIENT&) { // CORBA::TRANSIENT ignored
		} catch (...) {
			GDS_ASSERT ((false, "Unknown exception catched"));
		}
	}
	
	virtual GblPilot::DocItemList* get_range (CORBA::ULong id, CORBA::ULong from, CORBA::ULong count) {
		return m_doc->get_range (id, from, count, m_highlight_handle);
	}

	virtual GblPilot::BranchList* get_all_branches () {
		return m_doc->get_all_branches (m_highlight_handle);
	}

	virtual GTree::NodeIndexPath* find_para (CORBA::ULong id) {
		return m_doc->find_para (id);
	}

	virtual	GTree::NodeIndexPath* find_block_or_sub (CORBA::ULong id) {
		return m_doc->find_block_or_sub (id);
	}

	virtual GblPilot::ContextList* find_contexts (const char* words, CORBA::Long from_id) {
		return m_doc->find_contexts (words, from_id);
	}

	virtual void set_comment (CORBA::ULong para_id, const GCD::SeqOctet & comment) {
		m_doc->set_comment (para_id, comment);
	}

	virtual void remove_comment (CORBA::ULong para_id) {
		m_doc->remove_comment (para_id);
	}

	virtual GblPilot::TechCommentList* tech_comments () {
		GblPilot::LegalDocument_var doc = GblPilot::LegalDocument::_narrow (m_doc);
		return CORBA::is_nil (doc) ? 0 : doc->tech_comments ();
	}
	
	virtual GTree::Tree* get_prefix_tree_by_block (ExternalID id) {
		return m_doc->get_prefix_tree_by_block (id);
	}
	
	virtual GblPilot::BlockInfoList* get_info_for_all_blocks () {
		return m_doc->get_info_for_all_blocks ();
	}

private:
	GblPilot::FlatDocument_var m_doc;
	GblPilot::HighlightHandle m_highlight_handle;
};

class CompoundFacade : virtual public ServerTextProviderFacade {
	SET_OBJECT_COUNTER (CompoundFacade)
public:
	CompoundFacade (GblPilot::Document* doc, unsigned int handle)
		: m_doc (GblPilot::CompoundDocument::_narrow (doc))
		, m_handle (handle) {
		// Achtung! Тут мы не увеличиваем RemoteRefCount на серверном документе, поэтому теоретически,
		//          если оболочка отпустит документ автореферата, а потом с будет пытаться почитать текст
		//          из TextProvider'а может случиться вызов на умершем серверном документе
		//          Вызов duplicate_object убран, т.к. автореферат может содежать много-много тысяч TextProvider'ов,
		//          оболочка получает их все сразу, что приводит к большому кол-ву серверных вызовов
		GDS_ASSERT (!CORBA::is_nil (m_doc));
	}

	virtual GblPilot::DocItemList* get_range (CORBA::ULong id, CORBA::ULong from, CORBA::ULong count) {
		return m_doc->get_range (m_handle, id, from, count);
	}

	virtual GblPilot::BranchList* get_all_branches () {
		return m_doc->get_all_branches (m_handle);
	}

	virtual GTree::NodeIndexPath* find_para (CORBA::ULong id) {
		return m_doc->find_para (m_handle, id);
	}

	virtual	GTree::NodeIndexPath* find_block_or_sub (CORBA::ULong id) {
		return m_doc->find_block_or_sub (m_handle, id);
	}

	virtual GblPilot::ContextList* find_contexts (const char* words, CORBA::Long from_id) {
		return m_doc->find_contexts_in_part (m_handle, words, from_id);
	}

	virtual void set_comment (CORBA::ULong para_id, const GCD::SeqOctet& comment) {
		GDS_ASSERT (false);
	}

	virtual void remove_comment (CORBA::ULong para_id) {
		GDS_ASSERT (false);
	}
	
	virtual GblPilot::TechCommentList* tech_comments () {
		return 0;
	}

	virtual GTree::Tree* get_prefix_tree_by_block (ExternalID id) {
		return 0;
	}
	
	virtual GblPilot::BlockInfoList* get_info_for_all_blocks () {
		return new GblPilot::BlockInfoList ();
	}

private:
	GblPilot::CompoundDocument_var m_doc;
	unsigned int m_handle;
};




DocItem::DocItem(const GblPilot::DocItem& sit)
	: m_type (sit.para_list_type)
	, m_layer (sit.id)
	, m_id (sit.para_list_id)	{

	m_evd_style = MemoryStreamFactory::make (sit.style, true /*with_copy*/);
	if (strlen (sit.text.data.in ())) {
		m_text = GCI::IO::StringFactory::create (sit.text.data.in (), sit.text.enc);
	}

}

EVDType DocItem::type () const {
	return m_type;
}

LayerID DocItem::layer () const {
	return m_layer;
}

ExternalID DocItem::id () const {
	return m_id;
}

const EVDStream* DocItem::style () const {
	return Core::IObject::_duplicate (m_evd_style.in ());
}

void DocItem::kill_style () {
	m_evd_style = 0;
}

const GCI::IO::String* DocItem::text () const {
	return m_text.is_nil () ? 0 : Core::IObject::_duplicate (m_text.in ());
}

void DocItem::kill_text () {
	m_text = 0;
}

const std::vector <unsigned long>* DocItem::sub_list () const {
	return 0;
}

void DocItem::set_comment_flag () {
}

void DocItem::reset_comment_flag () {
}


LayerItem::LayerItem (const GblPilot::DocItem& sit)
	: DocItem (sit)
	, m_children_count (sit.children_count)
	, m_all_leaf_children_count (sit.all_leaf_children_count) {
}

char LayerItem::flags () const {
	return 0;
}

size_t LayerItem::children_count () const {
	return m_children_count;
}

size_t LayerItem::all_leaf_children_count () const {
	return m_all_leaf_children_count;
}



LeafItem::LeafItem (const GblPilot::DocItem& sit) : DocItem (sit), m_flags (0) {

	if (sit.comments.length ()) {
		m_flags |= LF_HAS_COMMENTS; 
	}

	if (sit.bookmarks.length ()) {
		m_flags |= LF_HAS_BOOKMARKS; 
	}
}

char LeafItem::flags () const {
	return m_flags;
}


void LeafItem::set_comment_flag () {
	m_flags |= LF_HAS_COMMENTS; 
}

void LeafItem::reset_comment_flag () {
	m_flags &= ~LF_HAS_COMMENTS; 
}

size_t LeafItem::children_count () const {
	return 0;
}

size_t LeafItem::all_leaf_children_count () const {
	return 0;
}

LeafItemWithSubs::LeafItemWithSubs (const GblPilot::DocItem& sit)
	: LeafItem (sit)
	, m_sub_list (sit.sub_list.get_buffer (), sit.sub_list.get_buffer () + sit.sub_list.length ()) {
}

const std::vector <unsigned long>* LeafItemWithSubs::sub_list () const {
	return m_sub_list.empty () ? 0 : &m_sub_list;
}


void DocumentTextProvider_i::load_all_branches () {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
	GDS_ASSERT (m_items.empty ());
	GblPilot::BranchList_var branch_list = m_facade->get_all_branches ();
	for (size_t i = 0, length = branch_list->length (); i < length; ++i) {
		EntryPoint entry_point (branch_list [i].id, 0);
		for (size_t j = 0, len =  branch_list [i].list.length (); j < len; ++j) {
			this->make_item (entry_point, branch_list [i].list [j]);
			++(entry_point.child);
		}
	}
}

DocItem& DocumentTextProvider_i::load_item (const EntryPoint& id) {
	const size_t count = 50;
	try {
		GblPilot::DocItemList_var list = m_facade->get_range (id.layer, id.child, count);
		size_t length = list->length ();
		GDS_ASSERT (length);

		EntryPoint entry_point = id;
		for (size_t i = 0; i < length; ++i) {
			if (m_items.find (entry_point) == m_items.end ()) {
				this->make_item (entry_point, list [i]);
				++(entry_point.child);
			}	else {
				break;
			}
		}
	  
		ItemMap::iterator it = m_items.find (id);
		GDS_ASSERT (it != m_items.end ());
		return *(it->second);
		
	} catch (CORBA::TRANSIENT&) {
		throw GblAdapterLib::NoServer ();
	} catch (CORBA::Exception&) {
		throw InvalidEntryPoint ();
	}
}


void make_bookmark_list (const GblPilotDef::BookmarkItemList& bookmarks, BookmarkList& list) {
	list.resize (bookmarks.length ());
	for (CORBA::ULong i = 0, length = bookmarks.length (); i < length; ++i) {
		list [i].name    = GCI::IO::StringFactory::make (bookmarks [i].m_name);
		list [i].para_id = bookmarks [i].m_para; 
		list [i].eid     = bookmarks [i].m_id; 
	}
}

void DocumentTextProvider_i::make_item (const EntryPoint& id, const GblPilot::DocItem& sit) {
	DocItem_var item;
	if (evd::is_leaf_para (sit.para_list_type)) {
		item = sit.sub_list.length () ? new LeafItemWithSubs (sit) : new LeafItem (sit);
	} else {
		item = new LayerItem (sit);
	}

	std::pair<ItemMap::iterator, bool> items_ins = m_items.insert (std::make_pair (id, item));
	GDS_ASSERT (items_ins.second);

	LayerID layer_id = sit.id;
	std::pair<LayerMap::iterator, bool> layers_ins = m_layers.insert (std::make_pair (layer_id, items_ins.first));
	GDS_ASSERT (layers_ins.second);

	if (item->flags () & LF_HAS_COMMENTS) {
		EVDStream_var stream = MemoryStreamFactory::make (sit.comments, true /*with_copy*/);
		std::pair<CommentMap::iterator, bool> comments_ins = m_comments.insert (std::make_pair (id, stream));
		GDS_ASSERT (comments_ins.second);
	}

	if (item->flags () & LF_HAS_BOOKMARKS) {
		BookmarkList list;
		make_bookmark_list (sit.bookmarks, list);
		std::pair<BookmarkMap::iterator, bool> bookmaks_ins = m_bookmarks.insert (std::make_pair (id, list));
		GDS_ASSERT (bookmaks_ins.second);
	}
}

DocItem& DocumentTextProvider_i::get_item (const EntryPoint& id) {
	ItemMap::iterator it = m_items.find (id);
	return it == m_items.end () ? this->load_item (id) : *(it->second);
}

const DocItem& DocumentTextProvider_i::get_item (LayerID layer_id) {
	LayerMap::const_iterator it = m_layers.find (layer_id);
	if (it == m_layers.end ()) {
		throw InvalidLayerID ();
	}
	return *(it->second->second);
}

void DocumentTextProvider_i::kill_text (const EntryPoint& id) {
	ItemMap::iterator it = m_items.find (id);
	if (it != m_items.end ()) {
		it->second->kill_text ();
	}
}

void DocumentTextProvider_i::kill_style (const EntryPoint& id) {
	ItemMap::iterator it = m_items.find (id);
	if (it != m_items.end ()) {
		it->second->kill_style ();
	}
}

void print_children (int level, const GblPilot::DocItemList& list, ServerTextProviderFacade* facade) {
	std::string tab = std::string (++level, '\t');
	
	for (size_t i = 0, len = list.length (); i < len; ++i) {
		const GblPilot::DocItem& doc_item = list[i];
		LOG_D (("%s %.8X [%d] %s", tab.c_str (), doc_item.id, doc_item.children_count, doc_item.text.data.in () ));
		if (doc_item.children_count) {
			GblPilot::DocItemList_var list = facade->get_range (doc_item.id, 0, doc_item.children_count);
			print_children (level, list.in (), facade);
		}
		//doc_item.id
		//doc_item.para_list_type
		//doc_item.para_list_id
		//doc_item.para_num +
		//doc_item.children_count
		//doc_item.all_leaf_children_count
	}
}

void DocumentTextProvider_i::dump_server_tree () {
	GblPilot::DocItemList_var list = m_facade->get_range (ROOT_LAYER, 0, 1);
	print_children (0, list.in (), m_facade.ptr ());
}

void DocumentTextProvider_i::dump_entry_point (const EntryPoint& id, int level) {

	this->dump (id, level++);
	
	LayerID                layer = this->get_child_layer_id (id);
	unsigned long children_count = this->children_count (layer);
	
	for (size_t i = 0; i < children_count; ++i) {
		this->dump_entry_point (EntryPoint (layer, i), level);
	}
}

void DocumentTextProvider_i::dump (const EntryPoint& id, int level) {

	EVDStream_cvar           style = this->get_item (id).style ();
	ExternalID         external_id = this->get_child_external_id (id);
	LayerID                  layer = this->get_child_layer_id (id);
	GCI::IO::String_cvar      text = this->get_item (id).text ();
	EVDType                   type = this->get_child_type (id);

	unsigned long all_leaf_children_count = this->all_leaf_para_count (layer);
	unsigned long children_count         = this->children_count (layer);

	std::string index_path;
	if (type == evd::id_TextPara && external_id) {
		Core::Box <NodeIndexPath> path = this->find_para (external_id);
		for (size_t i = 0; i < path->size (); ++i) {
			index_path += ":" + boost::lexical_cast <std::string> (path->at (i));
		}
	}

	if (type == evd::id_Block && external_id) {
		Core::Box <NodeIndexPath> path = this->find_block_or_sub (external_id);
		for (size_t i = 0; i < path->size (); ++i) {
			index_path += ":" + boost::lexical_cast <std::string> (path->at (i));
		}
	}

	std::string sublist;
	Core::Box <SubList> sub_list = this->get_sub_list (id);
	for (size_t i = 0; i < sub_list->size (); ++i) {
		sublist += " " + boost::lexical_cast <std::string> (sub_list->at (i));
	}
	

	std::string tab = std::string (level, '\t');
	std::string txt = text.is_nil () ? "" : text->get_data ();
	LOG_D (("%s %.8X [%d:%d] {%d} %s (%s) ((%s))", tab.c_str (), layer, type, external_id, children_count, txt.c_str (), index_path.c_str (), sublist.c_str () ));
}

void DocumentTextProvider_i::test_find_context (const char * text, ExternalID from_id) {
	try {
		GCI::IO::String_var words = GCI::IO::StringFactory::make (text);
		FoundContext_var fc = this->find_context (words.in (), from_id);
		const ContextList& list = fc->get_list ();
		BOOST_FOREACH (const FragmentList& item, list) {
			std::string path;
			for (size_t i = 0; i < item.size (); ++i) {
				path += "{";
				for (size_t j = 0; j < item [i].path.size (); ++j) {
					path += boost::lexical_cast<std::string> (item [i].path[j]) + ":";
				}
				path [path.size () - 1] = '}';
				LOG_D (("%s [%d:%d]", path.c_str (), item [i].start, item [i].finish));
			}
			LOG_D (("----------------------------------------------------------------"));
		}
	} catch (CanNotFindData&)	{
		LOG_D (("context not found"));
	}
}


NodeIndexPath* translate_server_path (const GTree::NodeIndexPath& server_path) {
	return new NodeIndexPath (server_path.get_buffer (), server_path.get_buffer () + server_path.length ());
}

void translate_server_path (const GTree::NodeIndexPath& server_path, NodeIndexPath& path) {
	path.swap (NodeIndexPath (server_path.get_buffer (), server_path.get_buffer () + server_path.length ()));
}

void DocumentTextProvider_i::load_tech_comments_if_empty () {
	if (m_tech_comments_loaded) {
		return;
	}
	
	GblPilot::TechCommentList_var comments = m_facade->tech_comments ();
	if (!comments.ptr ()) {
		return;
	}
	
	for (size_t i = 0, length = comments->length (); i < length; ++i) {
		m_tech_comments [comments [i].id] = GCI::IO::StringFactory::make (comments [i].comment);
	}
	
	m_tech_comments_loaded = true;
}

const std::vector <unsigned long> DocumentTextProvider_i::s_empty_sub_list;

const GblPilot::BlockInfo*  DocumentTextProvider_i::get_block_info_by_id (ExternalID id) {
	if (!m_cache_loaded) {
		m_cache = m_facade->get_info_for_all_blocks ();
		m_cache_loaded = true;
	}
	GDS_ASSERT (m_cache.ptr ());
	const GblPilot::BlockInfo* begin = m_cache->get_buffer ();
	const GblPilot::BlockInfo* end = m_cache->get_buffer () + m_cache->length ();
	const GblPilot::BlockInfo* result = std::lower_bound (begin, end, id, BlockInfoLess ());

	if (result == end || result->block != id) {
		return 0;
	}

	return result;
}


//#UC END# *4C5ADDD20234*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentTextProvider_i::DocumentTextProvider_i (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
)
//#UC START# *4C5AA5CA02DF_4C5ABE960168_4C5ADDD20234_BASE_INIT*
	: m_facade (new FlatFacade (server_doc, handle)), m_tech_comments_loaded (false), m_cache_loaded (false)
//#UC END# *4C5AA5CA02DF_4C5ABE960168_4C5ADDD20234_BASE_INIT*
{
	//#UC START# *4C5AA5CA02DF_4C5ABE960168_4C5ADDD20234_BODY*
	if (all_at_once) {
		this->load_all_branches ();
	}

	// this->dump_server_tree ();                               // {{{ test
	// this->dump_entry_point (EntryPoint (ROOT_LAYER, 0), 0);
	// this->test_find_context ("РФ", 1);												// }}}

	//#UC END# *4C5AA5CA02DF_4C5ABE960168_4C5ADDD20234_BODY*
}

DocumentTextProvider_i::DocumentTextProvider_i (
	GblPilot::Document* server_doc
	, unsigned long handle
	, bool all_at_once
)
//#UC START# *4C5AA5CA02DF_4CED497B0316_4C5ADDD20234_BASE_INIT*
	: m_facade (new CompoundFacade (server_doc, handle)), m_tech_comments_loaded (false), m_cache_loaded (false)
//#UC END# *4C5AA5CA02DF_4CED497B0316_4C5ADDD20234_BASE_INIT*
{
	//#UC START# *4C5AA5CA02DF_4CED497B0316_4C5ADDD20234_BODY*
	if (all_at_once) {
		this->load_all_branches ();
	}
	
	// {{{ test
	// this->dump_entry_point (EntryPoint (ROOT_LAYER, 0), 0);
	// this->test_find_context ("президент", 1);												
	// }}}
	//#UC END# *4C5AA5CA02DF_4CED497B0316_4C5ADDD20234_BODY*
}

DocumentTextProvider_i::~DocumentTextProvider_i () {
	//#UC START# *4C5ADDD20234_DESTR_BODY*
	//#UC END# *4C5ADDD20234_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocumentTextProvider
unsigned long DocumentTextProvider_i::all_leaf_para_count (LayerID layer_id) /*throw (InvalidLayerID)*/ {
	//#UC START# *4C5ABA2E0009_4C5ADDD20234*
	return this->get_item (layer_id).all_leaf_children_count ();
	//#UC END# *4C5ABA2E0009_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
unsigned long DocumentTextProvider_i::children_count (LayerID layer_id) /*throw (InvalidLayerID)*/ {
	//#UC START# *4C5ABAED00E5_4C5ADDD20234*
	LOG_D (("%s: LayerID: 0x%08X", GDS_CURRENT_FUNCTION, layer_id));
	return this->get_item (layer_id).children_count ();
	//#UC END# *4C5ABAED00E5_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
const NodeIndexPath& DocumentTextProvider_i::find_block_or_sub (ExternalID id) /*throw (CanNotFindData)*/ {
	//#UC START# *4C5ABB37029A_4C5ADDD20234*
	
	BlockOrSubPathCache::const_iterator it = m_block_or_sub_cache.find (id);
	if (it != m_block_or_sub_cache.end ()) {
		return it->second;
	}
	
	GTree::NodeIndexPath_var server_path;
	try {
		server_path = m_facade->find_block_or_sub (id);
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();	
	}
	
	translate_server_path (server_path.in (), m_block_or_sub_cache [id]);
	return m_block_or_sub_cache [id];
	//#UC END# *4C5ABB37029A_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
FoundContext* DocumentTextProvider_i::find_context (
	const GCI::IO::String* context
	, ExternalID from_id
) /*throw (
	CanNotFindData
)*/ {
	//#UC START# *4C5ABBC300BE_4C5ADDD20234*
	GblPilot::ContextList_var list = m_facade->find_contexts (context->get_data (), from_id);
	if (list->length ()) {
		return FoundContextFactory::make (list.in ());
	}
	throw CanNotFindData ();
	//#UC END# *4C5ABBC300BE_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
NodeIndexPath* DocumentTextProvider_i::find_para (ExternalID id) /*throw (CanNotFindData)*/ {
	//#UC START# *4C5ABB88003B_4C5ADDD20234*
	GTree::NodeIndexPath_var server_path;
	try {
		server_path = m_facade->find_para (id);
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	return translate_server_path (server_path.in ());
	//#UC END# *4C5ABB88003B_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
const BookmarkList& DocumentTextProvider_i::get_child_bookmarks (
	const EntryPoint& id
) /*throw (
	EmptyResult
	, InvalidEntryPoint
)*/ {
	//#UC START# *4C5AB8BF0144_4C5ADDD20234*
	if (this->get_item (id).flags () & LF_HAS_BOOKMARKS) {
		BookmarkMap::iterator it = m_bookmarks.find (id);
		GDS_ASSERT (it != m_bookmarks.end ());
		return it->second;
	}
	
	throw EmptyResult ();
	//#UC END# *4C5AB8BF0144_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
const EVDStream* DocumentTextProvider_i::get_child_comment (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB83001A2_4C5ADDD20234*
	if (this->get_item (id).flags () & LF_HAS_COMMENTS) {
		CommentMap::iterator it = m_comments.find (id);
		GDS_ASSERT (it != m_comments.end ());
		return Core::IObject::_duplicate (it->second.in ());
	}
	return 0;
	//#UC END# *4C5AB83001A2_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
ExternalID DocumentTextProvider_i::get_child_external_id (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB6D90193_4C5ADDD20234*
	return this->get_item (id).id ();
	//#UC END# *4C5AB6D90193_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
LayerID DocumentTextProvider_i::get_child_layer_id (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB68E0235_4C5ADDD20234*
	return this->get_item (id).layer ();
	//#UC END# *4C5AB68E0235_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
GCI::IO::String* DocumentTextProvider_i::get_child_tech_comment (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4D09D82502D2_4C5ADDD20234*
	this->load_tech_comments_if_empty ();
	
	const DocItem& item = this->get_item (id);
	
	if ( evd::INHERITS[item.type ()][evd::id_Table]
		|| evd::INHERITS[item.type ()][evd::id_TableRow]
		|| evd::INHERITS[item.type ()][evd::id_TableCell]
	) {
		return 0;
	}

	if (evd::INHERITS[item.type ()][evd::id_Block]) {
		TechCommentsMap::iterator it = m_tech_comments.find (item.type () == evd::id_Document ? 0 : item.id ());
		return it == m_tech_comments.end () ? 0 : Core::IObject::_duplicate (it->second.ptr ());
	}
	
	const SubList& sub_list = this->get_sub_list (id);
	if (sub_list.size ()) {
		// TODO: склеить технические комментарии для всех сабов, сейчас берем для первого (в 99.9999999% он там один - единственный):
		TechCommentsMap::iterator it = m_tech_comments.find (sub_list [0]);
		return it == m_tech_comments.end () ? 0 : Core::IObject::_duplicate (it->second.ptr ());
	}
	
	return 0;
	//#UC END# *4D09D82502D2_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
EVDType DocumentTextProvider_i::get_child_type (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB62C02FC_4C5ADDD20234*
	return this->get_item (id).type ();
	//#UC END# *4C5AB62C02FC_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
NodeBase* DocumentTextProvider_i::get_prefix_tree (ExternalID id) {
	//#UC START# *4D0F9F6500F6_4C5ADDD20234*
	CorrespondentTreeCache::iterator found = m_tree_cache.find (id);
	if (found != m_tree_cache.end ()) {
		return dynamic_cast<NodeBase*> (found->second._sretn ());
	}
	GTree::Tree_var server_tree = m_facade->get_prefix_tree_by_block (id);
	server_tree = m_facade->get_prefix_tree_by_block (id);
	if (CORBA::is_nil (server_tree)) {
		m_tree_cache [id] = 0;
		return 0;
	} 
	Core::Var <PrefixTree> adapter_tree = new PrefixTree (server_tree.in ());
	GCL::StaticNode* root = adapter_tree->root ();
	m_tree_cache [id] = GCL::StaticNode::_duplicate (root);
	return dynamic_cast<NodeBase*> (root);
	//#UC END# *4D0F9F6500F6_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
const SubList& DocumentTextProvider_i::get_sub_list (const EntryPoint& id) {
	//#UC START# *4C9B414301FB_4C5ADDD20234*
	if (const std::vector <unsigned long>* list = this->get_item (id).sub_list ()) {
		return *list;
	}
	
	return DocumentTextProvider_i::s_empty_sub_list;
	//#UC END# *4C9B414301FB_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
// Если есть похожие к sub вернет true, иначе false.
bool DocumentTextProvider_i::has_same (ExternalID id) {
	//#UC START# *5582C01300CB_4C5ADDD20234*
	const GblPilot::BlockInfo*  result = get_block_info_by_id (id);

	if (!result) {
		return false;
	}
	return result->has_similar;
	//#UC END# *5582C01300CB_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
void DocumentTextProvider_i::remove_child_comment (const EntryPoint& id) {
	//#UC START# *4CC5505001CE_4C5ADDD20234*
	DocItem& item = this->get_item (id);
	item.reset_comment_flag ();
	m_facade->remove_comment (item.id ());
	//#UC END# *4CC5505001CE_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
void DocumentTextProvider_i::set_child_comment (
	const EntryPoint& id
	, const EVDStream* comment
) /*throw (
	InvalidEntryPoint
)*/ {
	//#UC START# *4C5AB859016E_4C5ADDD20234*
	GDS_ASSERT (comment);

	m_comments [id] = const_cast <GCI::IO::Stream*> (comment); // надо захватывать comment без увеличения счетчика ссылок, 
	                                                           // иначе течет, такие у нас tie
	                                                           
	GCI::IO::Stream* stream = const_cast <GCI::IO::Stream*> (comment);
	unsigned long start_pos = stream->seek (0, GCI::IO::SSD_CURRENT);
	
	GCD::SeqOctet server_comment;
	server_comment.length (stream->seek (0, GCI::IO::SSD_END));
	stream->seek (0, GCI::IO::SSD_BEGIN);
	stream->read (server_comment.get_buffer (), server_comment.length ());
	stream->seek (start_pos, 0);

	DocItem& item = this->get_item (id);
	m_facade->set_comment (item.id (), server_comment);
	item.set_comment_flag ();
	//#UC END# *4C5AB859016E_4C5ADDD20234*
}

// implemented method from DocumentTextProvider
// Нужно ли показывать иконку для блока на сабпанели
bool DocumentTextProvider_i::show_sub_panel_icon (ExternalID id) {
	//#UC START# *51E40487028B_4C5ADDD20234*
	const GblPilot::BlockInfo*  result = get_block_info_by_id (id);

	if (!result) {
		return false;
	}
	return (result->has_correspondent || result->has_similar);
	//#UC END# *51E40487028B_4C5ADDD20234*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

